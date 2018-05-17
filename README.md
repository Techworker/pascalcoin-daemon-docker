# Docker container for the PascalCoin daemon

This Dockerfile can be used to compile and run the pascalcoin daemon
in a container.

The build includes 3 paramaters:

**`PASCAL_CHECKOUT`: (default = `master`)**

The argument passed to the `git checkout` command. For example 
`Releases/3.0.1` will checkout the `Releases/3.0.1` branch.

**`OPENSSL_VERSION` (default = `1.1.0h`)**

The openssl version to download and compile.

**`CRYPRO_VERSION` (default `1.1`)**

The resulting version number of the compiled openssl libcrypto lib (libcrypto.1.1)

## Build and run

This is the simplest example, build the container with defaults:

`docker build -t pascalcoin ./`

`docker run -p 127.0.0.1:4003:4003 -p 127.0.0.1:4004:4004 -p 127.0.0.1:4009:4009 -i -t pascalcoin`

Now with another branch as compile target for pascalcoin:

`docker build --build-arg PASCAL_CHECKOUT=Releases/3.0.2 -t pascalcoin ./`

`docker run -p 127.0.0.1:4003:4003 -p 127.0.0.1:4004:4004 -p 127.0.0.1:4009:4009 -i -t pascalcoin`

Running a full node:

Download https://github.com/PascalCoin/PascalCoin/releases/download/2.1.9/BlockChainStream_196623.zip 
and put it into a folder of your choice. 

Change the rights so everyone can write (sorry..) and use the following command to map the data folder:

`docker run -p 127.0.0.1:4003:4003 -p 127.0.0.1:4004:4004 -p 127.0.0.1:4009:4009 -v /abs/olu/the/path/to/data:/home/pascal/PascalCoin/Data -i -t pascalcoin`