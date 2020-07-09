#!/bin/sh

set -eou pipefail

CONFIG=/config/user-data/config-backup.env
GOGHWRITE_BIN=/config/user-data/bin/go-ghwrite
CONFHOOK=/config/user-data/hooks/03-config-backup.sh
POSTCONFHOOK=/config/scripts/post-config.d/hooks.sh

if [ ! -f "$CONFIG" ];
then
  read -p "GitHub repo slug (e.g. myrepo/edgerouter-backup): " REPOSLUG
  read -s -p "GitHub personal access token: " GOGHWRITE_TOKEN
  cat <<EOF > $CONFIG
REPOSLUG=$REPOSLUG
export GOGHWRITE_TOKEN=$GOGHWRITE_TOKEN
EOF
fi

if [ ! -x "$GOGHWRITE_BIN" ];
then
  mkdir -p $(dirname $GOGHWRITE_BIN)
  curl -Ls https://github.com/elsbrock/go-ghwrite/releases/latest/download/go-ghwrite_linux-$(uname -m).tar.gz  | tar xzvf - -C $(dirname $GOGHWRITE_BIN)
fi

if [ ! -x "$CONFHOOK" ];
then
  mkdir -p $(dirname $CONFHOOK)
  curl -Ls https://raw.githubusercontent.com/elsbrock/edgerouter-backup/master/hooks/03-config-backup.sh -o $CONFHOOK 
fi

if [ ! -x "$POSTCONFHOOK" ];
then
  mkdir -p $(dirname $POSTCONFHOOK)
  curl -Ls https://raw.githubusercontent.com/elsbrock/edgerouter-backup/master/scripts/post-config.d/hooks.sh -o $POSTCONFHOOK && chmod +x $POSTCONFHOOK
fi

$POSTCONFHOOK
