# Docker container for the PascalCoin daemon

This Dockerfile compiles PascalCoin from source and runs the pascalcoin daemon.

The build includes 3 paramaters:

**`PASCAL_CHECKOUT`: (default = `master`)**

The argument passed to the `git checkout` command. Use a branch or a tag. 

For example `Releases/3.0.1` will checkout the `Releases/3.0.1` branch.

**`OPENSSL_VERSION` (default = `1.1.0h`)**

The openssl version to download and compile. Normally there is no need to 
change this value.

**`CRYPRO_VERSION` (default `1.1`)**

The resulting version number of the compiled openssl libcrypto lib 
(libcrypto.`1.1`). Normally there is no need to change this value.

## Build and run

This is the simplest example, build the container with defaults:

`docker build -t pascalcoin ./`

`docker run -p 127.0.0.1:4003:4003 -p 127.0.0.1:4004:4004 -p 127.0.0.1:4009:4009 -i -t pascalcoin`

Now with another branch as compile target for pascalcoin:

`docker build --build-arg PASCAL_CHECKOUT=Releases/3.0.2 -t pascalcoin ./`

`docker run -p 127.0.0.1:4003:4003 -p 127.0.0.1:4004:4004 -p 127.0.0.1:4009:4009 -i -t pascalcoin`

### Share keys and run a full node

Create a folder with a name of your choice (eg. `PascalCoin`) and add a `Data` 
folder to it.

Download https://github.com/PascalCoin/PascalCoin/releases/download/2.1.9/BlockChainStream_196623.zip 
and put it into your `Data` folder. 

Change the rights so everyone can write (sorry..) 

If you want your daemon to have access to a wallet, you can put your Wallet 
Keyfile in the `PascalCoin` folder.

Configure the daemon through the pascalcoin_daemon.ini in this repository and
start docker using the following command:

```
docker run \
    -p 127.0.0.1:4003:4003 \
    -p 127.0.0.1:4004:4004 \
    -p 127.0.0.1:4009:4009 \
    -v /abs/olu/the/path/to/PascalCoin:/home/pascal/PascalCoin \
    -v $(pwd)/pascalcoin_daemon.ini:/home/pascal/pascalcoin_bin/pascalcoin_daemon.ini \
    -i -t pascalcoin`
```

