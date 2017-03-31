# stcli - StorageOS cli image

Make it a little easier to run the [StorageOS CLI tool](https://github.com/storageos/go-cli/releases),
assuming access to Docker.

## Use

```
# Set your environment
$ export STORAGEOS_USERNAME=storageos STORAGEOS_PASSWORD=storageos STORAGEOS_HOST=my.node.name

# Run the program
$ docker run andrelucas/stcli volume ls
NAMESPACE/NAME      SIZE                MOUNTED BY          STATUS
default/redis-1     100GB                                   active
default/scratch1    10GB                                    active
$
```

Naturally that's a lot to type. An alias might help.

```
$ alias stcli='docker run andrelucas/stcli'
$ stcli volume ls
NAMESPACE/NAME      SIZE                MOUNTED BY          STATUS
default/redis-1     100GB                                   active
default/scratch1    10GB                                    active
```

For usage instructions of the CLI tool itself, refer to the StorageOS official
[CLI documentation](https://docs.storageos.com/docs/reference/cli.html).

## Building

First, build the binary:

```
$ dapper
```

This uses Docker to build the binary, via the excellent [Dapper](https://github.com/rancher/dapper) tool from Rancher.

Then, package just the binary into a minimal container:

```
$ docker build --rm -t myid/stcli:latest .
...
$ docker push
```

That's it.
