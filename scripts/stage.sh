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
echo "Using Apache Ranger Admin from $LATEST_TAR..."

LATEST_USERSYNC_TAR=`ls -t $TARGET_DIR/ranger-*-usersync.tar.gz | head -1`
echo "Using Apache Ranger User Sync from $LATEST_USERSYNC_TAR..."

# Check if Ranger Admin tar was found, exit if not found
if [ -z $LATEST_TAR ]; then
  echo "Could not find ranger admin tar.gz in $TARGET_DIR, exiting..."
  exit 1
fi

# Check if Ranger Admin tar was found, exit if not found
if [ -z $LATEST_USERSYNC_TAR ]; then
  echo "Could not find ranger usersync tar.gz in $TARGET_DIR, exiting..."
  exit 1
fi

STAGE_DIR="$CURR_DIR/../stage"

echo "Removing old artifact $STAGE_DIR/ranger-* ..."
rm -rf $STAGE_DIR/ranger-*

echo "Copying $LATEST_TAR to $STAGE_DIR..."
cp $LATEST_TAR $STAGE_DIR/

echo "Copying $LATEST_USERSYNC_TAR to $STAGE_DIR..."
cp $LATEST_USERSYNC_TAR $STAGE_DIR/

STAGED_TAR=`ls -t $STAGE_DIR/ranger-*-admin.tar.gz | head -1`
echo "Extracting $STAGED_TAR..."
tar xzf $STAGED_TAR -C $STAGE_DIR

STAGED_USERSYNC_TAR=`ls -t $STAGE_DIR/ranger-*-usersync.tar.gz | head -1`
echo "Extracting $STAGED_USERSYNC_TAR..."
tar xzf $STAGED_USERSYNC_TAR -C $STAGE_DIR

# Stage the solr tar if install solr is set to true
if [ "$INSTALL_SOLR" == "true" ]; then
  echo "Removing old Solr artifacts..."
  rm -rf $STAGE_DIR/solr*
  rm -rf $SOLR_INSTALL_DIR/solr*

  echo "Copying $SOLR_TAR to $STAGE_DIR"
  cp $SOLR_TAR $STAGE_DIR

  STAGED_SOLR_TAR=`ls -t $STAGE_DIR/solr*.tgz | head -1`
  echo "Extracting $STAGED_SOLR_TAR to $STAGE_DIR..."
  tar xzf $STAGED_SOLR_TAR -C $STAGE_DIR
fi

echo "Done staging artifacts!"
