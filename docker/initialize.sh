#!/usr/bin/env bash
set -ex

echo 'Ensuring .env.development.local file exists'
touch .env.development.local

echo 'Removing orphan containers'
docker compose down --volumes --remove-orphans

echo 'Building containers'
docker compose build

echo 'Kickstarting database'
docker compose run --rm app bundle exec rake db:create db:migrate db:test:load db:seed

echo 'Done! Please run "docker compose up" to start'
