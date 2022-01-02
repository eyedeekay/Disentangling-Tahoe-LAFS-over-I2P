
INTRODUCER="pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus"

VERSION="0.0.1"

CLIENT="tahoe-lafs-i2p-client"
STORAGE="tahoe-lafs-i2p-storage"
INTRODUCER="tahoe-lafs-i2p-introducer"

SIGNER=hankhill19580@gmail.com

plugin-base: clean
	mkdir -p conf/lib
	cp -rv tahoe-lafs-i2p/tahoe-lafs-i2p.AppDir/usr conf/lib/

scripts: plugin script-client script-storage script-introducer

script-client:
	@echo '#! /usr/bin/env sh' | tee conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'set -euo'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'export PLUGIN=$$1'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'export CONFIG=$$2'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'export I2P=$$3'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '. $$PLUGIN/lib/usr/bin/activate'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'if [ ! -d "$$PLUGIN/client_config" ]; then' | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo "	 SUFFIX=\`cat /dev/urandom | tr -dc '[:alpha:]' | fold -w $${1:-4} | head -n 1\`"  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  tahoe create-client --introducer=$(INTRODUCER) --hide-ip --nickname="tahoe-i2p-$$SUFFIX" -C \$$PLUGIN/client_config'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "[i2p]" >> $$PLUGIN/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  enabled = true" >> $$PLUGIN/client_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  sam.port =" >> $$PLUGIN/client_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "[connections]" >> $$PLUGIN/client_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  tcp = disabled" >> $$PLUGIN/client_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  mkdir -p $$PLUGIN/client_config/private'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "introducers:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  zoidberg:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://cys5w43lvx3oi5lbgk6liet6rbguekuo@i2p:sagljtwlctcoktizkmyv3nyjsuygty6tpkn5riwxlruh3f2oze2q.b32.i2p/introducer" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  darknut:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'fi'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'tahoe start --config=$$PLUGIN/client_config'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	cp -v conf/lib/tahoe-lafs-i2p-client.sh tahoe-lafs-i2p-client

plugin-clean:
	rm -rf plugin

plugin-client: plugin-clean script-client
	i2p.plugin.native -name=$(CLIENT) \
		-signer=$(SIGNER) \
		-version "$(VERSION)" \
		-author=$(SIGNER) \
		-autostart=true \
		-clientname=$(CLIENT) \
		-consolename="$(CLIENT) - $(CONSOLEPOSTNAME)" \
		-name="$(CLIENT)" \
		-delaystart="1" \
		-desc="`cat desc`" \
		-exename=$(CLIENT) \
		-icondata=icon/icon.png \
		-updateurl="http://idk.i2p/$(CLIENT)/$(CLIENT).su3" \
		-website="http://idk.i2p/$(CLIENT)/" \
		-command="$(CLIENT) -conf \"\$$PLUGIN/catbox-i2p.conf\"" \
		-license=AGPL \
		-res=conf/
	unzip -o $(CLIENT).zip -d $(CLIENT)-zip

script-storage:
	@echo '#! /usr/bin/env sh' | tee conf/lib/tahoe-lafs-i2p-storage.sh
	@echo 'set -euo' | tee conf/lib/tahoe-lafs-i2p-storage.sh
	@echo 'export PLUGIN=$1' | tee conf/lib/tahoe-lafs-i2p-storage.sh
	@echo 'export CONFIG=$2' | tee conf/lib/tahoe-lafs-i2p-storage.sh
	@echo 'export I2P=$3' | tee conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '. $PLUGIN/lib/bin/activate' | tee conf/lib/tahoe-lafs-i2p-storage.sh
	cp -v conf/lib/tahoe-lafs-i2p-storage.sh tahoe-lafs-i2p-storage

plugin-storage: plugin-clean script-storage
	i2p.plugin.native -name=$(CLIENT) \
		-signer=$(SIGNER) \
		-version "$(VERSION)" \
		-author=$(SIGNER) \
		-autostart=true \
		-clientname=$(CLIENT) \
		-consolename="$(CLIENT) - $(CONSOLEPOSTNAME)" \
		-name="$(CLIENT)" \
		-delaystart="1" \
		-desc="`cat desc`" \
		-exename=$(CLIENT) \
		-icondata=icon/icon.png \
		-updateurl="http://idk.i2p/$(CLIENT)/$(CLIENT).su3" \
		-website="http://idk.i2p/$(CLIENT)/" \
		-command="$(CLIENT) -conf \"\$$PLUGIN/catbox-i2p.conf\"" \
		-license=AGPL \
		-res=conf/
	unzip -o $(CLIENT).zip -d $(CLIENT)-zip

script-introducer:
	@echo '#! /usr/bin/env sh' | tee conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo 'set -euo' | tee conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo 'export PLUGIN=$1' | tee conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo 'export CONFIG=$2' | tee conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo 'export I2P=$3' | tee conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '. $PLUGIN/lib/bin/activate' | tee conf/lib/tahoe-lafs-i2p-introducer.sh
	cp -v conf/lib/tahoe-lafs-i2p-introducer.sh tahoe-lafs-i2p-introducer

plugin-introducer: plugin-clean script-introducer
	i2p.plugin.native -name=$(CLIENT) \
		-signer=$(SIGNER) \
		-version "$(VERSION)" \
		-author=$(SIGNER) \
		-autostart=true \
		-clientname=$(CLIENT) \
		-consolename="$(CLIENT) - $(CONSOLEPOSTNAME)" \
		-name="$(CLIENT)" \
		-delaystart="1" \
		-desc="`cat desc`" \
		-exename=$(CLIENT) \
		-icondata=icon/icon.png \
		-updateurl="http://idk.i2p/$(CLIENT)/$(CLIENT).su3" \
		-website="http://idk.i2p/$(CLIENT)/" \
		-command="$(CLIENT) -conf \"\$$PLUGIN/catbox-i2p.conf\"" \
		-license=AGPL \
		-res=conf/
	unzip -o $(CLIENT).zip -d $(CLIENT)-zip

clean:
	rm -rf conf