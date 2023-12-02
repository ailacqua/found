# Found
AppDev Hack Challenge 2023 Lost and Found App

>Frontend: Alex Ilacqua, Rohan Sedhain

>Backend: Michael Gaile, Andro Janashia

>Design: Jeremy Kang

Date Completed: 12/1/2023




1. Cornell FoundIt

2. Cornell's lost and found

3. Screenshots:
   https://cornellfindit.s3.us-east-1.amazonaws.com/1QU2K6D0RYLY6QBX.png

  https://cornellfindit.s3.us-east-1.amazonaws.com/A7PSU6NSUQZ5F60O.png

  https://cornellfindit.s3.us-east-1.amazonaws.com/7Q6O8EN3BECLOZA7.png

4.--

5. An app where users can report lost items or post found items. Users can upload an item with location, description, image, and share their contact info. Using contact info, users can ensure the item gets to the proper owner.

6. For the backend requirements we have 8 requests outlined in the API specification. Some of them are: a GET request for returning all the Cornell locations, a GET request for all Items, a DEL request for an item and a POST request to add an item to the database. We have 3 tables in the database: Locations, Images, and Items. Locations and Items have a One-to-Many relationship because many items can be found/lost at one location.

7. FoundIt has a found/lost item collection view, a detailed view of the item, and a view where the user can add a found or lost item. 

8. The Found/Lost item collection view is a scrollable view and is the main screen for FoundIt

9. The Found/Lost item collection view cells are fetched through a get request that fetches the items using Postman. The Found/Lost post-VC uses a post request to post the item in Postman.
