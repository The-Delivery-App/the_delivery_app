BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "user" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user" (
    "id" bigserial PRIMARY KEY,
    "authUserId" bigint NOT NULL,
    "name" text NOT NULL,
    "email" text NOT NULL,
    "phone" text,
    "avatarUrl" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "auth_user_idx" ON "user" USING btree ("authUserId");


--
-- MIGRATION VERSION FOR the_delivery_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('the_delivery_app', '20260428163551519', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260428163551519', "timestamp" = now();

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
