# stcli - StorageOS cli image

Make it a little easier to run the [StorageOS CLI tool](https://github.com/storageos/go-cli/releases),
assuming access to Docker.

## Use

```
# Run the program
$ docker run andrelucas/stcli -u storageos -p storageos -H my.host volume ls
NAMESPACE/NAME      SIZE                MOUNTED BY          STATUS
default/redis-1     100GB                                   active
default/scratch1    10GB                                    active
```

That's a lot to type for something that's meant to be a shortcut. An alias might help.

```
$ alias stcli='docker run -u storageos -p storageos -H my.host andrelucas/stcli'

$ stcli volume ls
NAMESPACE/NAME      SIZE                MOUNTED BY          STATUS
default/redis-1     100GB                                   active
default/scratch1    10GB                                    active
```

You can use the environment if you prefer, but bear in mind that Docker won't pass environment
variables through without busywork. I still use an alias for this:

```
$ alias stcli='docker run -e STORAGEOS_HOST=$STORAGEOS_HOST \
    -e STORAGEOS_USERNAME=$STORAGEOS_USERNAME \
    -e STORAGEOS_PASSWORD=$STORAGEOS_PASSWORD \
    andrelucas/stcli'

$ stcli volume ls
NAMESPACE/NAME      SIZE                MOUNTED BY          STATUS
default/redis-1     100GB                                   active
default/scratch1    10GB                                    active
```

For usage instructions of the CLI tool itself, refer to the StorageOS official
[CLI documentation](https://docs.storageos.com/docs/reference/cli.html).

## Gotchas

These hints are most likely to be useful for scripting.

Don't rely on the container having your esoteric resolver libraries. It will use the
native Go implementation, and that will not handle fancy stuff like LDAP or mDNS.

If you want to proceed with the container and if you're doing stuff like mDNS lookups,
it might be easier to resolve the hostname beforehand:

```
STORAGEOS_HOST=$(dig +short +search my.host)
```

If you're using mDNS for hostnames, as we do frequently in testing, you'll need a
still-fancier incantation:

```
STORAGEOS_HOST=$(avahi-resolv-host-name -4 my.host.local | cut -f2)
```

## Building

First, build the binary:

```
$ dapper
```

This uses Docker to build the binary, via the excellent [Dapper](https://github.com/rancher/dapper) tool from Rancher.

Then, package just the binary into a minimal Alpine image:

```
$ docker build --rm -t myid/stcli:latest .
...
$ docker push
```

That's it.
