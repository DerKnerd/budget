#!/usr/bin/env sh
php artisan storage:link
php artisan migrate --force
supervisord -n -c supervisord.con
