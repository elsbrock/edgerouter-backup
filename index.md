## edgerouter-backup

A collection of scripts to back up Ubiquiti's Edgerouter (running EdgeOS/Vyatta) to a Github repository.

### How it works

The tool uses a hook of EdgeOS to get triggered with each change to the configuration (be it via UI or CLI). The current configuration is then dumped and piped into [`go-ghwrite`](https://github.com/elsbrock/go-ghwrite) to commit and push the change to the configured Github repository. The data is staged via the Github API, so no `git` is required.

> **Beware:** although the tool dumps the configuration excluding sensitive parameters, there may still be sensitive data present in the dump. It is therefore advisable to use a *private repository*.

### Installing

```sh
curl -sSL https://raw.githubusercontent.com/elsbrock/edgerouter-backup/master/install.sh | sh
```

You will be prompted for the slug of the target repository (ie. the repository to which config changes should be written). You will also need to provide a personal access token that can be [created](https://github.com/settings/tokens) on Github. The token needs to have the `repo` scope.

> **Beware:** it is not possible to restrict a personal access token to specific repositories, so it is quite powerful. The data will only be readable for the current user.

### Compatibility

The script was tested on the following devices:

* Edgerouter ER-4

It should work on other Edgerouter models too, but this has not been tested. Please [let me know](https://github.com/elsbrock/edgerouter-backup/edit/gh-pages/index.md) in case you were able to use it on another model and I will add it to this list.

### Credits

These scripts are originally based on [tbyehl/edgerouter-backup](https://github.com/tbyehl/edgerouter-backup); this version gets rid of the `git` dependency and works with Github only. It uses [go-ghwrite](https://github.com/elsbrock/go-ghwrite) under the hood.
