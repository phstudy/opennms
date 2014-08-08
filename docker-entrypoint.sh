#!/bin/bash
#set -e

if [ -z "$POSTGRES_PORT_5432_TCP" ]; then
	echo >&2 'error: missing POSTGRES_PORT_5432_TCP environment variable'
	echo >&2 ' Did you forget to --link some_postgres_container:postgres ?'
	exit 1
fi

sed -i s#jdbc:postgresql://.*/#jdbc:postgresql://$POSTGRES_PORT_5432_TCP_ADDR:$POSTGRES_PORT_5432_TCP_PORT/#g $OPENNMS_HOME/etc/opennms-datasources.xml

# Insert SQL files
if ! [ -e .sql_inited ]; then
	$OPENNMS_HOME/bin/runjava -s
	$OPENNMS_HOME/bin/install -l /usr/local/lib -dis

	touch .sql_inited
fi

exec "$@"
