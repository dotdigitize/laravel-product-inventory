#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
command -v php >/dev/null || { echo 'PHP is required.' >&2; exit 1; }
command -v composer >/dev/null || { echo 'Composer 2 is required.' >&2; exit 1; }
php -r 'exit(PHP_VERSION_ID >= 80300 ? 0 : 1);' || { echo 'PHP 8.3 or newer is required.' >&2; exit 1; }
composer install --no-interaction --prefer-dist
[ -f .env ] || cp .env.example .env
php artisan key:generate --force
mkdir -p storage/app/private
[ -f storage/app/private/products.json ] || printf '[]\n' > storage/app/private/products.json
chmod 0750 storage/app/private
chmod 0640 storage/app/private/products.json
chmod -R ug+rwX storage bootstrap/cache
printf 'Installation complete. Point the web document root to %s/public and set APP_ENV=production, APP_DEBUG=false.\n' "$PWD"
