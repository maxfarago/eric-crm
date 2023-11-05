--------------------------------------------------------------------------------
-- Dimensional Data
--------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS "district" (
    "id" SERIAL PRIMARY KEY,
    "census_id" TEXT,
    "name" TEXT,
    "county" TEXT,
    "state" TEXT
);

CREATE TABLE IF NOT EXISTS "location" (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT UNIQUE,
    "district_id" INT,
    CONSTRAINT "fk_district" FOREIGN KEY ("district_id") REFERENCES "district" ("id")
);

CREATE TABLE IF NOT EXISTS "role" (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "partner" (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "attendance_value" (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL
);

--------------------------------------------------------------------------------
-- User & Event Data
--------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS "user" (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "email" TEXT UNIQUE NOT NULL,
    "organization" TEXT,
    "title" TEXT,
    "zoom_id" INT UNIQUE,
    "bio" TEXT
);

CREATE TABLE IF NOT EXISTS "event" (
    "id" SERIAL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "location_id" INT NOT NULL,
    "class_dates" DATE [],
    CONSTRAINT "fk_location" FOREIGN KEY ("location_id") REFERENCES "location" ("id")
);

CREATE TABLE IF NOT EXISTS "enrollment" (
    "id" SERIAL PRIMARY KEY,
    "event_id" INT NOT NULL,
    "user_id" INT NOT NULL,
    "role_id" INT,
    "is_enrolled" BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT "fk_event" FOREIGN KEY ("event_id") REFERENCES "event" ("id"),
    CONSTRAINT "fk_user" FOREIGN KEY ("user_id") REFERENCES "user" ("id"),
    CONSTRAINT "fk_role" FOREIGN KEY ("role_id") REFERENCES "role" ("id")
);

CREATE TABLE IF NOT EXISTS "attendance" (
    "id" SERIAL PRIMARY KEY,
    "event_id" INT NOT NULL,
    "user_id" INT NOT NULL,
    "date" DATE NOT NULL,
    "attendance_value_id" INT NOT NULL,
    CONSTRAINT "fk_event" FOREIGN KEY ("event_id") REFERENCES "event" ("id"),
    CONSTRAINT "fk_user" FOREIGN KEY ("user_id") REFERENCES "user" ("id"),
    CONSTRAINT "fk_attendance_value" FOREIGN KEY ("attendance_value_id") REFERENCES "attendance_value" ("id")
);

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO taps3;