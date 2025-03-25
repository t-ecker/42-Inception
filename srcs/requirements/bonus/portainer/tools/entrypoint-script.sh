#!/bin/bash
set -eo pipefail

if [ ! -f "/data/portainer.db" ]; then
    # extract .tar file
    tar -xvzf /portainer.tar.gz
    rm /portainer.tar.gz;

    #run portainer as temporary background process to set the admin password
    /portainer/portainer --admin-password-file /run/secrets/portainer_admin_password &
    PID=$!
    
    #check if initialization is complete
    while [ ! -f "/data/portainer.db" ]; do
        sleep 1
    done

    kill $PID || true
    wait $PID || true
fi

exec /portainer/portainer