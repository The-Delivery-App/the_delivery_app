BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "order" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "restaurantId" bigint NOT NULL,
    "deliveryAddressId" bigint NOT NULL,
    "courierId" bigint,
    "subtotal" double precision NOT NULL,
    "deliveryFee" double precision NOT NULL,
    "serviceFee" double precision NOT NULL,
    "discount" double precision NOT NULL,
    "totalAmount" double precision NOT NULL,
    "idempotencyKey" text NOT NULL,
    "currentStatus" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone,
    "estimatedDeliveryTime" timestamp without time zone,
    "actualDeliveryTime" timestamp without time zone,
    "isSplit" boolean NOT NULL,
    "deliveryInstructions" text,
    "courierLatitude" double precision,
    "courierLongitude" double precision
);

-- Indexes
CREATE UNIQUE INDEX "idempotency_idx" ON "order" USING btree ("idempotencyKey");
CREATE INDEX "user_orders_idx" ON "order" USING btree ("userId");
CREATE INDEX "status_idx" ON "order" USING btree ("currentStatus");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "order_item" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "foodItemId" bigint NOT NULL,
    "quantity" bigint NOT NULL,
    "unitPrice" double precision NOT NULL,
    "specialInstructions" text,
    "foodItemName" text NOT NULL,
    "foodItemDescription" text
);

-- Indexes
CREATE INDEX "order_items_idx" ON "order_item" USING btree ("orderId");

--
-- ACTION DROP TABLE
--
DROP TABLE "payment" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payment" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "amount" double precision NOT NULL,
    "currency" text NOT NULL DEFAULT 'GBP'::text,
    "paymentMethod" text NOT NULL,
    "transactionId" text,
    "providerName" text NOT NULL,
    "providerMetadata" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "processedAt" timestamp without time zone,
    "refundedAmount" double precision,
    "refundedAt" timestamp without time zone,
    "refundReason" text
);

-- Indexes
CREATE INDEX "transaction_idx" ON "payment" USING btree ("transactionId");
CREATE INDEX "order_payment_idx" ON "payment" USING btree ("orderId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "split_payment_participant" (
    "id" bigserial PRIMARY KEY,
    "orderId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "paymentId" bigint,
    "amountDue" double precision NOT NULL,
    "hasPaid" boolean NOT NULL DEFAULT false,
    "paidAt" timestamp without time zone,
    "invitedAt" timestamp without time zone NOT NULL,
    "reminderSentAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "order_participants_idx" ON "split_payment_participant" USING btree ("orderId");
CREATE INDEX "user_splits_idx" ON "split_payment_participant" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "order"
    ADD CONSTRAINT "order_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order"
    ADD CONSTRAINT "order_fk_1"
    FOREIGN KEY("restaurantId")
    REFERENCES "restaurant"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order"
    ADD CONSTRAINT "order_fk_2"
    FOREIGN KEY("deliveryAddressId")
    REFERENCES "address"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order"
    ADD CONSTRAINT "order_fk_3"
    FOREIGN KEY("courierId")
    REFERENCES "courier"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "order_item"
    ADD CONSTRAINT "order_item_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "order"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "order_item"
    ADD CONSTRAINT "order_item_fk_1"
    FOREIGN KEY("foodItemId")
    REFERENCES "food_item"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "payment"
    ADD CONSTRAINT "payment_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "order"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "payment"
    ADD CONSTRAINT "payment_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "split_payment_participant"
    ADD CONSTRAINT "split_payment_participant_fk_0"
    FOREIGN KEY("orderId")
    REFERENCES "order"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "split_payment_participant"
    ADD CONSTRAINT "split_payment_participant_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "split_payment_participant"
    ADD CONSTRAINT "split_payment_participant_fk_2"
    FOREIGN KEY("paymentId")
    REFERENCES "payment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR the_delivery_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('the_delivery_app', '20260428144821966', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260428144821966', "timestamp" = now();

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
