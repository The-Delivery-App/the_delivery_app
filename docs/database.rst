Database
========
 
We use PostgreSQL through Serverpod. This is what the main tables are and what they hold.
 
Users and addresses
-------------------
 
user
  Registered user accounts with authentication details and profile info.
 
address
  Delivery addresses saved to a user's account, including street, city, and coordinates.
 
Restaurants and food
--------------------
 
restaurant
  Restaurant profiles — name, location, and general metadata.
 
restaurant_place
  A specific branch of a restaurant. A restaurant can have multiple locations, each stored here.
 
food_item
  The menu items themselves. Each one has:
 
  - ``foodName`` — what it's called
  - ``foodPrice`` — how much it costs
  - ``foodRating`` — its average rating
  - ``foodThumbnail`` — image URL
  - ``description`` — a short description
  - ``nutritionCals`` — calorie count
  - ``estimatedOrders`` — a rough popularity count
 
tag / food_tag
  Tags like "vegan" or "spicy" that get attached to food items so users can filter them.
 
Orders
------
 
order
  The main order record. It tracks everything: who ordered, from where, the delivery address, which courier picked it up, all the pricing fields (subtotal, fees, discount, total), the current status, estimated and actual delivery times, whether it's a split order, and the courier's live coordinates.
 
order_item
  The individual dishes within an order — what was ordered, how many, and at what price.
 
order_status / order_status_history
  An enum of possible statuses and a history table that logs every status change so you can see the full timeline of an order.
 
Payments
--------
 
payment
  Payment records tied to an order.
 
split_payment_participant
  When an order is split, this table tracks each person involved and their share of the cost.
 
Everything else
---------------
 
basket
  Temporary storage for a user's basket before they actually place an order.
 
courier
  Courier account data.
 
food_review
  Reviews left by users on food items after their order arrives.
 
special_deals
  Promotional deals that restaurants can run.
 
user_favourite
  The food items and restaurants a user has saved to their favourites.
 