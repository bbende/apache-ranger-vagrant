#!/usr/bin/env bash

CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RANGER_ENV="$CURR_DIR/ranger-env.sh"

# Check if ranger-env.sh exists, exit if not found
if [ ! -f $RANGER_ENV ]; then
   echo "Could not find ranger.properties, exiting..."
   exit 1
else
   source $RANGER_ENV
fi

# Check if RANGER_HOME was provided, exit if not found
if [ -z $RANGER_HOME ]; then
  echo "Could not find RANGER_HOME which should be defined in ranger.properties, exiting..."
  exit 1
fi

TARGET_DIR="$RANGER_HOME/target"
LATEST_TAR=`ls -t $TARGET_DIR/ranger-*-admin.tar.gz | head -1`
echo "Using Apache Ranger from $LATEST_TAR..."

# Check if RANGER_HOME was provided, exit if not found
if [ -z $LATEST_TAR ]; then
  echo "Could not find ranger admin tar.gz in $TARGET_DIR, exiting..."
  exit 1
fi

STAGE_DIR="$CURR_DIR/../stage"

echo "Removing old artifact $STAGE_DIR/ranger-*-admin.tar.gz..."
rm $STAGE_DIR/ranger-*-admin.tar.gz

echo "Copying $LATEST_TAR to $STAGE_DIR..."
cp $LATEST_TAR $STAGE_DIR/

STAGED_TAR=`ls -t $STAGE_DIR/ranger-*-admin.tar.gz | head -1`
echo "Extracting $STAGED_TAR..."
tar xzf $STAGED_TAR -C $STAGE_DIR
