"""
Flask App file for the CornellFindIt App containing the API Routes

Authors: Michael Gaile and Andro Janashia
Date: 12/1/2023
"""
import json

from db import db
from db import *
from flask import Flask
from flask import request
import os
from dotenv import load_dotenv
from locations import LOCATIONS
from constants import PASSWORD

load_dotenv()

db_filename = "images.db"
app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

os.environ.get("")


db.init_app(app)
with app.app_context():
    db.create_all()


# generalized response formats
def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code


# -- IMPORTANT ROUTES ------------------------------------------------------


@app.route("/items/")
def get_items():
    """
    Endpoint for getting all items
    """
    items = [item.serialize() for item in Item.query.all()]
    return success_response({"items":items})


@app.route("/items/", methods=["POST"])
def create_items():
    """
    Endpoint for creating a new task.

    Ex:
    {
    "desc" : [STRING DESCRIPTION],          # Optional, default: "No description provided"
    "image_data": [STRING BASE64],          # Must start with "data:image/jpeg;base64,"
    "loc_desc": [STRING DESCRIPTION],       # Optional, default: "No location description provided"
    "status": [STRING STATUS],              # Optional, default: "Lost"
    "contact": [STRING CONTACT],            # Optional, default: "No contact provided"
    "loc_name": [STRING LOCATION NAME],     # Must be a valid location name. See LOCATIONS for all location names
    "time": [STRING DATETIME],              # Optional, default: str(datetime.datetime.now())
    }
    """    
    # Loads request and uploads the image =
    body = json.loads(request.data)
    image_data = body.get("image_data")
    imageUrl = upload(image_data) 
    
    # Finds the correct location and grabs the location id
    loc_name = body.get("loc_name")
    location = Location.query.filter_by(building_name=loc_name).first()
    if location is None:
        return failure_response("Location not found")
    loc_id = location.serialize()["id"]
    
    # Creates a new Item and adds to the database
    new_item = Item(desc = body.get("desc"), loc_desc=body.get("loc_desc"), time=body.get("time"), 
                    status = body.get("status"), contact = body.get("contact"), loc_id=loc_id, imageUrl = imageUrl)
    db.session.add(new_item)
    db.session.commit()
    
    return success_response(new_item.serialize(), 201)


# -- ADDITIONAL ROUTES ------------------------------------------------------


@app.route("/items/<int:item_id>/")
def get_item(item_id):
    """
    Endpoint for getting a item by id
    """
    item = Item.query.filter_by(id=item_id).first()
    if item is None:
        return failure_response("Item not found!")
    return success_response(item.serialize())


@app.route("/items/<int:item_id>/<string:password>/", methods=["DELETE"])
def delete_item(item_id, password):
    """
    Endpoint for deleting a item by id
    """
    if password != PASSWORD:
        return failure_response("Unauthorized Access", 401)
    
    item = Item.query.filter_by(id=item_id).first()
    if item is None:
        return failure_response("Item not found!")
    db.session.delete(item)
    db.session.commit()
    return success_response(item.serialize())


@app.route("/items/<int:loc_id>/")
def get_items_by_loc_id(loc_id):
    """
    Get items associated with a specific location id.
    """
    location = Location.query.filter_by(id=loc_id).first()
    if location is None:
        return failure_response("Location not found!")
    return success_response(location.serialize()["items"])


@app.route("/items/<string:loc_name>/")
def get_items_by_loc_name(loc_name):
    """
    Get items associated with a specific building name
    """
    location = Location.query.filter_by(building_name=loc_name).first()
    if location is None:
        return failure_response("Location not found!")
    return success_response(location.serialize()["items"])


@app.route("/locations/")
def get_all_locations():
    """
    Gets all locations
    """
    locations = [loc.serialize() for loc in Location.query.all()]
    return success_response({"locations":locations})


@app.route("/locations/<string:building_code>/")
def get_location_by_code(building_code):
    """
    Get location by code.
    """
    location = Location.query.filter_by(building_code=building_code).first()
    if location is None:
        return failure_response("Location not found!")
    return location.serialize()


@app.route("/")
def base_route():
    """
    Endpoint for returning the base empty route. Used for debugging.
    """
    return success_response("Hello! This is the CornellFindIt base endpoint! Download our app on the Apple Appstore!")


@app.route("/locations/startup/<string:password>/", methods = ['POST'])
def create_locations(password):
    """
    Endpoint for prepopulating the Locations table. Do not run more than once per database.
    """
    if password != PASSWORD:
        return failure_response("Unauthorized Access", 401)
    
    for key in LOCATIONS.keys():
        new_location = Location(
            building_name = LOCATIONS[key],
            building_code = key,
        )
        db.session.add(new_location)

    db.session.commit()
    return success_response("Locations Added!")


# -- Helper Functions ------------------------------------------------------


def get_loc(loc_id):
    """
    Returns Location Name from ID
    """
    loc = Location.query.filter_by(id=loc_id).first()
    if loc is None:
        return failure_response("Location not found!")
    return loc.serialize()["building_name"]


def upload(image_data):
    """
    Uploads an image to AWS given its base64 form,
    then storing/returning the URL of that image
    """
    if image_data is None:
        return failure_response("Image_data is None")
    
    # Create new ItemImage object
    myimage = ItemImage(image_data = image_data)
    db.session.add(myimage)
    db.session.commit()
    url = myimage.serialize()
    return myimage.serialize()


# -- End ------------------------------------------------------


if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8000))
    app.run(host="0.0.0.0", port=port)