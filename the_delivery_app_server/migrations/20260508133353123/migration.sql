BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");


--
-- MIGRATION VERSION FOR the_delivery_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('the_delivery_app', '20260508133353123', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260508133353123', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20260129181059877', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181059877', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;

BEGIN;

--Restaurants
INSERT INTO restaurant (restName, logoThumb, estimatedDeliveryTime, cuisine) VALUES
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

--Restaurant Places
INSERT INTO restaurant_place (restId, name, city, country, postcode, addressLine1, addressLine2, latitude, longitude) VALUES
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
(40, 'Saigon Express – Southsea', 'Southsea', 'UK', 'PO4 0JR', '30 Albert Road', NULL, 50.7864, -1.0734);
INSERT INTO restaurant_place (restId, name, city, country, postcode, addressLine1, addressLine2, latitude, longitude) VALUES
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


--Food Items







COMMIT;