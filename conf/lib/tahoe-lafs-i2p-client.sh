#! /usr/bin/env sh
set -euo
export PLUGIN=$1
export CONFIG=$2
export I2P=$3
. $PLUGIN/lib/usr/bin/activate
if [ ! -d "$PLUGIN/client_config" ]; then
	 SUFFIX=`cat /dev/urandom | tr -dc '[:alpha:]' | fold -w 4 | head -n 1`
  tahoe create-client --introducer="tahoe-lafs-i2p-introducer" --hide-ip --nickname="tahoe-i2p-$SUFFIX" -C $PLUGIN/client_config
  echo "[i2p]" >> $PLUGIN/tahoe.cfg
  echo "  enabled = true" >> $PLUGIN/client_config/tahoe.cfg
  echo "  sam.port =" >> $PLUGIN/client_config/tahoe.cfg
  echo "[connections]" >> $PLUGIN/client_config/tahoe.cfg
  echo "  tcp = disabled" >> $PLUGIN/client_config/tahoe.cfg
  mkdir -p $PLUGIN/client_config/private
  echo "introducers:" >> $PLUGIN/client_config/private/introducers.yaml
  echo "  zoidberg:" >> $PLUGIN/client_config/private/introducers.yaml
  echo "    furl: pb://cys5w43lvx3oi5lbgk6liet6rbguekuo@i2p:sagljtwlctcoktizkmyv3nyjsuygty6tpkn5riwxlruh3f2oze2q.b32.i2p/introducer" >> $PLUGIN/client_config/private/introducers.yaml
  echo "  darknut:" >> $PLUGIN/client_config/private/introducers.yaml
  echo "    furl: pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus" >> $PLUGIN/client_config/private/introducers.yaml
fi
tahoe start --config=$PLUGIN/client_config
