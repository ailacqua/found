Cornell FindIt Backend Development

These files use SQLAlchemy and Flask to implement a database and API for the Cornell FindIt app.

Authors: Michael Gaile, Andro Janashia, Cornell App Dev team
Published: 12/1/2023

API Specification

EXTERNAL IP: 34.150.237.6
PORTS: 80:8000
ROUTES:

GET	 /items/
Returns all items

GET	/items/<int:item_id>/
Gets an item by its ID

GET	/items/<int:loc_id>/
Gets all items associated with one location id

GET	/items/<string:loc_name>/
Gets all items associated with one location name

POST	/items/
Creates a new item

{
    "desc" : [STRING DESCRIPTION],          # Optional, default: "No description provided"
    "image_data": [STRING BASE64],          # Must start with "data:image/jpeg;base64,"
   	    "loc_desc": [STRING DESCRIPTION],       # Optional, default: "No location description provided"
    "status": [STRING STATUS],               # Optional, default: "Lost"
    "contact": [STRING CONTACT],            # Optional, default: "No contact provided"
    "loc_name": [STRING LOCATION NAME],     # Must be a valid location name.
    "time": [STRING DATETIME],              # Optional, default: str(datetime.datetime.now())
    }

DELETE    /items/<int:item_id>/<string:password>/
Deletes an item

GET	/locations/
Gets all locations

GET	/locations/<string:building_code>/
Gets location by its building code

POST	/locations/startup/<string:password>/
Designed for pre-populating the database with the necessary location

GET	/
Shows the default message, used for debugging
