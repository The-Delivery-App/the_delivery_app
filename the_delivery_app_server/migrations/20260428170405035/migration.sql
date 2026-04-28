BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_favourite" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "restaurantId" bigint,
    "foodItemId" bigint,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "user_restaurant_idx" ON "user_favourite" USING btree ("userId", "restaurantId");
CREATE INDEX "user_food_idx" ON "user_favourite" USING btree ("userId", "foodItemId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_favourite"
    ADD CONSTRAINT "user_favourite_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_favourite"
    ADD CONSTRAINT "user_favourite_fk_1"
    FOREIGN KEY("restaurantId")
    REFERENCES "restaurant"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_favourite"
    ADD CONSTRAINT "user_favourite_fk_2"
    FOREIGN KEY("foodItemId")
    REFERENCES "food_item"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR the_delivery_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('the_delivery_app', '20260428170405035', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260428170405035', "timestamp" = now();

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
