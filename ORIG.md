Tahoe-LAFS I2P is certainly not an easy install.  I wanted to post a how-to for new users.  This process has been tested on Ubuntu 18.04 x64.  It does not work on Ubuntu 20.04 and throws the pycryptapp errors that others have mentioned.

[b]Operating System and I2P Installation[/b]
1) Install a fresh copy of Ubuntu 18.04 Server x64
2) apt-get update
3) apt-get upgrade
4) apt-get install openjdk-8-jre
5) wget https://geti2p.net/en/download/0.9.47/clearnet/https/download.i2p2.de/i2pinstall_0.9.47.jar/download
6) java -jar i2pinstall_0.9.47.jar -console      (accept all defaults)
7) cd i2p
8) ./i2prouter start
9) (optional) Open I2P ports through your firewall.  The I2P service selects a random TCP and UDP port number for inbound connections.  If your I2P router sits behind a NAT firewall, forwarding these ports to your router will increase the quality of your connection to the I2P network.  Open the router console at http://127.0.0.1:7657, click I2P Internals on the left side, then click Network to see which ports the service selected.

[b]Tahoe-LAFS I2P Installation[/b] (modified thetinhat.i2p procedure)
1) apt-get install build-essential python-dev libffi-dev libssl-dev python-virtualenv python-pip
2) pip install --upgrade pip
3) pip install --upgrade --user cryptography pyopenssl
4) pip install --user tahoe-lafs[i2p]
    The tahoe binary will be placed in ~/.local/bin.  Create a link in your home folder:
5) cd ~ && ln -s ~/.local/bin/tahoe

[b]Option 1:  Create a Tahoe-LAFS I2P client[/b]
1) cd ~
2) ./tahoe create-client -C ~/tahoe-client
3) Edit the tahoe.cfg file: 
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
4) Add additional introducers:
    nano ~/tahoe-client/private/introducers.yaml
    Add the following lines:
    introducers:
      zoidberg:
        furl: pb://cys5w43lvx3oi5lbgk6liet6rbguekuo@i2p:sagljtwlctcoktizkmyv3nyjsuygty6tpkn5riwxlruh3f2oze2q.b32.i2p/introducer
      darknut:
        furl: pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus
5) Start the node:
     ./tahoe start ~/tahoe-client
6) Open the web frontend:
     http://127.0.0.1:3456

[b]Option 2:  Create a Tahoe-LAFS I2P storage node[/b] (includes client)
* A tahoe storage node requires an inbound I2P hidden service tunnel.  This routes connections from your node's advertised b32 address to the TCP port on which your Tahoe storage node listens for inbound connections.
1) Open the router console:
     https://127.0.0.1:7657
2) Click Hidden Services Manager on the left
3) Under I2P Hidden Services, create a new hidden service of type Standard
     - Add a tunnel name (e.g. Tahoe Storage)
     - Check Auto Start Tunnel
     - Select an arbitrary target port (e.g. 10000)
     - Accept all other defaults and click Save
4) Find the .b32 address of the new tunnel
     Your new tunnel should show up on the list now.  Locate it and copy the Destination line ending in .b32.i2p.  This will be entered in the next step.
5) Create the node folder
     cd ~
     ./tahoe create-node --listen=tcp --hostname=[YOUR .B32.I2P ADDRESS HERE] -C ~/tahoe-storage
6) Edit the tahoe.cfg file
     nano ~/tahoe-storage/tahoe.cfg
     Add the following lines:
         reveal-ip-address = false
         [i2p]
         enabled = true
         [connections]
         tcp = disabled
     Update the following lines:
         tub.location = i2p:[YOUR .B32.I2P ADDRESS HERE]
         tub.port = tcp:[YOUR PORT HERE]:interface=127.0.0.1
         introducer.furl = pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus
         expire.enabled = true
         expire.mode = age
         expire.override_lease_duration = 6 month
7) Add additional introducers:
    nano ~/tahoe-storage/private/introducers.yaml
    Add the following lines:
    introducers:
      zoidberg:
        furl: pb://cys5w43lvx3oi5lbgk6liet6rbguekuo@i2p:sagljtwlctcoktizkmyv3nyjsuygty6tpkn5riwxlruh3f2oze2q.b32.i2p/introducer
      darknut:
        furl: pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus
8) Start the node:
     ./tahoe start ~/tahoe-storage
9) Open the web frontend:
     http://127.0.0.1:3456

[b]Option 3:  Create a Tahoe-LAFS I2P introducer[/b]
* Introducers track which storage nodes are available and provide the list to clients.  Storage nodes register with the introducer, so it is important to have a good introducer list on a storage node.  Once registered, storage nodes remain in the introducer list until the introducer service is restarted.  If you run an introducer, it's a good idea to restart the service every couple months to purge old nodes.
1) Open the router console:
     https://127.0.0.1:7657
2) Click Hidden Services Manager on the left
3) Under I2P Hidden Services, create a new hidden service of type Standard
     - Add a tunnel name (e.g. Tahoe Introducer)
     - Check Auto Start Tunnel
     - Select an arbitrary target port (e.g. 20000)
     - Accept all other defaults and click Save
4) Find the .b32 address of the new tunnel
     Your new tunnel should show up on the list now.  Locate it and copy the Destination line ending in .b32.i2p.  This will be entered in the next step.
5) Create the introducer folder:
     cd ~ 
     ./tahoe create-introducer --listen=tcp --hostname=[YOUR .B32.I2P ADDRESS HERE] -C ~/tahoe-introducer
6) Edit the tahoe.cfg file
     nano ~/tahoe-introducer/tahoe.cfg
     Add the following lines:
         reveal-ip-address = false
         [i2p]
         enabled = true
         [connections]
         tcp = disabled
     Update the following lines:
         tub.location = i2p:[YOUR .B32.I2P ADDRESS HERE]
         tub.port = tcp:[YOUR PORT HERE]:interface=127.0.0.1
7) Start the introducer:
     ./tahoe start ~/tahoe-introducer
8) View your new introducer's furl (this file may take a moment to appear):
     cat ~/tahoe-introducer/private/introducer.furl
9) Add the introducer to your own client and/or storage nodes:
     nano ~/tahoe-client/private/introducers.yaml -or- nano ~/tahoe-storage/private/introducers.yaml
     Add the following lines:
          yourname:
              furl: [YOUR INTRODUCER FURL]
10) Restart your client and/or storage nodes:
     cd ~ && ./tahoe stop ~/tahoe-client && ./tahoe start ~/tahoe-client
     cd ~ && ./tahoe stop ~/tahoe-storage && ./tahoe start ~/tahoe-storage
11) Share your introducer furl with the community:
     http://i2pforum.i2p/viewtopic.php?f=34&t=556&sid=23f3eb57edff8453406324e971c16b3b

I hope this helps bring up some additional nodes on the network.  Reach out to me at darknut@mail.i2p if you run into issues.

The Tin Hat has some excellent articles below with more information about what Tahoe-LAFS is and how to use it once installed:

http://secure.thetinhat.i2p/tutorials/cloud/tahoe-lafs-part-1.html
http://secure.thetinhat.i2p/tutorials/cloud/tahoe-lafs-part-2.html
http://secure.thetinhat.i2p/tutorials/cloud/tahoe-lafs-nodes-part-3.html
