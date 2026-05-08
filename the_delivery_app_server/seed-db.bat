@echo off
REM Seed the_delivery_app database with test data
REM Run this AFTER applying migrations: dart bin/main.dart --apply-migrations

echo Seeding the_delivery_app database...

docker compose exec -T postgres psql ^
  -U postgres ^
  -d the_delivery_app ^
  < migrations\seed.sql

echo Database seeded successfully!
