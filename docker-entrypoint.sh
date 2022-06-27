#!/usr/bin/env bash
php artisan key:generate
php artisan storage:link
php artisan migrate --force
supervisord -n -c /supervisord.conf
