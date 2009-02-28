#!/bin/sh
# consolelog.sh
# For metalog -- log to a console

set -f

source /etc/conf.d/metalog
if [ -z "${CONSOLE}" ] ; then
	CONSOLE="/dev/console"
fi

if [ -z "${FORMAT}" ] ; then
	FORMAT='$1 [$2] $3'
fi

for d in ${CONSOLE} ; do
	echo -e ${FORMAT} >> ${d}
done

exit 0
