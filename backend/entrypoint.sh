#!/bin/bash
# Wait for PostgreSQL to be ready
while ! pg_isready -h db -p 5432 > /dev/null 2> /dev/null; do
    echo "Connecting to PostgreSQL Failed - Sleeping"
    sleep 1
done

echo "Connected to PostgreSQL successfully."
# run a migration
bundle exec rails db:migrate
echo "Haciendo migracion"
# Run your Rails task
bundle exec rails seismic:fetch_data

# Then start the server
exec bundle exec rails server -b 0.0.0.0
