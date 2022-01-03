Disentangling Tahoe LAFS over I2P
=================================

This presents pluginized versions of the [Original Instructions](ORIG.md)
for hosting Tahoe-LAFS nodes over I2P. Those instructions have been turned
into shell scripts which automatically configure your Tahoe-LAFS node for
I2P-only use.

**These plugins are *Unix-ONLY* and depend on bash, python3, and virtualenv**

An updated guide to Tahoe LAFS over I2P
---------------------------------------

In order to keep the Tahoe-LAFS network sustainable over I2P, I recommend
that people who are using this guide host **both** an 1. "Introducer" and 2. 
either a "Client" or "Storage" node.

### Plugin 1: Tahoe-LAFS Introducer Node



#### Introduce your Introducer!

New Tahoe-LAFS users need to be able to find an introducer in order to connect
to the Tahoe-LAFS network. As of the writing of this article, there are only 2
active introducers.

### Plugins 2 and 3: Tahoe-LAFS Client and Storage Nodes


