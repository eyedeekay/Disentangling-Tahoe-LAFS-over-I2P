#! /usr/bin/env sh
set -euo
export PLUGIN=$1
export CONFIG=$2
export I2P=$3
. LUGIN/lib/bin/activate
if [ ! -d "$PLUGIN/storage_config" ]; then
	 SUFFIX=`cat /dev/urandom | tr -dc '[:alpha:]' | fold -w 4 | head -n 1`
  tahoe create-introducer --listen=tcp --hostname=$TAHOE_LISTENER -C \$PLUGIN/storage_config
  mkdir -p $PLUGIN/storage_config/private
  echo "introducers:" >> $PLUGIN/storage_config/private/introducers.yaml
  echo "  zoidberg:" >> $PLUGIN/storage_config/private/introducers.yaml
  echo "    furl: pb://cys5w43lvx3oi5lbgk6liet6rbguekuo@i2p:sagljtwlctcoktizkmyv3nyjsuygty6tpkn5riwxlruh3f2oze2q.b32.i2p/introducer" >> $PLUGIN/storage_config/private/introducers.yaml
  echo "  darknut:" >> $PLUGIN/storage_config/private/introducers.yaml
  echo "    furl: pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus" >> $PLUGIN/storage_config/private/introducers.yaml
fi
tahoe start --config=$PLUGIN/storage_config
