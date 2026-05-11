-- Seed data for the_delivery_app database
-- This file contains test data for restaurants, restaurant places, and food items
-- Data only inserts if tables are empty (idempotent)

BEGIN;

-- Only seed if restaurant table is empty
DO $$
BEGIN
  IF (SELECT COUNT(*) FROM restaurant) = 0 THEN
    INSERT INTO "restaurant" ("restName", "logoThumb", "estimatedDeliveryTime", "cuisine") VALUES
    ('Sushi Palace', '../the_delivery_app_lutter/assets/rest_logos/Untitled 2001.jpg', 25, 'Japanese'),
    ('Pizza Hub', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2002.jpg', 30, 'Italian'),
    ('Thai Express', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2003.jpg', 20, 'Thai'),
    ('Dragon Wok', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2004.jpg', 35, 'Chinese'),
    ('Bombay Spice', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2005.jpg', 40, 'Indian'),
    ('Pho Garden', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2006.jpg', 25, 'Vietnamese'),
    ('Golden Chopsticks', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2007.jpg', 30, 'Chinese'),
    ('Tokyo Grill', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2008.jpg', 25, 'Japanese'),
    ('Curry Leaf', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2009.jpg', 35, 'Indian'),
    ('Saigon Street', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2010.jpg', 20, 'Vietnamese'),
    ('Lotus Thai', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2011.jpg', 25, 'Thai'),
    ('Mandarin House', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2012.jpg', 30, 'Chinese'),
    ('Sakura Sushi', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2013.jpg', 25, 'Japanese'),
    ('Spice Route', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2014.jpg', 40, 'Indian'),
    ('Bamboo Bowl', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2015.jpg', 20, 'Vietnamese'),
    ('Bangkok Bites', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2016.jpg', 25, 'Thai'),
    ('Red Lantern', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2017.jpg', 30, 'Chinese'),
    ('Zen Kitchen', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2018.jpg', 25, 'Japanese'),
    ('Tandoori Flame', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2019.jpg', 40, 'Indian'),
    ('Hanoi Corner', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2020.jpg', 20, 'Vietnamese'),
    ('Thai Orchid', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2021.jpg', 25, 'Thai'),
    ('Great Wall Diner', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2022.jpg', 30, 'Chinese'),
    ('Tokyo Table', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2023.jpg', 25, 'Japanese'),
    ('Spice Bazaar', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2024.jpg', 40, 'Indian'),
    ('Rice Paper Roll', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2025.jpg', 20, 'Vietnamese'),
    ('Bangkok Street', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2026.jpg', 25, 'Thai'),
    ('Panda Garden', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2027.jpg', 30, 'Chinese'),
    ('Sushi Wave', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2028.jpg', 25, 'Japanese'),
    ('Masala Magic', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2029.jpg', 40, 'Indian'),
    ('Saigon Bowl', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2030.jpg', 20, 'Vietnamese'),
    ('Thai Delight', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2031.jpg', 25, 'Thai'),
    ('China Moon', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2032.jpg', 30, 'Chinese'),
    ('Nippon Noodles', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2033.jpg', 25, 'Japanese'),
    ('Curry Kingdom', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2034.jpg', 40, 'Indian'),
    ('Viet Fresh', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2035.jpg', 20, 'Vietnamese'),
    ('Bangkok Grill', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2036.jpg', 25, 'Thai'),
    ('Golden Dragon', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2037.jpg', 30, 'Chinese'),
    ('Sushi Garden', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2038.jpg', 25, 'Japanese'),
    ('Spice Heaven', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2039.jpg', 40, 'Indian'),
    ('Saigon Express', '../the_delivery_app_flutter/assets/rest_logos/Untitled 2040.jpg', 20, 'Vietnamese');
    RAISE NOTICE 'Inserted 40 restaurants';
  ELSE
    RAISE NOTICE 'Database already seeded, skipping all inserts';
    RETURN;
  END IF;
END $$;

-- Only seed restaurant places if table is empty  
DO $$
BEGIN
  IF (SELECT COUNT(*) FROM restaurant_place) = 0 THEN
    INSERT INTO "restaurant_place" ("restId", "name", "city", "country", "postcode", "addressLine1", "addressLine2", "latitude", "longitude") VALUES
    (1, 'Sushi Palace – Southsea', 'Portsmouth', 'UK', 'PO5 3PT', '12 Elm Grove', NULL, 50.7851, -1.0892),
    (2, 'Pizza Hub – Commercial Road', 'Portsmouth', 'UK', 'PO1 1BQ', '88 Commercial Road', NULL, 50.7984, -1.0911),
    (3, 'Thai Express – Albert Road', 'Southsea', 'UK', 'PO4 0JR', '101 Albert Road', NULL, 50.7869, -1.0735),
    (4, 'Dragon Wok – North End', 'Portsmouth', 'UK', 'PO2 9BE', '45 London Road', NULL, 50.8162, -1.0678),
    (5, 'Bombay Spice – Fratton', 'Portsmouth', 'UK', 'PO1 5RS', '3 Fratton Road', NULL, 50.7962, -1.0731),
    (6, 'Pho Garden – Gunwharf', 'Portsmouth', 'UK', 'PO1 3TZ', 'Unit 14 Gunwharf Quays', NULL, 50.7968, -1.1051),
    (7, 'Golden Chopsticks – Cosham', 'Portsmouth', 'UK', 'PO6 3AG', '22 High Street', NULL, 50.8411, -1.0672),
    (8, 'Tokyo Grill – Southsea', 'Southsea', 'UK', 'PO5 2SJ', '7 Palmerston Road', NULL, 50.7834, -1.0934),
    (9, 'Curry Leaf – Milton', 'Portsmouth', 'UK', 'PO4 8PR', '19 Milton Road', NULL, 50.7991, -1.0588),
    (10, 'Saigon Street – Old Portsmouth', 'Portsmouth', 'UK', 'PO1 2JJ', '3 High Street', NULL, 50.7922, -1.1044),
    (11, 'Lotus Thai – Southsea', 'Southsea', 'UK', 'PO5 2SG', '55 Osborne Road', NULL, 50.7855, -1.0939),
    (12, 'Mandarin House – North End', 'Portsmouth', 'UK', 'PO2 9AE', '102 Kingston Road', NULL, 50.8128, -1.0735),
    (13, 'Sakura Sushi – Gunwharf', 'Portsmouth', 'UK', 'PO1 3TZ', 'Unit 28 Gunwharf Quays', NULL, 50.7965, -1.1048),
    (14, 'Spice Route – Fratton', 'Portsmouth', 'UK', 'PO1 5DL', '66 Fratton Road', NULL, 50.7969, -1.0739),
    (15, 'Bamboo Bowl – Southsea', 'Southsea', 'UK', 'PO4 0JR', '14 Albert Road', NULL, 50.7862, -1.0731),
    (16, 'Bangkok Bites – Elm Grove', 'Southsea', 'UK', 'PO5 3JJ', '33 Elm Grove', NULL, 50.7858, -1.0899),
    (17, 'Red Lantern – Cosham', 'Portsmouth', 'UK', 'PO6 3AG', '5 High Street', NULL, 50.8415, -1.0671),
    (18, 'Zen Kitchen – Palmerston', 'Southsea', 'UK', 'PO5 3PT', '21 Palmerston Road', NULL, 50.7839, -1.0931),
    (19, 'Tandoori Flame – North End', 'Portsmouth', 'UK', 'PO2 9BE', '77 London Road', NULL, 50.8151, -1.0674),
    (20, 'Hanoi Corner – Southsea', 'Southsea', 'UK', 'PO4 0JR', '9 Albert Road', NULL, 50.7865, -1.0738),
    (21, 'Thai Orchid – Gunwharf', 'Portsmouth', 'UK', 'PO1 3TZ', 'Unit 11 Gunwharf Quays', NULL, 50.7962, -1.1052),
    (22, 'Great Wall Diner – Fratton', 'Portsmouth', 'UK', 'PO1 5RS', '4 Fratton Road', NULL, 50.7961, -1.0733),
    (23, 'Tokyo Table – Southsea', 'Southsea', 'UK', 'PO5 2SG', '61 Osborne Road', NULL, 50.7852, -1.0941),
    (24, 'Spice Bazaar – Milton', 'Portsmouth', 'UK', 'PO4 8PR', '27 Milton Road', NULL, 50.7994, -1.0581),
    (25, 'Rice Paper Roll – Old Portsmouth', 'Portsmouth', 'UK', 'PO1 2JJ', '12 High Street', NULL, 50.7925, -1.1041),
    (26, 'Bangkok Street – Elm Grove', 'Southsea', 'UK', 'PO5 3JJ', '41 Elm Grove', NULL, 50.7859, -1.0895),
    (27, 'Panda Garden – Cosham', 'Portsmouth', 'UK', 'PO6 3AG', '18 High Street', NULL, 50.8413, -1.0679),
    (28, 'Sushi Wave – Palmerston', 'Southsea', 'UK', 'PO5 3PT', '29 Palmerston Road', NULL, 50.7837, -1.0937),
    (29, 'Masala Magic – North End', 'Portsmouth', 'UK', 'PO2 9BE', '88 London Road', NULL, 50.8159, -1.0672),
    (30, 'Saigon Bowl – Southsea', 'Southsea', 'UK', 'PO4 0JR', '22 Albert Road', NULL, 50.7868, -1.0732),
    (31, 'Thai Delight – Gunwharf', 'Portsmouth', 'UK', 'PO1 3TZ', 'Unit 19 Gunwharf Quays', NULL, 50.7964, -1.1050),
    (32, 'China Moon – Fratton', 'Portsmouth', 'UK', 'PO1 5DL', '72 Fratton Road', NULL, 50.7964, -1.0737),
    (33, 'Nippon Noodles – Southsea', 'Southsea', 'UK', 'PO5 2SG', '48 Osborne Road', NULL, 50.7854, -1.0943),
    (34, 'Curry Kingdom – Milton', 'Portsmouth', 'UK', 'PO4 8PR', '33 Milton Road', NULL, 50.7997, -1.0584),
    (35, 'Viet Fresh – Old Portsmouth', 'Portsmouth', 'UK', 'PO1 2JJ', '17 High Street', NULL, 50.7927, -1.1046),
    (36, 'Bangkok Grill – Elm Grove', 'Southsea', 'UK', 'PO5 3JJ', '52 Elm Grove', NULL, 50.7861, -1.0891),
    (37, 'Golden Dragon – Cosham', 'Portsmouth', 'UK', 'PO6 3AG', '25 High Street', NULL, 50.8417, -1.0675),
    (38, 'Sushi Garden – Palmerston', 'Southsea', 'UK', 'PO5 3PT', '14 Palmerston Road', NULL, 50.7833, -1.0932),
    (39, 'Spice Heaven – North End', 'Portsmouth', 'UK', 'PO2 9BE', '93 London Road', NULL, 50.8154, -1.0676),
    (40, 'Saigon Express – Southsea', 'Southsea', 'UK', 'PO4 0JR', '30 Albert Road', NULL, 50.7864, -1.0734),
    (31, 'Harbour Sushi – Gunwharf', 'Portsmouth', 'UK', 'PO1 3TZ', 'Unit 31 Gunwharf Quays', NULL, 50.7967, -1.1049),
    (31, 'Royal Tandoor – Fratton', 'Portsmouth', 'UK', 'PO1 5DL', '81 Fratton Road', NULL, 50.7963, -1.0734),
    (1, 'Pho Lantern – Southsea', 'Southsea', 'UK', 'PO5 2SG', '72 Osborne Road', NULL, 50.7853, -1.0940),
    (2, 'Bangkok Flame – Elm Grove', 'Southsea', 'UK', 'PO5 3JJ', '63 Elm Grove', NULL, 50.7860, -1.0893),
    (4, 'Dragon Pearl – Cosham', 'Portsmouth', 'UK', 'PO6 3AG', '29 High Street', NULL, 50.8416, -1.0673),
    (6, 'Sakura House – Palmerston', 'Southsea', 'UK', 'PO5 3PT', '18 Palmerston Road', NULL, 50.7835, -1.0935),
    (7, 'Curry Empire – North End', 'Portsmouth', 'UK', 'PO2 9BE', '112 London Road', NULL, 50.8157, -1.0678),
    (8, 'Viet Corner – Old Portsmouth', 'Portsmouth', 'UK', 'PO1 2JJ', '21 High Street', NULL, 50.7924, -1.1043),
    (9, 'Thai Harbour – Gunwharf', 'Portsmouth', 'UK', 'PO1 3TZ', 'Unit 44 Gunwharf Quays', NULL, 50.7969, -1.1053),
    (5, 'China Garden – Fratton', 'Portsmouth', 'UK', 'PO1 5RS', '11 Fratton Road', NULL, 50.7960, -1.0730),
    (1, 'Sushi Avenue – Southsea', 'Southsea', 'UK', 'PO4 0JR', '38 Albert Road', NULL, 50.7867, -1.0736),
    (5, 'Masala Street – Milton', 'Portsmouth', 'UK', 'PO4 8PR', '41 Milton Road', NULL, 50.7995, -1.0586),
    (5, 'Saigon Fresh – Southsea', 'Southsea', 'UK', 'PO5 2SG', '83 Osborne Road', NULL, 50.7851, -1.0944),
    (5, 'Thai Fusion – Elm Grove', 'Southsea', 'UK', 'PO5 3JJ', '71 Elm Grove', NULL, 50.7862, -1.0897),
    (5, 'Golden Wok – Cosham', 'Portsmouth', 'UK', 'PO6 3AG', '34 High Street', NULL, 50.8412, -1.0670),
    (6, 'Tokyo Street – Palmerston', 'Southsea', 'UK', 'PO5 3PT', '25 Palmerston Road', NULL, 50.7838, -1.0933),
    (7, 'Spice Mahal – North End', 'Portsmouth', 'UK', 'PO2 9AE', '121 Kingston Road', NULL, 50.8129, -1.0732),
    (8, 'Pho Station – Gunwharf', 'Portsmouth', 'UK', 'PO1 3TZ', 'Unit 52 Gunwharf Quays', NULL, 50.7963, -1.1051),
    (9, 'Bangkok House – Southsea', 'Southsea', 'UK', 'PO4 0JR', '44 Albert Road', NULL, 50.7864, -1.0739),
    (6, 'Red Dragon – Fratton', 'Portsmouth', 'UK', 'PO1 5DL', '95 Fratton Road', NULL, 50.7966, -1.0738),
    (6, 'Zen Noodle Bar – Southsea', 'Southsea', 'UK', 'PO5 2SG', '91 Osborne Road', NULL, 50.7850, -1.0942),
    (6, 'Curry Palace – Milton', 'Portsmouth', 'UK', 'PO4 8PR', '52 Milton Road', NULL, 50.7993, -1.0583),
    (6, 'Viet Street – Old Portsmouth', 'Portsmouth', 'UK', 'PO1 2JJ', '27 High Street', NULL, 50.7928, -1.1047),
    (6, 'Thai Bowl – Elm Grove', 'Southsea', 'UK', 'PO5 3JJ', '82 Elm Grove', NULL, 50.7863, -1.0890),
    (5, 'China Star – Cosham', 'Portsmouth', 'UK', 'PO6 3AG', '39 High Street', NULL, 50.8414, -1.0674),
    (6, 'Sushi Republic – Palmerston', 'Southsea', 'UK', 'PO5 3PT', '33 Palmerston Road', NULL, 50.7836, -1.0938),
    (7, 'Masala Street Kitchen – North End', 'Portsmouth', 'UK', 'PO2 9BE', '131 London Road', NULL, 50.8153, -1.0671),
    (6, 'Pho Avenue – Gunwharf', 'Portsmouth', 'UK', 'PO1 3TZ', 'Unit 61 Gunwharf Quays', NULL, 50.7961, -1.1054),
    (6, 'Bangkok Grillhouse – Southsea', 'Southsea', 'UK', 'PO4 0JR', '51 Albert Road', NULL, 50.7869, -1.0733),
    (1, 'Red Lotus – Fratton', 'Portsmouth', 'UK', 'PO1 5RS', '17 Fratton Road', NULL, 50.7965, -1.0732),
    (1, 'Zen Garden – Southsea', 'Southsea', 'UK', 'PO5 2SG', '102 Osborne Road', NULL, 50.7856, -1.0945),
    (2, 'Curry Dynasty – Milton', 'Portsmouth', 'UK', 'PO4 8PR', '63 Milton Road', NULL, 50.7998, -1.0587),
    (3, 'Viet Kitchen – Old Portsmouth', 'Portsmouth', 'UK', 'PO1 2JJ', '33 High Street', NULL, 50.7923, -1.1042),
    (4, 'Thai Republic – Elm Grove', 'Southsea', 'UK', 'PO5 3JJ', '91 Elm Grove', NULL, 50.7864, -1.0896),
    (5, 'China Express – Cosham', 'Portsmouth', 'UK', 'PO6 3AG', '47 High Street', NULL, 50.8418, -1.0678),
    (6, 'Sushi Kingdom – Palmerston', 'Southsea', 'UK', 'PO5 3PT', '40 Palmerston Road', NULL, 50.7832, -1.0934),
    (7, 'Masala Avenue – North End', 'Portsmouth', 'UK', 'PO2 9AE', '142 Kingston Road', NULL, 50.8127, -1.0736),
    (7, 'Pho Garden House – Gunwharf', 'Portsmouth', 'UK', 'PO1 3TZ', 'Unit 72 Gunwharf Quays', NULL, 50.7968, -1.1050),
    (7, 'Bangkok Express – Southsea', 'Southsea', 'UK', 'PO4 0JR', '59 Albert Road', NULL, 50.7861, -1.0737),
    (8, 'Red Dragon Bowl – Fratton', 'Portsmouth', 'UK', 'PO1 5DL', '108 Fratton Road', NULL, 50.7967, -1.0735);
    RAISE NOTICE 'Inserted 40 restaurant places';
  ELSE
    RAISE NOTICE 'Database already seeded with restaurant places, skipping insert';
  END IF;
END $$;

-- Only seed food items if table is empty
DO $$
BEGIN
  IF (SELECT COUNT(*) FROM food_item) = 0 THEN
    INSERT INTO "food_item" ("restId", "foodName", "foodPrice", "foodRating", "foodThumbnail", "description", "nutritionCals", "estimatedOrders", "createdAt") VALUES
    (1, 'Salmon Nigiri', 6.50, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2003.jpg', 'Fresh salmon over rice', 120, 0, '2026-05-08T15:25:00'),
    (2, 'Pepperoni Pizza', 12.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2012.jpg', 'Classic pepperoni slice', 890, 0, '2026-05-08T15:25:00'),
    (3, 'Pad Thai', 10.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2008.jpg', 'Stir-fried noodles', 650, 0, '2026-05-08T15:25:00'),
    (4, 'Sweet & Sour Chicken', 9.99, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2019.jpg', 'Crispy chicken bites', 720, 0, '2026-05-08T15:25:00'),
    (5, 'Butter Chicken', 11.50, 4.8, '../the_delivery_app_flutter/assets/food_logos/Untitled 2005.jpg', 'Creamy tomato curry', 780, 0, '2026-05-08T15:25:00'),
    (6, 'Pho Noodle Soup', 9.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2020.jpg', 'Vietnamese broth noodles', 430, 0, '2026-05-08T15:25:00'),
    (7, 'Kung Pao Chicken', 10.75, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2009.jpg', 'Spicy chicken & peanuts', 610, 0, '2026-05-08T15:25:00'),
    (8, 'Sushi Roll Combo', 13.50, 4.9, '../the_delivery_app_flutter/assets/food_logos/Untitled 2001.jpg', 'Assorted rolls', 480, 0, '2026-05-08T15:25:00'),
    (9, 'Chicken Tikka Masala', 11.25, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2015.jpg', 'Grilled chicken curry', 760, 0, '2026-05-08T15:25:00'),
    (10, 'Spring Rolls', 5.50, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2023.jpg', 'Crispy veg rolls', 220, 0, '2026-05-08T15:25:00'),
    (11, 'Green Curry', 10.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2007.jpg', 'Thai coconut curry', 540, 0, '2026-05-08T15:25:00'),
    (12, 'Beef Chow Mein', 9.75, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2010.jpg', 'Stir-fried noodles', 680, 0, '2026-05-08T15:25:00'),
    (13, 'Tempura Udon', 8.99, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2024.jpg', 'Udon with tempura', 520, 0, '2026-05-08T15:25:00'),
    (14, 'Lamb Rogan Josh', 12.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2004.jpg', 'Rich lamb curry', 810, 0, '2026-05-08T15:25:00'),
    (15, 'Banh Mi', 7.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2013.jpg', 'Vietnamese sandwich', 450, 0, '2026-05-08T15:25:00'),
    (16, 'Tom Yum Soup', 6.75, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2006.jpg', 'Spicy Thai soup', 310, 0, '2026-05-08T15:25:00'),
    (17, 'Dim Sum Platter', 9.50, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2018.jpg', 'Steamed dumplings', 390, 0, '2026-05-08T15:25:00'),
    (18, 'Ramen Bowl', 10.25, 4.8, '../the_delivery_app_flutter/assets/food_logos/Untitled 2002.jpg', 'Noodle soup', 560, 0, '2026-05-08T15:25:00'),
    (19, 'Paneer Masala', 10.99, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2014.jpg', 'Creamy paneer curry', 740, 0, '2026-05-08T15:25:00'),
    (20, 'Vermicelli Bowl', 8.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2022.jpg', 'Rice noodles & herbs', 420, 0, '2026-05-08T15:25:00'),
    (21, 'Thai Basil Chicken', 9.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2008.jpg', 'Spicy basil stir-fry', 590, 0, '2026-05-08T15:25:00'),
    (22, 'Sweet Chili Pork', 10.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2011.jpg', 'Pork in chili glaze', 670, 0, '2026-05-08T15:25:00'),
    (23, 'Sashimi Set', 14.25, 4.9, '../the_delivery_app_flutter/assets/food_logos/Untitled 2003.jpg', 'Fresh sliced fish', 430, 0, '2026-05-08T15:25:00'),
    (24, 'Chicken Korma', 11.75, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2021.jpg', 'Mild creamy curry', 720, 0, '2026-05-08T15:25:00'),
    (25, 'Beef Pho', 9.25, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2009.jpg', 'Beef noodle soup', 460, 0, '2026-05-08T15:25:00'),
    (26, 'Thai Fried Rice', 8.99, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2001.jpg', 'Egg fried rice', 580, 0, '2026-05-08T15:25:00'),
    (27, 'Kung Pao Shrimp', 11.25, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2016.jpg', 'Shrimp & peanuts', 610, 0, '2026-05-08T15:25:00'),
    (28, 'Tonkotsu Ramen', 10.99, 4.8, '../the_delivery_app_flutter/assets/food_logos/Untitled 2024.jpg', 'Pork broth ramen', 590, 0, '2026-05-08T15:25:00'),
    (29, 'Chicken Biryani', 12.50, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2005.jpg', 'Spiced rice dish', 820, 0, '2026-05-08T15:25:00'),
    (30, 'Fresh Spring Rolls', 6.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2017.jpg', 'Rice paper rolls', 240, 0, '2026-05-08T15:25:00'),
    (31, 'Thai Red Curry', 10.75, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2006.jpg', 'Spicy coconut curry', 560, 0, '2026-05-08T15:25:00'),
    (32, 'Chow Fun', 9.99, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2010.jpg', 'Wide rice noodles', 640, 0, '2026-05-08T15:25:00'),
    (33, 'Tempura Don', 9.50, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2023.jpg', 'Tempura over rice', 520, 0, '2026-05-08T15:25:00'),
    (34, 'Paneer Tikka', 10.25, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2007.jpg', 'Grilled paneer', 610, 0, '2026-05-08T15:25:00'),
    (35, 'Bun Cha', 8.99, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2012.jpg', 'Vietnamese pork noodles', 430, 0, '2026-05-08T15:25:00'),
    (36, 'Thai Omelette', 7.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2004.jpg', 'Crispy egg omelette', 380, 0, '2026-05-08T15:25:00'),
    (37, 'Beef Stir Fry', 10.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2019.jpg', 'Beef & veg stir fry', 620, 0, '2026-05-08T15:25:00'),
    (38, 'Sushi Box', 13.75, 4.8, '../the_delivery_app_flutter/assets/food_logos/Untitled 2002.jpg', 'Mixed sushi box', 480, 0, '2026-05-08T15:25:00'),
    (39, 'Chicken Madras', 11.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2014.jpg', 'Spicy curry', 780, 0, '2026-05-08T15:25:00'),
    (40, 'Pho Special', 9.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2020.jpg', 'Special pho bowl', 450, 0, '2026-05-08T15:25:00'),
    (1, 'Tuna Maki', 5.99, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2004.jpg', 'Simple tuna roll', 180, 0, '2026-05-08T15:25:00'),
    (2, 'Margherita Slice', 10.50, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2017.jpg', 'Cheese & tomato', 760, 0, '2026-05-08T15:25:00'),
    (3, 'Thai Cashew Chicken', 9.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2009.jpg', 'Chicken & cashews', 620, 0, '2026-05-08T15:25:00'),
    (4, 'Beef Fried Rice', 8.99, 4.1, '../the_delivery_app_flutter/assets/food_logos/Untitled 2022.jpg', 'Rice with beef', 690, 0, '2026-05-08T15:25:00'),
    (5, 'Chicken Korma', 10.99, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2006.jpg', 'Mild creamy curry', 720, 0, '2026-05-08T15:25:00'),
    (6, 'Bun Bo Hue', 9.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2013.jpg', 'Spicy noodle soup', 480, 0, '2026-05-08T15:25:00'),
    (7, 'Beef & Broccoli', 10.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2001.jpg', 'Beef stir fry', 610, 0, '2026-05-08T15:25:00'),
    (8, 'California Roll', 6.75, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2020.jpg', 'Crab & avocado', 210, 0, '2026-05-08T15:25:00'),
    (9, 'Dal Tadka', 8.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2018.jpg', 'Yellow lentil curry', 430, 0, '2026-05-08T15:25:00'),
    (10, 'Prawn Toast', 6.25, 4.0, '../the_delivery_app_flutter/assets/food_logos/Untitled 2007.jpg', 'Crispy prawn bites', 260, 0, '2026-05-08T15:25:00'),
    (11, 'Thai Beef Salad', 9.75, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2011.jpg', 'Spicy beef salad', 390, 0, '2026-05-08T15:25:00'),
    (12, 'Chicken Lo Mein', 9.50, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2023.jpg', 'Soft egg noodles', 640, 0, '2026-05-08T15:25:00'),
    (13, 'Chicken Katsu', 9.99, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2003.jpg', 'Crispy chicken cutlet', 540, 0, '2026-05-08T15:25:00'),
    (14, 'Chana Masala', 8.25, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2014.jpg', 'Chickpea curry', 510, 0, '2026-05-08T15:25:00'),
    (15, 'Vietnamese Iced Coffee', 4.50, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2005.jpg', 'Strong sweet coffee', 190, 0, '2026-05-08T15:25:00'),
    (16, 'Thai Coconut Soup', 6.99, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2024.jpg', 'Creamy soup', 330, 0, '2026-05-08T15:25:00'),
    (17, 'Pork Dumplings', 7.25, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2002.jpg', 'Steamed dumplings', 280, 0, '2026-05-08T15:25:00'),
    (18, 'Spicy Miso Ramen', 10.75, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2010.jpg', 'Miso broth ramen', 570, 0, '2026-05-08T15:25:00'),
    (19, 'Aloo Gobi', 8.50, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2008.jpg', 'Potato & cauliflower', 420, 0, '2026-05-08T15:25:00'),
    (20, 'Bun Thit Nuong', 9.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2019.jpg', 'Grilled pork noodles', 460, 0, '2026-05-08T15:25:00'),
    (21, 'Thai Stir Fry', 9.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2009.jpg', 'Veg & chicken stir fry', 580, 0, '2026-05-08T15:25:00'),
    (22, 'Honey Chicken', 10.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2016.jpg', 'Sweet glazed chicken', 650, 0, '2026-05-08T15:25:00'),
    (23, 'Shrimp Tempura', 7.99, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2001.jpg', 'Crispy shrimp', 310, 0, '2026-05-08T15:25:00'),
    (24, 'Lamb Korma', 12.50, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2021.jpg', 'Creamy lamb curry', 820, 0, '2026-05-08T15:25:00'),
    (25, 'Pho Tai', 9.50, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2004.jpg', 'Rare beef pho', 450, 0, '2026-05-08T15:25:00'),
    (26, 'Thai Omelette Rice', 7.99, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2012.jpg', 'Egg over rice', 520, 0, '2026-05-08T15:25:00'),
    (27, 'Beef Chow Fun', 10.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2007.jpg', 'Wide noodles & beef', 640, 0, '2026-05-08T15:25:00'),
    (28, 'Chicken Teriyaki', 10.25, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2020.jpg', 'Teriyaki glaze', 590, 0, '2026-05-08T15:25:00'),
    (29, 'Vegetable Biryani', 9.99, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2015.jpg', 'Spiced veg rice', 690, 0, '2026-05-08T15:25:00'),
    (30, 'Vietnamese Rolls', 6.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2003.jpg', 'Fresh rolls', 230, 0, '2026-05-08T15:25:00'),
    (31, 'Thai Red Noodles', 9.75, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2018.jpg', 'Spicy red noodles', 610, 0, '2026-05-08T15:25:00'),
    (32, 'Chicken Fried Noodles', 9.25, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2006.jpg', 'Stir-fried noodles', 650, 0, '2026-05-08T15:25:00'),
    (33, 'Katsu Don', 9.99, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2024.jpg', 'Chicken over rice', 540, 0, '2026-05-08T15:25:00'),
    (34, 'Tandoori Chicken', 11.50, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2002.jpg', 'Clay oven chicken', 780, 0, '2026-05-08T15:25:00'),
    (35, 'Pho Ga', 9.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2010.jpg', 'Chicken pho', 430, 0, '2026-05-08T15:25:00'),
    (36, 'Thai Stir Veg', 8.50, 4.1, '../the_delivery_app_flutter/assets/food_logos/Untitled 2008.jpg', 'Mixed veg stir fry', 350, 0, '2026-05-08T15:25:00'),
    (37, 'Beef Noodle Bowl', 10.50, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2019.jpg', 'Beef & noodles', 620, 0, '2026-05-08T15:25:00'),
    (38, 'Sushi Trio', 7.99, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2005.jpg', 'Three-piece sushi', 260, 0, '2026-05-08T15:25:00'),
    (39, 'Chicken Vindaloo', 11.99, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2014.jpg', 'Spicy curry', 820, 0, '2026-05-08T15:25:00'),
    (40, 'Pho House Special', 10.25, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2022.jpg', 'Mixed pho bowl', 470, 0, '2026-05-08T15:25:00'),
    (1, 'Ebi Tempura', 7.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2011.jpg', 'Crispy shrimp tempura', 310, 0, '2026-05-08T15:25:00'),
    (2, 'BBQ Chicken Pizza', 13.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2006.jpg', 'BBQ sauce & chicken', 920, 0, '2026-05-08T15:25:00'),
    (3, 'Thai Red Noodle Bowl', 10.25, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2023.jpg', 'Spicy red curry noodles', 640, 0, '2026-05-08T15:25:00'),
    (4, 'General Tso Chicken', 10.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2002.jpg', 'Sweet spicy chicken', 710, 0, '2026-05-08T15:25:00'),
    (5, 'Chicken Saag', 11.25, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2014.jpg', 'Spinach chicken curry', 690, 0, '2026-05-08T15:25:00'),
    (6, 'Bun Rieu', 9.75, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2008.jpg', 'Crab noodle soup', 450, 0, '2026-05-08T15:25:00'),
    (7, 'Orange Chicken', 10.50, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2019.jpg', 'Sweet citrus chicken', 680, 0, '2026-05-08T15:25:00'),
    (8, 'Spicy Tuna Roll', 6.99, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2003.jpg', 'Tuna & chili mayo', 230, 0, '2026-05-08T15:25:00'),
    (9, 'Lamb Biryani', 12.99, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2024.jpg', 'Spiced lamb rice', 840, 0, '2026-05-08T15:25:00'),
    (10, 'Chicken Gyoza', 6.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2001.jpg', 'Pan-fried dumplings', 260, 0, '2026-05-08T15:25:00'),
    (11, 'Thai Pineapple Rice', 9.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2017.jpg', 'Rice with pineapple', 580, 0, '2026-05-08T15:25:00'),
    (12, 'Shrimp Chow Mein', 10.25, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2005.jpg', 'Noodles with shrimp', 690, 0, '2026-05-08T15:25:00'),
    (13, 'Chicken Yakitori', 8.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2013.jpg', 'Grilled chicken skewers', 330, 0, '2026-05-08T15:25:00'),
    (14, 'Vegetable Korma', 9.75, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2007.jpg', 'Creamy veg curry', 610, 0, '2026-05-08T15:25:00'),
    (15, 'Vietnamese Curry', 9.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2022.jpg', 'Mild coconut curry', 540, 0, '2026-05-08T15:25:00'),
    (16, 'Thai Chicken Wings', 7.99, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2010.jpg', 'Spicy wings', 420, 0, '2026-05-08T15:25:00'),
    (17, 'Beef Dumplings', 7.50, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2004.jpg', 'Steamed beef dumplings', 300, 0, '2026-05-08T15:25:00'),
    (18, 'Shoyu Ramen', 10.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2018.jpg', 'Soy broth ramen', 540, 0, '2026-05-08T15:25:00'),
    (19, 'Chole Masala', 8.25, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2009.jpg', 'Chickpea curry', 510, 0, '2026-05-08T15:25:00'),
    (20, 'Bun Nem', 9.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2020.jpg', 'Spring roll noodles', 440, 0, '2026-05-08T15:25:00'),
    (21, 'Thai Garlic Chicken', 9.75, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2006.jpg', 'Garlic stir-fry', 600, 0, '2026-05-08T15:25:00'),
    (22, 'Crispy Pork Belly', 11.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2012.jpg', 'Crispy pork slices', 720, 0, '2026-05-08T15:25:00'),
    (23, 'Unagi Nigiri', 7.99, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2002.jpg', 'Grilled eel sushi', 260, 0, '2026-05-08T15:25:00'),
    (24, 'Chicken Jalfrezi', 11.50, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2016.jpg', 'Spicy pepper curry', 750, 0, '2026-05-08T15:25:00'),
    (25, 'Pho Bo Vien', 9.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2003.jpg', 'Meatball pho', 470, 0, '2026-05-08T15:25:00'),
    (26, 'Thai Basil Beef', 10.25, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2021.jpg', 'Beef & basil', 610, 0, '2026-05-08T15:25:00'),
    (27, 'Shrimp Fried Rice', 9.99, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2001.jpg', 'Rice with shrimp', 650, 0, '2026-05-08T15:25:00'),
    (28, 'Chicken Donburi', 9.75, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2019.jpg', 'Chicken rice bowl', 580, 0, '2026-05-08T15:25:00'),
    (29, 'Vegetable Curry', 9.25, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2005.jpg', 'Mixed veg curry', 540, 0, '2026-05-08T15:25:00'),
    (30, 'Vietnamese Chicken Salad', 8.99, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2013.jpg', 'Herb chicken salad', 350, 0, '2026-05-08T15:25:00'),
    (31, 'Thai Chili Noodles', 9.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2007.jpg', 'Spicy noodles', 620, 0, '2026-05-08T15:25:00'),
    (32, 'Beef Stir Noodles', 10.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2024.jpg', 'Beef noodle stir fry', 670, 0, '2026-05-08T15:25:00'),
    (33, 'Chicken Tempura Bowl', 9.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2004.jpg', 'Tempura chicken rice', 540, 0, '2026-05-08T15:25:00'),
    (34, 'Chicken Tikka', 11.25, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2011.jpg', 'Grilled chicken tikka', 760, 0, '2026-05-08T15:25:00'),
    (35, 'Bun Cha Hanoi', 9.50, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2008.jpg', 'Grilled pork noodles', 460, 0, '2026-05-08T15:25:00'),
    (36, 'Thai Veg Curry', 8.75, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2010.jpg', 'Vegetable curry', 520, 0, '2026-05-08T15:25:00'),
    (37, 'Beef Pho Special', 10.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2018.jpg', 'Special beef pho', 480, 0, '2026-05-08T15:25:00'),
    (38, 'Sushi Mix Plate', 12.50, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2006.jpg', 'Mixed sushi plate', 450, 0, '2026-05-08T15:25:00'),
    (39, 'Chicken Curry Bowl', 10.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2014.jpg', 'Spicy curry bowl', 720, 0, '2026-05-08T15:25:00'),
    (40, 'Pho Chicken Special', 9.75, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2022.jpg', 'Chicken pho bowl', 440, 0, '2026-05-08T15:25:00'),
    (1, 'Avocado Maki', 5.25, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2009.jpg', 'Simple veg roll', 160, 0, '2026-05-08T15:25:00'),
    (2, 'Four Cheese Pizza', 13.50, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2010.jpg', 'Cheesy goodness', 980, 0, '2026-05-08T15:25:00'),
    (3, 'Thai Yellow Curry', 10.75, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2001.jpg', 'Mild yellow curry', 620, 0, '2026-05-08T15:25:00'),
    (4, 'Beef Black Bean', 9.99, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2024.jpg', 'Beef in black bean sauce', 700, 0, '2026-05-08T15:25:00'),
    (5, 'Chicken Jalfrezi', 11.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2007.jpg', 'Pepper tomato curry', 760, 0, '2026-05-08T15:25:00'),
    (6, 'Vietnamese Fried Rice', 8.99, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2016.jpg', 'Egg fried rice', 580, 0, '2026-05-08T15:25:00'),
    (7, 'Sweet Chili Chicken', 10.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2005.jpg', 'Sweet chili glaze', 650, 0, '2026-05-08T15:25:00'),
    (8, 'Sake Nigiri', 6.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2013.jpg', 'Fresh salmon nigiri', 210, 0, '2026-05-08T15:25:00'),
    (9, 'Vegetable Curry', 9.25, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2004.jpg', 'Mixed veg curry', 540, 0, '2026-05-08T15:25:00'),
    (10, 'Crispy Wontons', 5.99, 4.1, '../the_delivery_app_flutter/assets/food_logos/Untitled 2022.jpg', 'Fried wontons', 240, 0, '2026-05-08T15:25:00'),
    (11, 'Thai Beef Stir Fry', 10.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2008.jpg', 'Beef & veg stir fry', 610, 0, '2026-05-08T15:25:00'),
    (12, 'Chicken Egg Foo Young', 9.75, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2018.jpg', 'Chinese omelette', 580, 0, '2026-05-08T15:25:00'),
    (13, 'Prawn Tempura', 7.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2006.jpg', 'Crispy prawns', 300, 0, '2026-05-08T15:25:00'),
    (14, 'Dal Makhani', 9.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2014.jpg', 'Creamy lentils', 620, 0, '2026-05-08T15:25:00'),
    (15, 'Vietnamese Curry Chicken', 10.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2002.jpg', 'Coconut curry chicken', 560, 0, '2026-05-08T15:25:00'),
    (16, 'Thai Chicken Satay', 7.75, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2011.jpg', 'Peanut sauce skewers', 390, 0, '2026-05-08T15:25:00'),
    (17, 'Vegetable Dumplings', 6.99, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2003.jpg', 'Steamed veg dumplings', 240, 0, '2026-05-08T15:25:00'),
    (18, 'Tantanmen Ramen', 10.99, 4.7, '../the_delivery_app_flutter/assets/food_logos/Untitled 2020.jpg', 'Spicy sesame ramen', 590, 0, '2026-05-08T15:25:00'),
    (19, 'Vegetable Biryani', 9.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2001.jpg', 'Spiced veg rice', 650, 0, '2026-05-08T15:25:00'),
    (20, 'Bun Tom Nuong', 9.75, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2019.jpg', 'Grilled shrimp noodles', 430, 0, '2026-05-08T15:25:00'),
    (21, 'Thai Chili Beef', 10.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2004.jpg', 'Spicy beef stir fry', 620, 0, '2026-05-08T15:25:00'),
    (22, 'Crispy Beef Strips', 10.99, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2017.jpg', 'Crispy sweet beef', 690, 0, '2026-05-08T15:25:00'),
    (23, 'Tamago Nigiri', 5.50, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2005.jpg', 'Sweet egg sushi', 180, 0, '2026-05-08T15:25:00'),
    (24, 'Chicken Rogan Josh', 11.75, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2023.jpg', 'Rich tomato curry', 780, 0, '2026-05-08T15:25:00'),
    (25, 'Pho Ga Tron', 9.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2008.jpg', 'Dry chicken pho', 420, 0, '2026-05-08T15:25:00'),
    (26, 'Thai Beef Rice', 9.99, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2013.jpg', 'Beef over rice', 610, 0, '2026-05-08T15:25:00'),
    (27, 'Chicken Chow Fun', 9.75, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2006.jpg', 'Wide noodles & chicken', 640, 0, '2026-05-08T15:25:00'),
    (28, 'Karaage Chicken', 9.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2024.jpg', 'Japanese fried chicken', 520, 0, '2026-05-08T15:25:00'),
    (29, 'Chickpea Curry', 8.99, 4.2, '../the_delivery_app_flutter/assets/food_logos/Untitled 2003.jpg', 'Spiced chickpeas', 510, 0, '2026-05-08T15:25:00'),
    (30, 'Vietnamese Pork Salad', 9.25, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2018.jpg', 'Herb pork salad', 360, 0, '2026-05-08T15:25:00'),
    (31, 'Thai Peanut Noodles', 9.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2007.jpg', 'Peanut noodle bowl', 630, 0, '2026-05-08T15:25:00'),
    (32, 'Beef Ho Fun', 10.50, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2010.jpg', 'Beef rice noodles', 670, 0, '2026-05-08T15:25:00'),
    (33, 'Tempura Chicken Don', 9.75, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2001.jpg', 'Tempura chicken rice', 540, 0, '2026-05-08T15:25:00'),
    (34, 'Chicken Madras', 11.50, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2014.jpg', 'Hot curry', 790, 0, '2026-05-08T15:25:00'),
    (35, 'Bun Ca', 9.50, 4.3, '../the_delivery_app_flutter/assets/food_logos/Untitled 2009.jpg', 'Fish noodle soup', 410, 0, '2026-05-08T15:25:00'),
    (36, 'Thai Veg Stir Fry', 8.50, 4.1, '../the_delivery_app_flutter/assets/food_logos/Untitled 2020.jpg', 'Mixed veg stir fry', 350, 0, '2026-05-08T15:25:00'),
    (37, 'Beef Pho Deluxe', 10.99, 4.6, '../the_delivery_app_flutter/assets/food_logos/Untitled 2002.jpg', 'Deluxe beef pho', 490, 0, '2026-05-08T15:25:00'),
    (38, 'Sushi Chef Selection', 13.50, 4.8, '../the_delivery_app_flutter/assets/food_logos/Untitled 2016.jpg', 'Chef sushi mix', 470, 0, '2026-05-08T15:25:00'),
    (39, 'Chicken Curry Masala', 10.99, 4.5, '../the_delivery_app_flutter/assets/food_logos/Untitled 2005.jpg', 'Rich curry bowl', 720, 0, '2026-05-08T15:25:00'),
    (40, 'Pho Chicken Deluxe', 9.99, 4.4, '../the_delivery_app_flutter/assets/food_logos/Untitled 2021.jpg', 'Deluxe chicken pho', 450, 0, '2026-05-08T15:25:00');
    RAISE NOTICE 'Inserted 160 food items';
  ELSE
    RAISE NOTICE 'Database already seeded with food items, skipping insert';
  END IF;
END $$;

-- Only seed couriers if table is empty
DO $$
BEGIN
  IF (SELECT COUNT(*) FROM courier) = 0 THEN
    INSERT INTO "courier" ("fname", "lname", "phone", "carName", "plateNum") VALUES
    ('James', 'Whittaker', '+447700900101', 'Ford Fiesta', 'HX19 ZBC'),
    ('Oliver', 'Pemberton', '+447700900102', 'Vauxhall Corsa', 'LP20 KDM'),
    ('Harry', 'Ashworth', '+447700900103', 'Volkswagen Polo', 'GN21 RTV'),
    ('Charlie', 'Bramley', '+447700900104', 'Toyota Yaris', 'BD18 WFE'),
    ('Jack', 'Hollingsworth', '+447700900105', 'Honda Civic', 'MK22 PLA'),
    ('Thomas', 'Goodwin', '+447700900106', 'Nissan Micra', 'YV19 NHC'),
    ('George', 'Fairbrother', '+447700900107', 'Peugeot 208', 'RX21 GTM'),
    ('Noah', 'Kettleworth', '+447700900108', 'Renault Clio', 'EJ20 SDB'),
    ('William', 'Stanford', '+447700900109', 'Hyundai i20', 'CV18 HKR'),
    ('Leo', 'Marchant', '+447700900110', 'Kia Picanto', 'AM22 LWT'),
    ('Arthur', 'Bellingham', '+447700900111', 'Skoda Fabia', 'TP19 BQE'),
    ('Henry', 'Crowther', '+447700900112', 'Mini Cooper', 'HJ21 ZRC'),
    ('Oscar', 'Drummond', '+447700900113', 'Citroen C3', 'LR20 NFM'),
    ('Theodore', 'Faulkner', '+447700900114', 'Seat Ibiza', 'WB22 GDX'),
    ('Freddie', 'Hawthorne', '+447700900115', 'Mazda 2', 'PY18 KVA'),
    ('Sophie', 'Ainsworth', '+447700900116', 'Ford Ka', 'NT19 RJM'),
    ('Emily', 'Brookshaw', '+447700900117', 'Vauxhall Astra', 'GS21 BWP'),
    ('Olivia', 'Coleridge', '+447700900118', 'Honda Jazz', 'EK20 HTL'),
    ('Amelia', 'Davenport', '+447700900119', 'Toyota Aygo', 'MV22 SDR'),
    ('Isla', 'Eastwood', '+447700900120', 'Suzuki Swift', 'BC18 NPF'),
    ('Ava', 'Fenwick', '+447700900121', 'Fiat 500', 'XW21 RKG'),
    ('Mia', 'Granger', '+447700900122', 'Nissan Note', 'JD19 LMT'),
    ('Grace', 'Harrowby', '+447700900123', 'Renault Zoe', 'PK22 ABE'),
    ('Lily', 'Inglewood', '+447700900124', 'Hyundai Kona', 'TM20 CVH'),
    ('Charlotte', 'Jepson', '+447700900125', 'Kia Rio', 'YR18 FDN'),
    ('Daisy', 'Kentridge', '+447700900126', 'Skoda Citigo', 'EH21 GBS'),
    ('Evie', 'Linton', '+447700900127', 'Mini One', 'LF22 KPM'),
    ('Ruby', 'Mossman', '+447700900128', 'Citroen C1', 'NB19 WQX'),
    ('Florence', 'Norbury', '+447700900129', 'Seat Mii', 'GR20 ZTC'),
    ('Phoebe', 'Oakley', '+447700900130', 'Mazda 3', 'HV22 JMP'),
    ('Liam', 'Pritchard', '+447700900131', 'Ford Focus', 'CD18 BNR'),
    ('Mason', 'Quinton', '+447700900132', 'Vauxhall Mokka', 'YK21 SLT'),
    ('Ethan', 'Ravenscroft', '+447700900133', 'Volkswagen Up', 'PM19 EWG'),
    ('Lucas', 'Sinclair', '+447700900134', 'Toyota Corolla', 'AX22 HFC'),
    ('Logan', 'Tindall', '+447700900135', 'Honda HR-V', 'RT20 VKD'),
    ('Daniel', 'Underwood', '+447700900136', 'Nissan Juke', 'LW18 GBM'),
    ('Benjamin', 'Vickery', '+447700900137', 'Peugeot 2008', 'MQ21 NPF'),
    ('Samuel', 'Wakefield', '+447700900138', 'Renault Captur', 'EB19 RJH'),
    ('Joseph', 'Yardley', '+447700900139', 'Hyundai i10', 'TG22 CWS'),
    ('Alexander', 'Ziegler', '+447700900140', 'Kia Stonic', 'PN20 KAL');
    RAISE NOTICE 'Inserted 40 couriers';
  ELSE
    RAISE NOTICE 'Database already seeded with couriers, skipping insert';
  END IF;
END $$;

-- Only seed special deals if table is empty
DO $$
BEGIN
  IF (SELECT COUNT(*) FROM special_deals) = 0 THEN
    INSERT INTO "special_deals" ("placeId", "thumbnail", "description", "discountAmount") VALUES
    (1,  '../the_delivery_app_flutter/assets/deal_logos/deal_001.jpg', '2 for 1 on all nigiri rolls', 50.00),
    (2,  '../the_delivery_app_flutter/assets/deal_logos/deal_002.jpg', '20% off any large pizza', 20.00),
    (3,  '../the_delivery_app_flutter/assets/deal_logos/deal_003.jpg', 'Free spring rolls with any noodle dish', 15.00),
    (4,  NULL,                                                          'Family meal deal - £5 off', 5.00),
    (5,  '../the_delivery_app_flutter/assets/deal_logos/deal_005.jpg', 'Curry & rice combo discount', 25.00),
    (6,  '../the_delivery_app_flutter/assets/deal_logos/deal_006.jpg', 'Lunchtime pho special', 15.00),
    (7,  NULL,                                                          'Dim sum platter half price', 50.00),
    (8,  '../the_delivery_app_flutter/assets/deal_logos/deal_008.jpg', 'Sushi combo weekend offer', 30.00),
    (9,  '../the_delivery_app_flutter/assets/deal_logos/deal_009.jpg', 'Buy 2 curries, save £3', 10.00),
    (10, '../the_delivery_app_flutter/assets/deal_logos/deal_010.jpg', 'Banh mi & coffee combo', 20.00),
    (11, '../the_delivery_app_flutter/assets/deal_logos/deal_011.jpg', 'Thai curry meal deal', 25.00),
    (12, NULL,                                                          'Chow mein lunch special', 15.00),
    (13, '../the_delivery_app_flutter/assets/deal_logos/deal_013.jpg', 'Sashimi platter discount', 30.00),
    (14, '../the_delivery_app_flutter/assets/deal_logos/deal_014.jpg', 'Lamb rogan josh & naan deal', 20.00),
    (15, '../the_delivery_app_flutter/assets/deal_logos/deal_015.jpg', 'Vermicelli bowl happy hour', 15.00),
    (16, '../the_delivery_app_flutter/assets/deal_logos/deal_016.jpg', 'Tom yum & rice combo', 20.00),
    (17, NULL,                                                          'Dumpling lovers bundle', 25.00),
    (18, '../the_delivery_app_flutter/assets/deal_logos/deal_018.jpg', 'Ramen + gyoza combo', 20.00),
    (19, '../the_delivery_app_flutter/assets/deal_logos/deal_019.jpg', 'Paneer feast for two', 30.00),
    (20, '../the_delivery_app_flutter/assets/deal_logos/deal_020.jpg', 'Vietnamese sampler deal', 15.00),
    (21, '../the_delivery_app_flutter/assets/deal_logos/deal_021.jpg', 'Thai street food bundle', 25.00),
    (22, NULL,                                                          'Sweet chili pork special', 15.00),
    (23, '../the_delivery_app_flutter/assets/deal_logos/deal_023.jpg', 'Premium sashimi offer', 40.00),
    (24, '../the_delivery_app_flutter/assets/deal_logos/deal_024.jpg', 'Korma combo with rice', 20.00),
    (25, '../the_delivery_app_flutter/assets/deal_logos/deal_025.jpg', 'Pho lover meal deal', 15.00);
    RAISE NOTICE 'Inserted 25 special deals';
  ELSE
    RAISE NOTICE 'Database already seeded with special deals, skipping insert';
  END IF;
END $$;

-- Only seed food deals if table is empty
-- Each deal references food items from the matching restaurant
DO $$
BEGIN
  IF (SELECT COUNT(*) FROM food_deal) = 0 THEN
    INSERT INTO "food_deal" ("specialDealId", "foodId", "itemQty") VALUES
    -- Deal 1 (place 1, Sushi Palace): nigiri 2-for-1
    (1, 1, 2),
    (1, 41, 2),
    -- Deal 2 (place 2, Pizza Hub): 20% off pizza
    (2, 2, 1),
    (2, 42, 1),
    -- Deal 3 (place 3, Thai Express): noodles + free spring rolls
    (3, 3, 1),
    (3, 43, 1),
    -- Deal 4 (place 4, Dragon Wok): family combo
    (4, 4, 2),
    (4, 44, 1),
    (4, 84, 1),
    -- Deal 5 (place 5, Bombay Spice): curry & rice combo
    (5, 5, 1),
    (5, 45, 1),
    -- Deal 6 (place 6, Pho Garden): lunchtime pho
    (6, 6, 1),
    (6, 46, 1),
    -- Deal 7 (place 7, Golden Chopsticks): dim sum half price
    (7, 7, 1),
    (7, 47, 2),
    -- Deal 8 (place 8, Tokyo Grill): sushi combo
    (8, 8, 1),
    (8, 48, 1),
    (8, 88, 1),
    -- Deal 9 (place 9, Curry Leaf): buy 2 curries
    (9, 9, 2),
    (9, 49, 1),
    -- Deal 10 (place 10, Saigon Street): banh mi + coffee
    (10, 10, 1),
    (10, 55, 1),
    -- Deal 11 (place 11, Lotus Thai): Thai curry meal
    (11, 11, 1),
    (11, 51, 1),
    -- Deal 12 (place 12, Mandarin House): chow mein lunch
    (12, 12, 1),
    (12, 52, 1),
    -- Deal 13 (place 13, Sakura Sushi): sashimi platter
    (13, 13, 1),
    (13, 53, 1),
    -- Deal 14 (place 14, Spice Route): lamb rogan + naan
    (14, 14, 1),
    (14, 54, 1),
    -- Deal 15 (place 15, Bamboo Bowl): vermicelli happy hour
    (15, 15, 2),
    -- Deal 16 (place 16, Bangkok Bites): tom yum + rice
    (16, 16, 1),
    (16, 56, 1),
    -- Deal 17 (place 17, Red Lantern): dumpling bundle
    (17, 17, 1),
    (17, 57, 2),
    -- Deal 18 (place 18, Zen Kitchen): ramen + gyoza
    (18, 18, 1),
    (18, 58, 1),
    -- Deal 19 (place 19, Tandoori Flame): paneer feast
    (19, 19, 2),
    (19, 59, 1),
    -- Deal 20 (place 20, Hanoi Corner): Vietnamese sampler
    (20, 20, 1),
    (20, 60, 1),
    -- Deal 21 (place 21, Thai Orchid): Thai street bundle
    (21, 21, 1),
    (21, 61, 1),
    -- Deal 22 (place 22, Great Wall Diner): sweet chili pork
    (22, 22, 1),
    (22, 62, 1),
    -- Deal 23 (place 23, Tokyo Table): premium sashimi
    (23, 23, 1),
    (23, 63, 1),
    -- Deal 24 (place 24, Spice Bazaar): korma combo
    (24, 24, 1),
    (24, 64, 1),
    -- Deal 25 (place 25, Rice Paper Roll): pho lover
    (25, 25, 1),
    (25, 65, 1);
    RAISE NOTICE 'Inserted food deal mappings';
  ELSE
    RAISE NOTICE 'Database already seeded with food deals, skipping insert';
  END IF;
END $$;

-- Only seed tags if table is empty
DO $$
BEGIN
  IF (SELECT COUNT(*) FROM tag) = 0 THEN
    INSERT INTO "tag" ("tagName") VALUES
    ('Japanese'),    -- 1
    ('Italian'),     -- 2
    ('Thai'),        -- 3
    ('Chinese'),     -- 4
    ('Indian'),      -- 5
    ('Vietnamese'),  -- 6
    ('Vegetarian'),  -- 7
    ('Spicy'),       -- 8
    ('Mild'),        -- 9
    ('Noodles'),     -- 10
    ('Rice'),        -- 11
    ('Soup'),        -- 12
    ('Curry'),       -- 13
    ('Sushi'),       -- 14
    ('Chicken'),     -- 15
    ('Beef'),        -- 16
    ('Seafood'),     -- 17
    ('Grilled'),     -- 18
    ('Fried'),       -- 19
    ('Popular');     -- 20
    RAISE NOTICE 'Inserted 20 tags';
  ELSE
    RAISE NOTICE 'Database already seeded with tags, skipping insert';
  END IF;
END $$;

-- Only seed food_tag if table is empty
DO $$
BEGIN
  IF (SELECT COUNT(*) FROM food_tag) = 0 THEN
    INSERT INTO "food_tag" ("tagId", "foodId") VALUES
    -- Salmon Nigiri (1)
    (1, 1), (14, 1), (17, 1),
    -- Pepperoni Pizza (2)
    (2, 2), (20, 2),
    -- Pad Thai (3)
    (3, 3), (10, 3),
    -- Sweet & Sour Chicken (4)
    (4, 4), (15, 4), (19, 4),
    -- Butter Chicken (5)
    (5, 5), (13, 5), (15, 5), (9, 5), (20, 5),
    -- Pho Noodle Soup (6)
    (6, 6), (10, 6), (12, 6), (20, 6),
    -- Kung Pao Chicken (7)
    (4, 7), (15, 7), (8, 7),
    -- Sushi Roll Combo (8)
    (1, 8), (14, 8), (20, 8),
    -- Chicken Tikka Masala (9)
    (5, 9), (13, 9), (15, 9), (18, 9), (20, 9),
    -- Spring Rolls (10)
    (6, 10), (7, 10), (19, 10),
    -- Green Curry (11)
    (3, 11), (13, 11),
    -- Beef Chow Mein (12)
    (4, 12), (10, 12), (16, 12),
    -- Tempura Udon (13)
    (1, 13), (10, 13), (19, 13),
    -- Lamb Rogan Josh (14)
    (5, 14), (13, 14), (8, 14),
    -- Banh Mi (15)
    (6, 15), (20, 15),
    -- Tom Yum Soup (16)
    (3, 16), (12, 16), (8, 16),
    -- Dim Sum Platter (17)
    (4, 17), (20, 17),
    -- Ramen Bowl (18)
    (1, 18), (10, 18), (12, 18), (20, 18),
    -- Paneer Masala (19)
    (5, 19), (13, 19), (7, 19),
    -- Vermicelli Bowl (20)
    (6, 20), (10, 20),
    -- Thai Basil Chicken (21)
    (3, 21), (15, 21), (8, 21),
    -- Sweet Chili Pork (22)
    (4, 22),
    -- Sashimi Set (23)
    (1, 23), (17, 23),
    -- Chicken Korma (24)
    (5, 24), (13, 24), (15, 24), (9, 24),
    -- Beef Pho (25)
    (6, 25), (10, 25), (12, 25), (16, 25),
    -- Thai Fried Rice (26)
    (3, 26), (11, 26), (19, 26),
    -- Kung Pao Shrimp (27)
    (4, 27), (17, 27), (8, 27),
    -- Tonkotsu Ramen (28)
    (1, 28), (10, 28), (12, 28), (20, 28),
    -- Chicken Biryani (29)
    (5, 29), (11, 29), (15, 29), (20, 29),
    -- Fresh Spring Rolls (30)
    (6, 30), (7, 30),
    -- Thai Red Curry (31)
    (3, 31), (13, 31), (8, 31),
    -- Chow Fun (32)
    (4, 32), (10, 32),
    -- Tempura Don (33)
    (1, 33), (11, 33), (19, 33),
    -- Paneer Tikka (34)
    (5, 34), (7, 34), (18, 34),
    -- Bun Cha (35)
    (6, 35), (10, 35),
    -- Thai Omelette (36)
    (3, 36), (19, 36),
    -- Beef Stir Fry (37)
    (4, 37), (16, 37),
    -- Sushi Box (38)
    (1, 38), (14, 38), (17, 38), (20, 38),
    -- Chicken Madras (39)
    (5, 39), (13, 39), (15, 39), (8, 39),
    -- Pho Special (40)
    (6, 40), (10, 40), (12, 40),
    -- Tuna Maki (41)
    (1, 41), (14, 41), (17, 41),
    -- Margherita Slice (42)
    (2, 42), (7, 42),
    -- Thai Cashew Chicken (43)
    (3, 43), (15, 43),
    -- Beef Fried Rice (44)
    (4, 44), (11, 44), (16, 44), (19, 44),
    -- Chicken Korma (45)
    (5, 45), (13, 45), (15, 45), (9, 45),
    -- Bun Bo Hue (46)
    (6, 46), (10, 46), (12, 46), (16, 46), (8, 46),
    -- Beef & Broccoli (47)
    (4, 47), (16, 47),
    -- California Roll (48)
    (1, 48), (14, 48), (17, 48),
    -- Dal Tadka (49)
    (5, 49), (7, 49), (13, 49),
    -- Prawn Toast (50)
    (4, 50), (17, 50), (19, 50),
    -- Thai Beef Salad (51)
    (3, 51), (16, 51), (8, 51),
    -- Chicken Lo Mein (52)
    (4, 52), (10, 52), (15, 52),
    -- Chicken Katsu (53)
    (1, 53), (15, 53), (19, 53),
    -- Chana Masala (54)
    (5, 54), (7, 54), (13, 54),
    -- Vietnamese Iced Coffee (55)
    (6, 55),
    -- Thai Coconut Soup (56)
    (3, 56), (12, 56),
    -- Pork Dumplings (57)
    (4, 57),
    -- Spicy Miso Ramen (58)
    (1, 58), (10, 58), (12, 58), (8, 58), (20, 58),
    -- Aloo Gobi (59)
    (5, 59), (7, 59),
    -- Bun Thit Nuong (60)
    (6, 60), (10, 60), (18, 60),
    -- Thai Stir Fry (61)
    (3, 61), (15, 61),
    -- Honey Chicken (62)
    (4, 62), (15, 62), (9, 62),
    -- Shrimp Tempura (63)
    (1, 63), (17, 63), (19, 63),
    -- Lamb Korma (64)
    (5, 64), (13, 64), (9, 64),
    -- Pho Tai (65)
    (6, 65), (10, 65), (12, 65), (16, 65),
    -- Thai Omelette Rice (66)
    (3, 66), (11, 66), (19, 66),
    -- Beef Chow Fun (67)
    (4, 67), (10, 67), (16, 67),
    -- Chicken Teriyaki (68)
    (1, 68), (15, 68), (18, 68),
    -- Vegetable Biryani (69)
    (5, 69), (7, 69), (11, 69),
    -- Vietnamese Rolls (70)
    (6, 70), (7, 70),
    -- Thai Red Noodles (71)
    (3, 71), (10, 71), (8, 71),
    -- Chicken Fried Noodles (72)
    (4, 72), (10, 72), (15, 72), (19, 72),
    -- Katsu Don (73)
    (1, 73), (11, 73), (15, 73), (19, 73),
    -- Tandoori Chicken (74)
    (5, 74), (15, 74), (18, 74), (20, 74),
    -- Pho Ga (75)
    (6, 75), (10, 75), (12, 75), (15, 75),
    -- Thai Stir Veg (76)
    (3, 76), (7, 76),
    -- Beef Noodle Bowl (77)
    (4, 77), (10, 77), (16, 77),
    -- Sushi Trio (78)
    (1, 78), (14, 78), (17, 78),
    -- Chicken Vindaloo (79)
    (5, 79), (13, 79), (15, 79), (8, 79),
    -- Pho House Special (80)
    (6, 80), (10, 80), (12, 80),
    -- Ebi Tempura (81)
    (1, 81), (17, 81), (19, 81),
    -- BBQ Chicken Pizza (82)
    (2, 82), (15, 82), (20, 82),
    -- Thai Red Noodle Bowl (83)
    (3, 83), (10, 83), (13, 83), (8, 83),
    -- General Tso Chicken (84)
    (4, 84), (15, 84), (8, 84),
    -- Chicken Saag (85)
    (5, 85), (13, 85), (15, 85),
    -- Bun Rieu (86)
    (6, 86), (10, 86), (12, 86), (17, 86),
    -- Orange Chicken (87)
    (4, 87), (15, 87), (9, 87),
    -- Spicy Tuna Roll (88)
    (1, 88), (14, 88), (17, 88), (8, 88),
    -- Lamb Biryani (89)
    (5, 89), (11, 89), (20, 89),
    -- Chicken Gyoza (90)
    (6, 90), (15, 90), (19, 90),
    -- Thai Pineapple Rice (91)
    (3, 91), (11, 91),
    -- Shrimp Chow Mein (92)
    (4, 92), (10, 92), (17, 92),
    -- Chicken Yakitori (93)
    (1, 93), (15, 93), (18, 93),
    -- Vegetable Korma (94)
    (5, 94), (7, 94), (13, 94), (9, 94),
    -- Vietnamese Curry (95)
    (6, 95), (13, 95), (9, 95),
    -- Thai Chicken Wings (96)
    (3, 96), (15, 96), (8, 96), (19, 96),
    -- Beef Dumplings (97)
    (4, 97), (16, 97),
    -- Shoyu Ramen (98)
    (1, 98), (10, 98), (12, 98), (20, 98),
    -- Chole Masala (99)
    (5, 99), (7, 99), (13, 99),
    -- Bun Nem (100)
    (6, 100), (10, 100),
    -- Thai Garlic Chicken (101)
    (3, 101), (15, 101),
    -- Crispy Pork Belly (102)
    (4, 102), (19, 102),
    -- Unagi Nigiri (103)
    (1, 103), (14, 103), (17, 103), (18, 103),
    -- Chicken Jalfrezi (104)
    (5, 104), (13, 104), (15, 104), (8, 104),
    -- Pho Bo Vien (105)
    (6, 105), (10, 105), (12, 105), (16, 105),
    -- Thai Basil Beef (106)
    (3, 106), (16, 106), (8, 106),
    -- Shrimp Fried Rice (107)
    (4, 107), (11, 107), (17, 107), (19, 107),
    -- Chicken Donburi (108)
    (1, 108), (11, 108), (15, 108),
    -- Vegetable Curry (109)
    (5, 109), (7, 109), (13, 109),
    -- Vietnamese Chicken Salad (110)
    (6, 110), (15, 110),
    -- Thai Chili Noodles (111)
    (3, 111), (10, 111), (8, 111),
    -- Beef Stir Noodles (112)
    (4, 112), (10, 112), (16, 112),
    -- Chicken Tempura Bowl (113)
    (1, 113), (11, 113), (15, 113), (19, 113),
    -- Chicken Tikka (114)
    (5, 114), (15, 114), (18, 114), (20, 114),
    -- Bun Cha Hanoi (115)
    (6, 115), (10, 115), (18, 115),
    -- Thai Veg Curry (116)
    (3, 116), (7, 116), (13, 116),
    -- Beef Pho Special (117)
    (4, 117), (10, 117), (12, 117), (16, 117), (20, 117),
    -- Sushi Mix Plate (118)
    (1, 118), (14, 118), (17, 118), (20, 118),
    -- Chicken Curry Bowl (119)
    (5, 119), (13, 119), (15, 119),
    -- Pho Chicken Special (120)
    (6, 120), (10, 120), (12, 120), (15, 120),
    -- Avocado Maki (121)
    (1, 121), (14, 121), (7, 121),
    -- Four Cheese Pizza (122)
    (2, 122), (7, 122), (20, 122),
    -- Thai Yellow Curry (123)
    (3, 123), (13, 123), (9, 123),
    -- Beef Black Bean (124)
    (4, 124), (16, 124),
    -- Chicken Jalfrezi (125)
    (5, 125), (13, 125), (15, 125), (8, 125),
    -- Vietnamese Fried Rice (126)
    (6, 126), (11, 126), (19, 126),
    -- Sweet Chili Chicken (127)
    (4, 127), (15, 127),
    -- Sake Nigiri (128)
    (1, 128), (14, 128), (17, 128),
    -- Vegetable Curry (129)
    (5, 129), (7, 129), (13, 129),
    -- Crispy Wontons (130)
    (6, 130), (19, 130),
    -- Thai Beef Stir Fry (131)
    (3, 131), (16, 131),
    -- Chicken Egg Foo Young (132)
    (4, 132), (15, 132),
    -- Prawn Tempura (133)
    (1, 133), (17, 133), (19, 133),
    -- Dal Makhani (134)
    (5, 134), (7, 134), (13, 134), (9, 134),
    -- Vietnamese Curry Chicken (135)
    (6, 135), (13, 135), (15, 135), (9, 135),
    -- Thai Chicken Satay (136)
    (3, 136), (15, 136), (18, 136),
    -- Vegetable Dumplings (137)
    (4, 137), (7, 137),
    -- Tantanmen Ramen (138)
    (1, 138), (10, 138), (12, 138), (8, 138), (20, 138),
    -- Vegetable Biryani (139)
    (5, 139), (7, 139), (11, 139),
    -- Bun Tom Nuong (140)
    (6, 140), (10, 140), (17, 140), (18, 140),
    -- Thai Chili Beef (141)
    (3, 141), (16, 141), (8, 141),
    -- Crispy Beef Strips (142)
    (4, 142), (16, 142), (19, 142),
    -- Tamago Nigiri (143)
    (1, 143), (14, 143), (7, 143),
    -- Chicken Rogan Josh (144)
    (5, 144), (13, 144), (15, 144),
    -- Pho Ga Tron (145)
    (6, 145), (10, 145), (15, 145),
    -- Thai Beef Rice (146)
    (3, 146), (11, 146), (16, 146),
    -- Chicken Chow Fun (147)
    (4, 147), (10, 147), (15, 147),
    -- Karaage Chicken (148)
    (1, 148), (15, 148), (19, 148),
    -- Chickpea Curry (149)
    (5, 149), (7, 149), (13, 149),
    -- Vietnamese Pork Salad (150)
    (6, 150),
    -- Thai Peanut Noodles (151)
    (3, 151), (10, 151),
    -- Beef Ho Fun (152)
    (4, 152), (10, 152), (16, 152),
    -- Tempura Chicken Don (153)
    (1, 153), (11, 153), (15, 153), (19, 153),
    -- Chicken Madras (154)
    (5, 154), (13, 154), (15, 154), (8, 154),
    -- Bun Ca (155)
    (6, 155), (10, 155), (12, 155), (17, 155),
    -- Thai Veg Stir Fry (156)
    (3, 156), (7, 156),
    -- Beef Pho Deluxe (157)
    (4, 157), (10, 157), (12, 157), (16, 157), (20, 157),
    -- Sushi Chef Selection (158)
    (1, 158), (14, 158), (17, 158), (20, 158),
    -- Chicken Curry Masala (159)
    (5, 159), (13, 159), (15, 159),
    -- Pho Chicken Deluxe (160)
    (6, 160), (10, 160), (12, 160), (15, 160);
    RAISE NOTICE 'Inserted food_tag mappings';
  ELSE
    RAISE NOTICE 'Database already seeded with food tags, skipping insert';
  END IF;
END $$;

COMMIT;
