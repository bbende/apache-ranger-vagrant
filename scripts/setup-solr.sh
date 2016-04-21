#!/usr/bin/env bash

echo "Setting up Solr..."
SHARED_DIR=/vagrant
cd $SHARED_DIR

RANGER_ENV="$SHARED_DIR/scripts/ranger-env.sh"
echo "Loading Ranger evnironment variables from $RANGER_ENV..."
source $RANGER_ENV

echo "INSTALL_SOLR is $INSTALL_SOLR..."

if [ "$INSTALL_SOLR" == "true" ]; then
  STAGE_DIR="$SHARED_DIR/stage"
  cd $STAGE_DIR

  echo "Moving staged Solr to $SOLR_INSTALL_DIR..."
  rm solr*.tgz
  mv $STAGE_DIR/solr* $SOLR_INSTALL_DIR/solr
  chown -R solr:solr $SOLR_INSTALL_DIR/solr

  SOLR_INSTALL_PROPERTIES_FILE=`ls -t $STAGE_DIR/ranger-*-admin/contrib/solr_for_audit_setup/install.properties | head -1`
  echo "Replacing properties in $SOLR_INSTALL_PROPERTIES_FILE..."

  sed -i -e 's|^SOLR_INSTALL_FOLDER=.*$|SOLR_INSTALL_FOLDER='${SOLR_INSTALL_DIR}/solr'|' ${SOLR_INSTALL_PROPERTIES_FILE}
  sed -i -e 's|^SOLR_RANGER_HOME=.*$|SOLR_RANGER_HOME='${SOLR_INSTALL_DIR}/solr/ranger_audit_server'|' ${SOLR_INSTALL_PROPERTIES_FILE}
  sed -i -e 's|^SOLR_RANGER_DATA_FOLDER=.*$|SOLR_RANGER_DATA_FOLDER='${SOLR_INSTALL_DIR}/solr/ranger_audit_server/data'|' ${SOLR_INSTALL_PROPERTIES_FILE}

  RANGER_DIR=`ls -t $STAGE_DIR | grep ranger | grep admin | head -1`
  FULL_RANGER_DIR="$STAGE_DIR/$RANGER_DIR"
  cd $FULL_RANGER_DIR

  RANGER_SOLR_DIR=`ls -t contrib | grep solr | head -1`
  cd contrib/$RANGER_SOLR_DIR

  echo "Running Ranger Solr setup script from $RANGER_SOLR_DIR..."
  ./setup.sh

  echo "Starting Solr for Ranger..."
  su -c "$SOLR_INSTALL_DIR/solr/ranger_audit_server/scripts/start_solr.sh" -s /bin/sh solr
fi
