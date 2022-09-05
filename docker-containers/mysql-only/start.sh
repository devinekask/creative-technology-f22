#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "switch directory"
cd "$DIR"
echo "starting docker containers"
docker-compose up -d
echo "server up and running"