## edgerouter-backup

A collection of scripts to back up Ubiquiti's Edgerouter (running EdgeOS/Vyatta) to a Github repository.

### How it works

The tool uses a hook of EdgeOS to get triggered with each change to the configuration. The current configuration is then dumped and piped into go-ghwrite to commit and push the change to the configured Github repository.

> **Beware:** although the tool dumps the configuration excluding sensitive parameters, there may still be sensitive data present in the dump. It is therefore advisable to use a *private repository*.

### Installing
