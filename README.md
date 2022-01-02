Disentangling-Tahoe-LAFS-over-I2P
=================================

An updated guide to Tahoe LAFS over I2P
---------------------------------------

### Tahoe-LAFS I2P Installation

 1. apt-get install build-essential python-dev libffi-dev libssl-dev python-virtualenv python-pip
 2. pip install --upgrade pip
 3. pip install --upgrade --user cryptography pyopenssl
 4. pip install --user tahoe-lafs[i2p]
    The tahoe binary will be placed in ~/.local/bin.  Create a link in your home folder:
 5. cd ~ && ln -s ~/.local/bin/tahoe

### Create a Tahoe-LAFS I2P client
 1. cd ~
 2. ./tahoe create-client -C ~/tahoe-client
 3. Edit the tahoe.cfg file: 
    nano ~/tahoe-client/tahoe.cfg
    Edit the following lines:
    nickname = [INSERT A NICKNAME FOR YOUR NODE HERE]
    reveal-IP-address = false
    introducer.furl = pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus
    Add the following lines:
    [i2p]
    enabled = true
    sam.port =
    [connections]
    tcp = disabled
 4. Add additional introducers:
    nano ~/tahoe-client/private/introducers.yaml
    Add the following lines:
    introducers:
      zoidberg:
        furl: pb://cys5w43lvx3oi5lbgk6liet6rbguekuo@i2p:sagljtwlctcoktizkmyv3nyjsuygty6tpkn5riwxlruh3f2oze2q.b32.i2p/introducer
      darknut:
        furl: pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus
 5. Start the node:
     ./tahoe start ~/tahoe-client
 6. Open the web frontend:
     http://127.0.0.1:3456