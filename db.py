"""
Database file containing the important classes and tables for the CornellFindIt app.

Authors: Michael Gaile and Andro Janashia
Date: 12/1/2023
"""
from flask_sqlalchemy import SQLAlchemy
import base64
import boto3
import datetime
import io
from io import BytesIO
from mimetypes import guess_extension, guess_type
import os
from PIL import Image
import random
import re
import string
from constants import *

db = SQLAlchemy()


class Location(db.Model):
    """
    Location model. This class represents an instance of a cornell location.
    No locations should be added other than through the /locations/startup route.
    """
    __tablename__ = "location"
    id = db.Column(db.Integer, primary_key=True, autoincrement = True)
    building_name = db.Column(db.String, nullable=False)
    building_code = db.Column(db.String, nullable=False)
    items = db.relationship("Item", cascade="delete")


    def __init__(self, **kwargs):
        """
        Initialize a Location Object.
        """        
        self.building_name = kwargs.get("building_name")
        self.building_code = kwargs.get("building_code")


    def serialize(self):
        """
        Serialize a Location Object
        """
        return {
            "id": self.id,
            "building_name" : self.building_name,
            "building_code" : self.building_code,
            "items" : [r.simpleSerialize() for r in self.items]
        }


class Item(db.Model):
    """
    Item Model. This class represents an Item Object which can be either lost or found.
    """
    __tablename__ = "item"
    id = db.Column(db.Integer, primary_key = True, autoincrement = True)
    desc = db.Column(db.String, nullable = False)
    loc_desc = db.Column(db.String, nullable = False)
    time = db.Column(db.String, nullable = False)
    status = db.Column(db.String, nullable = False)
    contact = db.Column(db.String, nullable = True)
    imageUrl = db.Column(db.String, nullable=False)
    
    loc_id = db.Column(db.Integer, db.ForeignKey("location.id"), nullable=False)


    def __init__(self, **kwargs):
            """
            Initialize item object
            """
            self.desc = kwargs.get("desc", "No description provided")
            self.loc_desc = kwargs.get("loc_desc", "No location description provided")
            self.time = kwargs.get("time", str(datetime.datetime.now()))
            self.status = kwargs.get("status", "Lost")
            self.contact = kwargs.get("contact", "No contact provided")
            self.imageUrl = kwargs.get("imageUrl")
            self.loc_id = kwargs.get('loc_id')


    def serialize(self):
        """
        Serialize a item object
        """
        return {
            "id" : self.id,
            "imageUrl" : self.imageUrl,
            "desc" : self.desc,
            "loc_desc" : self.loc_desc,
            "time" : self.time,
            "status" : self.status,
            "contact" : self.contact,
            "loc_id" : self.loc_id,
            'building_name' : self.get_loc(self.loc_id)
            }
            
            
    def simpleSerialize(self):
        """
        Serialize a item object without general location information
        """
        return {
            "id" : self.id,
            "imageUrl" : self.imageUrl,
            "desc" : self.desc,
            "loc_desc" : self.loc_desc,
            "time" : self.time,
            "status" : self.status,
            "contact" : self.contact
            }


    def get_loc(self, loc_id):
        """
        Returns Location Name given a location ID
        """
        loc = Location.query.filter_by(id=loc_id).first()
        if loc is None:
            return "Location not found!"
        return loc.serialize()["building_name"]


class ItemImage(db.Model):
    """
    ItemImage model. This class represents an image for an item.
    It is now however, connected with the Item table.
    
    Code mostly provided by the Cornell App Dev Team.
    """
    __tablename__ = "image"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    base_url = db.Column(db.String, nullable=True)
    salt = db.Column(db.String, nullable=False)
    extension = db.Column(db.String, nullable=False)
    width = db.Column(db.Integer, nullable=False)
    height = db.Column(db.Integer, nullable=False)
    created_at = db.Column(db.DateTime, nullable=False)
    
    
    def __init__(self, **kwargs):
        """
        Initializes the ItemImage object
        """
        self.create(kwargs.get("image_data"))
        
        
    def serialize(self):
        """
        Returns the url of the item object.
        """
        self.url = f"{self.base_url}/{self.salt}.{self.extension}"
        return self.url

        
    def create(self,image_data):
        """
        Given image in base-64 form:
        1. Rejects image if is not a supported file type
        2. Generate a random string for filename
        3. Decode the image and attempts to upload to aws
        """
        try:
            ext = guess_extension(guess_type(image_data)[0])[1:]
            
            if ext not in EXTENSIONS:
                raise Exception("Extension {ext} not supported!")
            
            # generate random string
            salt = "".join(
                random.SystemRandom().choice(
                    string.ascii_uppercase + string.digits
                )
                for _ in range(16)
            )
            
            # remove header of base 64
            img_str = re.sub("^data:image/.+;base64,","",image_data)
            img_data = base64.b64decode(img_str)
            img = Image.open(BytesIO(img_data))
            
            self.base_url = S3_BASE_URL
            self.salt = salt
            self.extension = ext
            self.width = img.width
            self.height = img.height
            self.created_at = datetime.datetime.now()
            
            img_filename = f"{self.salt}.{self.extension}"
            self.upload(img, img_filename)
            
        except Exception as e:
            print("Could not create image", e.args)
    
    
    def upload(self, img, img_filename):
        """
        Uploads an image to aws given an Image object, img, and a filename, img_filename
        """
        try:
            # Save image tempororialy on server
            img_temploc = f"{BASE_DIR}/{img_filename}"
            img.save(img_temploc)
            
            # Uplaod to s3
            s3_client = boto3.client("s3")
            s3_client.upload_file(img_temploc, S3_BUCKET_NAME, img_filename)
            
            # make s3 image public
            s3resource = boto3.resource('s3')
            object_acl = s3resource.ObjectAcl(S3_BUCKET_NAME, img_filename)
            object_acl.put(ACL = "public-read")
            
            os.remove(img_temploc)
        except Exception as e:
            print("Could not upload image", e.args)