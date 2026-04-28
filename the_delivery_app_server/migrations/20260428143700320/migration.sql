BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "address" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "isDefault" boolean NOT NULL,
    "country" text NOT NULL,
    "city" text NOT NULL,
    "postcode" text NOT NULL,
    "addressLine1" text NOT NULL,
    "addressLine2" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "basket" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "lastUpdated" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "basket_food" (
    "id" bigserial PRIMARY KEY,
    "basketId" bigint NOT NULL,
    "foodId" bigint NOT NULL,
    "qty" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "courier" (
    "id" bigserial PRIMARY KEY,
    "fname" text NOT NULL,
    "lname" text NOT NULL,
    "phone" text NOT NULL,
    "carName" text NOT NULL,
    "plateNum" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "food_deal" (
    "id" bigserial PRIMARY KEY,
    "specialDealId" bigint NOT NULL,
    "foodId" bigint NOT NULL,
    "itemQty" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "food_item" (
    "id" bigserial PRIMARY KEY,
    "restId" bigint NOT NULL,
    "foodName" text NOT NULL,
    "foodPrice" double precision NOT NULL,
    "foodRating" double precision NOT NULL,
    "foodThumbnail" text,
    "description" text,
    "nutritionCals" bigint,
    "estimatedOrders" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "food_review" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "foodId" bigint NOT NULL,
    "rating" double precision NOT NULL,
    "comment" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "food_tag" (
    "id" bigserial PRIMARY KEY,
    "tagId" bigint NOT NULL,
    "foodId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order" (
    "id" bigserial PRIMARY KEY,
    "courierId" bigint,
    "userId" bigint NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "isSplit" boolean NOT NULL,
    "currentStatus" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order_status_history" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "status" text NOT NULL,
    "time" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payment" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "orderId" bigint NOT NULL,
    "amount" double precision NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "transactionTime" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "restaurant" (
    "id" bigserial PRIMARY KEY,
    "restName" text NOT NULL,
    "logoThumb" text,
    "estimatedDeliveryTime" double precision NOT NULL DEFAULT 30.0,
    "cuisine" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "restaurant_place" (
    "id" bigserial PRIMARY KEY,
    "restId" bigint NOT NULL,
    "name" text,
    "city" text NOT NULL,
    "country" text NOT NULL,
    "postcode" text NOT NULL,
    "addressLine1" text NOT NULL,
    "addressLine2" text,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "special_deals" (
    "id" bigserial PRIMARY KEY,
    "placeId" bigint NOT NULL,
    "thumbnail" text,
    "description" text NOT NULL,
    "discountAmount" double precision NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tag" (
    "id" bigserial PRIMARY KEY,
    "tagName" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "fname" text NOT NULL,
    "lname" text NOT NULL,
    "phone" text NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "address"
    ADD CONSTRAINT "address_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "basket"
    ADD CONSTRAINT "basket_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "basket_food"
    ADD CONSTRAINT "basket_food_fk_0"
    FOREIGN KEY("basketId")
    REFERENCES "basket"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "basket_food"
    ADD CONSTRAINT "basket_food_fk_1"
    FOREIGN KEY("foodId")
    REFERENCES "food_item"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "food_deal"
    ADD CONSTRAINT "food_deal_fk_0"
    FOREIGN KEY("specialDealId")
    REFERENCES "special_deals"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "food_deal"
    ADD CONSTRAINT "food_deal_fk_1"
    FOREIGN KEY("foodId")
    REFERENCES "food_item"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "food_item"
    ADD CONSTRAINT "food_item_fk_0"
    FOREIGN KEY("restId")
    REFERENCES "restaurant"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "food_review"
    ADD CONSTRAINT "food_review_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "food_review"
    ADD CONSTRAINT "food_review_fk_1"
    FOREIGN KEY("foodId")
    REFERENCES "food_item"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "food_tag"
    ADD CONSTRAINT "food_tag_fk_0"
    FOREIGN KEY("tagId")
    REFERENCES "tag"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "food_tag"
    ADD CONSTRAINT "food_tag_fk_1"
    FOREIGN KEY("foodId")
    REFERENCES "food_item"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "order"
    ADD CONSTRAINT "order_fk_0"
    FOREIGN KEY("courierId")
    REFERENCES "courier"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order"
    ADD CONSTRAINT "order_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "order_status_history"
    ADD CONSTRAINT "order_status_history_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "order"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "payment"
    ADD CONSTRAINT "payment_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "payment"
    ADD CONSTRAINT "payment_fk_1"
    FOREIGN KEY("orderId")
    REFERENCES "order"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "restaurant_place"
    ADD CONSTRAINT "restaurant_place_fk_0"
    FOREIGN KEY("restId")
    REFERENCES "restaurant"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "special_deals"
    ADD CONSTRAINT "special_deals_fk_0"
    FOREIGN KEY("placeId")
    REFERENCES "restaurant_place"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR the_delivery_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('the_delivery_app', '20260428143700320', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260428143700320', "timestamp" = now();

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
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
