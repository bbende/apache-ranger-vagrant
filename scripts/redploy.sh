#!/usr/bin/env bash

# Stop the current deployment
echo "Stopping current deployment..."
vagrant ssh -- -t 'sudo ranger-admin stop'

# Copy the latest artifact to the stage directory and extract it
CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
$CURR_DIR/stage.sh

# Start the current deployment and tail the log
echo "Starting new deployment..."
vagrant ssh -- -t 'sudo ranger-admin start;sudo tail -n 200 -f /var/log/ranger/admin/catalina.out'
