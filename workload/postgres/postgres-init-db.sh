#!/bin/bash
set -e

mkdir -p $PGDATA

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER $POSTGRES_APP_USER WITH PASSWORD '$POSTGRES_APP_USER_PASSWORD';
    CREATE DATABASE $POSTGRES_APP_DB;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_APP_DB TO $POSTGRES_APP_USER;
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_APP_USER" --dbname="$POSTGRES_APP_DB" <<-EOSQL
    CREATE TABLE IF NOT EXISTS notes
    (
      id   BIGINT,
      name VARCHAR(100),
      contents VARCHAR(10000)
    );
    CREATE SEQUENCE notes_id_sequential;
EOSQL