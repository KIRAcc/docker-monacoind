## Docker-monacoind
Docker configuration for monacoind.

# How to deploy into your docker
There are 2 steps to deploy.

## STEP1: Run storage container for your wallet.
`docker run -it --name wallet altcoinstools/monacoind-wallet`
Wallet will be in this container.

Edit monacoin.conf before start monacoind up.

`# In the container`
`vi /wallet/monacoin.conf`
Logout from container after you edit monacoin.conf.

## STEP2: Run container for monacoind.
`docker run -d --volumes-from wallet -p 9402:9402 -p 9401:9401 altcoinstools/monacoind`
After deployed, you can call methods via JSON-RPC like this.

`curl --user 'rpcuser:rpcpassword' --data-binary '{"jsonrpc":"1.0","id":"curltext","method":"getinfo","params":[]}' -H 'content-type:text/plain;' http://localhost:9402`
You'll get the result like this.

`{"result":{"version":80700,"protocolversion":70002,"walletversion":60000,"balance":0.00000000,"blocks":586,"timeoffset":0,"connections":1,"proxy":"","difficulty":0.00024414,"testnet":false,"keypoololdest":1409471752,"keypoolsize":101,"paytxfee":0.00000000,"mininput":0.00001000,"errors":""},"error":null,"id":"curltext"}`

# Upgrade
You can remove/upgrade monacoind container. There is no persistent data.

But DON'T REMOVE monacoind-wallet without any backups.

#Tips for boot2docker users
After executing this command, you'll call monacoind by JSON-RPC from your VBox host (like OSX).

`VBoxManage controlvm "boot2docker-vm" natpf1 "monacoind,tcp,127.0.0.1,9402,,9402"`

