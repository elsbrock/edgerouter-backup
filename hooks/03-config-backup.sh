#!/bin/bash
source /config/user-data/config-backup.env

# Pull commit info
COMMIT_VIA=${COMMIT_VIA:-other}
COMMIT_CMT=${COMMIT_COMMENT:-$DEFAULT_COMMIT_MESSAGE}

# If no comment, replace with default
if [ "$COMMIT_CMT" == "commit" ];
then
    COMMIT_CMT=$DEFAULT_COMMIT_MESSAGE
fi

# Check if rollback
if [ $# -eq 1 ] && [ $1 = "rollback" ];
then
    COMMIT_VIA="rollback/reboot"
fi

TIME=$(date +%Y-%m-%d" "%H:%M:%S)
USER=$(whoami)

GIT_COMMIT_MSG="$COMMIT_CMT by $USER via $COMMIT_VIA"

STAGEDIR=$(mktemp -d)
cli-shell-api showConfig --show-active-only --show-ignore-edit --show-show-defaults --show-hide-secrets > $STAGEDIR/config
cli-shell-api showConfig --show-commands --show-active-only --show-ignore-edit --show-show-defaults --show-hide-secrets > $STAGEDIR/commands
#find /config/* | grep -v "/config/dhcpd.leases" | xargs tar cf /tmp/config.tar.gz > $STAGEDIR/config.tar.gz

(cd $STAGEDIR && tar -cf - * | /config/user-data/bin/go-ghwrite -read-tar -commit-msg "${GIT_COMMIT_MSG}" ${REPOSLUG}:)
rm -rf $STAGEDIR

echo "backup done"
