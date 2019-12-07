#!/bin/bash

echo "SET PASSWD START"
psql -c "SELECT datname FROM pg_database
WHERE datistemplate = false;"

_psql () { psql --set ON_ERROR_STOP=1 "$@" ; }    
    
echo "SET PASSWD START"
echo "USER: $POSTGRESQL_USER"
echo "PASSWD: $POSTGRESQL_PASSWORD"
#if [[ ",$postinitdb_actions," = *,simple_db,* ]]; then    
#_psql --set=username="$POSTGRESQL_USER" \    
#      --set=password="$POSTGRESQL_PASSWORD" \    
#<<< "ALTER USER :\"username\" WITH ENCRYPTED PASSWORD :'password';"    
#fi    
echo "PASSWD ONE"
    
#if [ -v POSTGRESQL_MASTER_USER ]; then    
#_psql --set=masteruser="$POSTGRESQL_MASTER_USER" \    
#      --set=masterpass="$POSTGRESQL_MASTER_PASSWORD" \    
#<<'EOF'    
#ALTER USER :"masteruser" WITH REPLICATION;    
#ALTER USER :"masteruser" WITH ENCRYPTED PASSWORD :'masterpass';    
#EOF    
#fi    
    
echo "PASSWD TWO"
if [ -v POSTGRESQL_ADMIN_PASSWORD ]; then    
_psql --set=adminpass="$POSTGRESQL_ADMIN_PASSWORD" \    
<<<"ALTER USER \"postgres\" WITH ENCRYPTED PASSWORD :'adminpass';"    
fi    
    
echo "PASSWD THREE"
if [ -v ENABLE_REPMGR ]; then    
_psql --set=repmgrpass="$REPMGR_PASSWORD" \    
<<< "ALTER USER \"repmgr\" WITH ENCRYPTED PASSWORD :'repmgrpass';"    
fi 
echo "SET PASSWD END"
