#!/bin/bash
source /config/user-data/config-backup.env

# Fix ownership / permissions
sudo chown -R root:vyattacfg /config/user-data
sudo chown -R root:vyattacfg /config/scripts
sudo chmod -R ug+w /config/user-data
sudo chmod -R ug+w /config/scripts
sudo chmod u=rw /config/user-data/config-backup.env

# Ensure scripts are executable
sudo chmod +x /config/user-data/hooks/*

# Generate symlinks to hook script(s)
sudo ln -fs /config/user-data/hooks/* /etc/commit/post-hooks.d/

exit 0
