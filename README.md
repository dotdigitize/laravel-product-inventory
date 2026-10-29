# Coalition Laravel Skills Test

A Laravel product inventory assessment using a locked JSON file as its persistent store, server-side validation, Fetch API requests, and inline product editing.

## Requirements

PHP 8.3+ with Laravel-required extensions, Composer 2, and Apache/Nginx configured to serve the project's `public/` directory. The web process needs write access to `storage/` and `bootstrap/cache/`. No database is used for product data.

## Install

Run `./install.sh` after extracting. It installs Composer dependencies, creates `.env` from `.env.example` if needed, generates an application key, and initializes the private JSON store. Configure the web server document root to this directory's `public/` folder and set production environment values through the server's environment or local `.env` file. Never commit `.env`.

## Development

```sh
composer install
php artisan key:generate
php artisan test
php artisan serve
```

Product records are kept in `storage/app/private/products.json`; writes use an exclusive lock and atomic rename. Money is stored to two decimal places and totals are calculated in cents.
