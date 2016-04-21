#!/usr/bin/env bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
STAGE_DIR="$CURR_DIR/../stage"

if [ ! -d "$STAGE_DIR" ]; then
  echo "Creating stage directory..."
  mkdir $STAGE_DIR
else
  echo "This script will delete the contents of $STAGE_DIR, would you like to continue?"
  select yn in "Yes" "No"; do
      case $yn in
          Yes ) break;;
          No ) exit;;
      esac
  done
fi

# Copy the latest artifact to the stage directory and extract it
$CURR_DIR/stage.sh

echo "Starting virtual machine..."
vagrant up
echo "Done Bootstrapping VM"

vagrant ssh -- -t 'sudo tail -n 200 -f /var/log/ranger/admin/catalina.out'
