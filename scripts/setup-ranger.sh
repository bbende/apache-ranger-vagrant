#!/usr/bin/env bash

echo "Setting up Ranger..."
SHARED_DIR=/vagrant
cd $SHARED_DIR

RANGER_ENV="$SHARED_DIR/scripts/ranger-env.sh"
echo "Loading Ranger evnironment variables from $RANGER_ENV..."
source $RANGER_ENV

STAGE_DIR="$SHARED_DIR/stage"
INSTALL_PROPERTIES_FILE=`ls -t $STAGE_DIR/ranger-*-admin/install.properties | head -1`
echo "Setting DB passwords in $INSTALL_PROPERTIES_FILE..."

sed -i '\|^db_root_password=| s|$|'${DB_ROOT_PASSWORD}'|g' ${INSTALL_PROPERTIES_FILE}
sed -i '\|^db_password=| s|$|'${DB_PASSWORD}'|g' ${INSTALL_PROPERTIES_FILE}
sed -i '\|^audit_db_password=| s|$|'${AUDIT_DB_PASSWORD}'|g' ${INSTALL_PROPERTIES_FILE}
sed -i '\|^audit_solr_urls=| s|$|'${AUDIT_SOLR_URLS}'|g' ${INSTALL_PROPERTIES_FILE}
sed -i '\|^policymgr_supportedcomponents=| s|$|'${SUPPORTED_COMPONENTS}'|g' ${INSTALL_PROPERTIES_FILE}

RANGER_DIR=`ls -t $STAGE_DIR | grep ranger | grep admin | head -1`
FULL_RANGER_DIR="$STAGE_DIR/$RANGER_DIR"
cd $FULL_RANGER_DIR

echo "Running Ranger setup script from $FULL_RANGER_DIR..."
python dba_script.py -q
./setup.sh
./set_globals.sh
./setup.sh

echo "Done setting up Ranger!"
