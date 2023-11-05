#!/bin/sh

psql -f _0_setup.sql
psql -d eric_crm -f _1_build.sql
psql -d eric_crm -f _2_seed_dim.sql
psql -d eric_crm -f _3_seed_fact.sql