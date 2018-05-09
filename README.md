# Docker container for the PascalCoin daemon

`docker build -t pascalcoin ./`

`docker run -p 127.0.0.1:4003:4003 -p 127.0.0.1:4004:4004 -p 127.0.0.1:4009:4009 -i -t pascalcoin`
