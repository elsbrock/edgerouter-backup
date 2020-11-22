## edgerouter-backup

A collection of scripts to back up Ubiquiti's Edgerouter (running EdgeOS/Vyatta) to a Github repository.

### How it works

The tool gets triggered with each change to the configuration (be it via UI or CLI; using a hook). The configuration is then written to the Github repository in a single commit. The data is staged using the Github API, therefore `git` is not required to be installed.

> **Beware:** although the tool dumps the configuration excluding sensitive parameters, there may still be sensitive data present in the dump. It is therefore advisable to use a *private repository*.

### Installing

```sh
# open below's link in your browser to see what it does
curl -sSL https://raw.githubusercontent.com/elsbrock/edgerouter-backup/master/install.sh | sh
```

You will be prompted for the slug of the target repository (ie. the repository to which config changes should be written).

The files are installed into `/config/user-data` and therefore survive reboots and system upgrades.

You will also need to provide a personal access token to push the config. The token can be [created](https://github.com/settings/tokens) on Github. The `repo` scope is mandatory in order to allow writing to the repository. 

> **Beware:** it is not possible to restrict a personal access token to specific repositories, so it is quite powerful. The token will be stored readable for the current user only.

### Compatibility

The script was tested on the following devices:

* Edgerouter ER-4

It should work on other Edgerouter models too, but this has not been tested. Please [let me know](https://github.com/elsbrock/edgerouter-backup/edit/gh-pages/index.md) in case you were able to use it on another model and I will add it to this list.

### Credits

These scripts are originally based on [tbyehl/edgerouter-backup](https://github.com/tbyehl/edgerouter-backup). Compared to that project no external SSH host is required and instead the config is pushed directly to Github, using [`go-ghwrite`](https://github.com/elsbrock/go-ghwrite) under the hood.
