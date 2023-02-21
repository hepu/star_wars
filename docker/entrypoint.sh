#!/bin/bash
set -e

rm -f /tmp/server.pid
exec "$@"
