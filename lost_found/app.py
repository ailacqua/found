import json

from db import db
from flask import Flask, request
from db import Item
from db import Location
from locations import LOCATIONS
import os
 

# define db filename
db_filename = "lost.db"
app = Flask(__name__)

# setup config
app.config["SQLALCHEMY_DATABASE_URI"] = f"sqlite:///{db_filename}"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

# initialize app
db.init_app(app)
with app.app_context():
    db.create_all()


# generalized response formats
def success_response(data, code=200):
    return json.dumps(data), code


def failure_response(message, code=404):
    return json.dumps({"error": message}), code


# -- TASK ROUTES ------------------------------------------------------


@app.route("/")
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
    "desc" : [ITEM DESCRIPTION],
    
    }
    """
    body = json.loads(request.data)

    location = Location.query.filter_by(building_name=body.get("loc_name")).first()
    loc_id = location.serialize()["id"]
    new_item = Item(desc = body.get("desc"), loc_desc=body.get("loc_desc"), time=body.get("time"), 
                    status = body.get("status"), contact = body.get("contact"), loc_id=loc_id)
    db.session.add(new_item)
    db.session.commit()
    return success_response(new_item.serialize(), 201)



@app.route("/items/<int:item_id>/")
def get_item(item_id):
    """
    Endpoint for getting a item by id
    """
    item = Item.query.filter_by(id=item_id).first()
    if item is None:
        return failure_response("Item not found!")
    return success_response(item.serialize())



@app.route("/items/<int:item_id>/", methods=["DELETE"])
def delete_item(item_id):
    """
    Endpoint for deleting a item by id
    """
    item = Item.query.filter_by(id=item_id).first()
    if item is None:
        return failure_response("Item not found!")
    db.session.delete(item)
    db.session.commit
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


# -- SUBTASK ROUTES ---------------------------------------------------


@app.route("/locations/")
def get_all_locations():
    """
    Gets all locations
    """
    locations = [loc.serialize() for loc in Location.query.all()]
    return success_response({"locations":locations})

@app.route("/locations/<string:building_code>/")
def get_location_id_by_code(building_code):
    """
    Get id of location by code.
    """

    location = Location.query.filter_by(building_code=building_code).first()
    if location is None:
        return failure_response("Location not found!")
    return location.serialize()["id"]

#@app.route("/upload/", methods=["POST"])
#def upload():
    """
    Endpoint for uploading an image to AWS given its base64 form,
    then storing/returning the URL of that image
    """

@app.route("/locations/<int:loc_id>/")
def get_loc(loc_id):
    """
    Endpoint for getting a item by id
    """
    loc = Location.query.filter_by(id=loc_id).first()
    if loc is None:
        return failure_response("Location not found!")
    return success_response(loc.serialize())

@app.route("/locations/startup/")
def create_locations():
    """
    Creates the location table
    """

    for key in LOCATIONS.keys():
        new_location = Location(
            building_name = LOCATIONS[key],
            building_code = key,
        )
        db.session.add(new_location)
      
    db.session.commit()
    return success_response("Locations added!")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)

