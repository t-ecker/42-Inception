#!/bin/bash
set -eo pipefail

if [ ! -f "/data/portainer.db" ]; then
    tar -xvzf /portainer.tar.gz
    rm /portainer.tar.gz;

    /portainer/portainer --admin-password-file /run/secrets/portainer_admin_password &
    PID=$!
    wait $PID || true
fi

exec /portainer/portainer