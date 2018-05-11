# Docker container for the PascalCoin daemon

This Dockerfile can be used to compile and run the pascalcoin daemon.

The build includes 3 paramaters:

**`PASCAL_CHECKOUT`: (default = `master`)**

The argument passed to the `git checkout` command. For example `Releases/3.0.2` will checkout the `Releases/3.0.2` branch.

**`OPENSSL_VERSION` (default = `1.1.0h`)**

The openssl version to download and compile.

**`CRYPRO_VERSION` (default `1.1`)**
The resulting version number of the openssl libcrypto lib.

## Build and run

This is the simplest example:

`docker build -t pascalcoin ./`

`docker run -p 127.0.0.1:4003:4003 -p 127.0.0.1:4004:4004 -p 127.0.0.1:4009:4009 -i -t pascalcoin`

Now with another branch as compile target for pascalcoin:

`docker build --build-arg PASCAL_CHECKOUT=Releases/3.0.2 -t pascalcoin ./`

`docker run -p 127.0.0.1:4003:4003 -p 127.0.0.1:4004:4004 -p 127.0.0.1:4009:4009 -i -t pascalcoin`