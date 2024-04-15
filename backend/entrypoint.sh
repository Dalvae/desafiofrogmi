#!/bin/bash
# Wait for PostgreSQL to be ready
while ! pg_isready -h db -p 5432 > /dev/null 2> /dev/null; do
    echo "Connecting to PostgreSQL Failed - Sleeping"
    sleep 1
done

echo "Connected to PostgreSQL successfully."
# Create dB
bundle exec rake db:create
echo "Creando la DB"
# Run migration
bundle exec rails db:migrate
echo "Haciendo migracion"
# Run your Rails task
bundle exec rails seismic:fetch_data

# Remove server.pid if it exists
if [ -f /rails/tmp/pids/server.pid ]; then
  rm /rails/tmp/pids/server.pid
fi
# Then continue with normal startup

# Then start the server
exec bundle exec rails server -b 0.0.0.0
