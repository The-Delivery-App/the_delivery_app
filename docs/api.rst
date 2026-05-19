API Endpoints
=============
 
The server exposes endpoints that the Flutter app calls directly — no raw HTTP needed

Greeting
--------
 
``client.greeting.hello(name)`` — a simple ping to check the server is up and responding. Handy during development.
 
Feed
----
 
The feed endpoint is what powers the main browse screen. It can:
 
- Return a paginated chunk of food items and restaurants for a given location
- Apply filters — tags, price tier, sort order
- Fetch the details of a specific food item
- Fetch the details of a specific restaurant
- Return the list of available municipalities so the app knows what areas to show
 
Orders
------
 
- Place a new order
- Get the current status of an order
- Update an order's status (used by the server and courier side)
- Fetch a user's full order history
- Push an updated courier location to an active order (this is how live tracking works)
 
Restaurants
-----------
 
- Fetch a restaurant's full menu
- Fetch restaurant details by ID
 
Couriers
--------
 
- Register as a courier
- Accept an incoming order
- Update the delivery status as the order progresses
 
Favourites
----------
 
- Add or remove a food item or restaurant from a user's favourites
- Fetch the full favourites list for a user
 
Reviews
-------
 
- Submit a review for a food item
- Fetch all reviews for a food item
 
User Profile
------------
 
- Fetch the current user's profile
- Update profile details
- Add, edit, or remove a saved delivery address
 
Auth
----
 
Authentication is handled by Serverpod's built-in identity provider (IDP). The Flutter app uses the ``serverpod_auth_idp_flutter`` package to manage sign-in and keep sessions alive.