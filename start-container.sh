#!/bin/bash
set -e

# Link storage disk if public/storage does not exist
if [ ! -L /app/public/storage ] && [ ! -d /app/public/storage ]; then
  php artisan storage:link || true
fi

# Clear and rebuild cache
php artisan optimize:clear
php artisan optimize

echo "Starting FrankenPHP server for TEMAN BAIK..."

exec docker-php-entrypoint --config /Caddyfile --adapter caddyfile 2>&1
