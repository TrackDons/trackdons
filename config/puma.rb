#!/usr/bin/env puma

environment ENV['RAILS_ENV'] || 'production'

daemonize true

pidfile "/var/www/trackdons.org/shared/tmp/pids/puma.pid"
stdout_redirect "/var/www/trackdons.org/shared/tmp/log/stdout", "/var/www/trackdons.org/shared/tmp/log/stderr"

threads 0, 16

bind "unix:///var/www/trackdons.org/shared/tmp/sockets/puma.sock"