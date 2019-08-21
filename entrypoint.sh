#!/bin/bash

# kill me now
sudo /sbin/sshd

export MASTER_DEMO_PORT=15432
export STANDBY_DEMO_PORT=16432
export DEMO_PORT_BASE=25432
export NUM_PRIMARY_MIRROR_PAIRS=3
export WITH_MIRRORS
export WITH_STANDBY
export BLDWRAP_POSTGRES_CONF_ADDONS="fsync=off $BLDWRAP_POSTGRES_CONF_ADDONS"
export DEFAULT_QD_MAX_CONNECT=150

source /usr/local/gpdb/greenplum_path.sh

./demo_cluster.sh 
source $HOME/demo/gpdemo-env.sh
createdb greenplum

echo -e 'host all all 0.0.0.0/0 trust' > $MASTER_DATA_DIRECTORY/pg_hba.conf
pg_ctl restart -D $MASTER_DATA_DIRECTORY

tail -F $HOME/demo/datadirs/gpAdminLogs/*
