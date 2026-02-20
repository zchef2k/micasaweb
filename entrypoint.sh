#!/bin/bash
DB_FILE="/home/micasa/.local/share/micasa/micasa.db"

# if there's no db, create it
if [ ! -f "$DB_FILE" ]; then
    echo "Initializing new database at $DB_FILE..."
    sqlite3 "$DB_FILE" "VACUUM;"
fi

exec "$@"
