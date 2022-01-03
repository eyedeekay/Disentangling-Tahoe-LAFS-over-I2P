
INTRODUCERURL="pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus"

VERSION="0.0.1"

CLIENT="tahoe-lafs-client"
STORAGE="tahoe-lafs-storage"
INTRODUCER="tahoe-lafs-intro"
REPO=Disentangling-Tahoe-LAFS-over-I2P

SIGNER=hankhill19580@gmail.com

plugin-base: clean tahoe-lafs-i2p
	mkdir -p conf/lib
	cp -rv tahoe-lafs-i2p conf/lib/usr

tahoe-lafs-i2p: venv
	#./pkg2appimage-1807-x86_64.AppImage tahoe-lafs-i2p.yml

scripts: plugin-base script-client script-storage script-introducer

plugins: scripts plugin-client plugin-storage plugin-introducer

venv:
	virtualenv -p python3 tahoe-lafs-i2p
	bash -c "source tahoe-lafs-i2p/bin/activate && \
	pip install --upgrade cryptography pyopenssl && \
	pip install tahoe-lafs[i2p]"

script-client:
	@echo '#! /usr/bin/env sh' | tee conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'set -euo'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'export PLUGIN=$$1'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'export CONFIG=$$2'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'export I2P=$$3'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '. $$PLUGIN/lib/usr/bin/activate'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'if [ ! -d "$$PLUGIN/client_config" ]; then' | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo "	 SUFFIX=\`cat /dev/urandom | tr -dc '[:alpha:]' | fold -w $${1:-4} | head -n 1\`"  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  tahoe create-client --introducer=$(INTRODUCERURL) --hide-ip --nickname="tahoe-i2p-$$SUFFIX" -C $$PLUGIN/client_config'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "[i2p]" >> $$PLUGIN/client_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
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
	@echo '  echo "  forgetmeknott:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://u647svxoz3my32pn7vsauqksgglo7sjg@i2p:stziep7vjd5unz747t65xz2mafqz2p5h2zc6lzfo5cgpp52lo2vq.b32.i2p/fiajaih6owud2rnuao3hxynjxkyhs5pe" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  happyintroducer1:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://aglapqqo434phjmkljwrr4l3yohbw7ch@i2p:6ekzwdlrrh3l7gx2stijiiyzrowwbzurrnbjlq5x5ou4sjovzcda.b32.i2p/vehp4lg6ayuge2tuqkvsfounfm2iexdc" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  callmeeverytime:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://sshobna54uio463egaci2ow3rynnnwqm@i2p:jf6me53hm7og42ypdvcqm2mqcxt4p7rhpn5ccxxmpzaqnmeor4rq.b32.i2p/iry5xmjbo4xlg4q76fxx2bftcrcpzaz7" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'fi'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'tahoe run --basedir=$$PLUGIN/client_config'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	cp -v conf/lib/tahoe-lafs-i2p-client.sh $(CLIENT)

plugin-clean:
	rm -rf plugin

plugin-client: plugin-clean plugin-base script-client
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
		-updateurl="http://idk.i2p/$(REPO)/$(CLIENT).su3" \
		-website="http://idk.i2p/$(REPO)/" \
		-command="$(CLIENT) $$PLUGIN $$CONFIG $$I2P" \
		-license=AGPL \
		-res=conf/
	unzip -o $(CLIENT).zip -d $(CLIENT)-zip &> /dev/null

script-storage:
	@echo '#! /usr/bin/env sh' | tee conf/lib/tahoe-lafs-i2p-storage.sh
	@echo 'set -euo' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo 'export PLUGIN=$$1' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo 'export CONFIG=$$2' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo 'export I2P=$$3' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '. $$PLUGIN/lib/bin/activate' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo 'if [ ! -d "$$PLUGIN/storage_config" ]; then' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo "	 SUFFIX=\`cat /dev/urandom | tr -dc '[:alpha:]' | fold -w $${1:-4} | head -n 1\`"  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  tahoe create-node --hostname=`cat $$PLUGIN/b32.txt` --introducer=$(INTRODUCERURL) --nickname=tahoe-i2p-storage-$$SUFFIX --listen=tcp -C $$PLUGIN/storage_config'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "reveal-ip-address = false" >> $$PLUGIN/storage_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  sed -i "s|`grep tub.location $$PLUGIN/storage_config/tahoe.cfg`|tub.location = i2p:[YOUR .B32.I2P ADDRESS HERE]|g" $$PLUGIN/storage_config/tahoe.cfg' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  sed -i "s|`grep tub.port $$PLUGIN/storage_config/tahoe.cfg`|tub.port = tcp:7690:interface=127.0.0.1|g" $$PLUGIN/storage_config/tahoe.cfg' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  sed -i "s|`grep expire.enabled $$PLUGIN/storage_config/tahoe.cfg`|expire.enabled = true|g" $$PLUGIN/storage_config/tahoe.cfg' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  sed -i "s|`grep expire.mode $$PLUGIN/storage_config/tahoe.cfg`|expire.mode = age|g" $$PLUGIN/storage_config/tahoe.cfg' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  sed -i "s|`grep expire.override_lease_duration $$PLUGIN/storage_config/tahoe.cfg`|expire.override_lease_duration = 6 month|g" $$PLUGIN/storage_config/tahoe.cfg' | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "[i2p]" >> $$PLUGIN/storage_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "enabled = true" >> $$PLUGIN/storage_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "[connections]" >> $$PLUGIN/storage_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "tcp = disabled" >> $$PLUGIN/storage_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  mkdir -p $$PLUGIN/storage_config/private'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "introducers:" >> $$PLUGIN/storage_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "  zoidberg:" >> $$PLUGIN/storage_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "    furl: pb://cys5w43lvx3oi5lbgk6liet6rbguekuo@i2p:sagljtwlctcoktizkmyv3nyjsuygty6tpkn5riwxlruh3f2oze2q.b32.i2p/introducer" >> $$PLUGIN/storage_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "  darknut:" >> $$PLUGIN/storage_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "    furl: pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus" >> $$PLUGIN/storage_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo '  echo "  forgetmeknott:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://u647svxoz3my32pn7vsauqksgglo7sjg@i2p:stziep7vjd5unz747t65xz2mafqz2p5h2zc6lzfo5cgpp52lo2vq.b32.i2p/fiajaih6owud2rnuao3hxynjxkyhs5pe" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  happyintroducer1:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://aglapqqo434phjmkljwrr4l3yohbw7ch@i2p:6ekzwdlrrh3l7gx2stijiiyzrowwbzurrnbjlq5x5ou4sjovzcda.b32.i2p/vehp4lg6ayuge2tuqkvsfounfm2iexdc" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  callmeeverytime:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://sshobna54uio463egaci2ow3rynnnwqm@i2p:jf6me53hm7og42ypdvcqm2mqcxt4p7rhpn5ccxxmpzaqnmeor4rq.b32.i2p/iry5xmjbo4xlg4q76fxx2bftcrcpzaz7" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'fi'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	@echo 'tahoe run --basedir=$$PLUGIN/storage_config'  | tee -a conf/lib/tahoe-lafs-i2p-storage.sh
	cp -v conf/lib/tahoe-lafs-i2p-storage.sh $(STORAGE)

plugin-storage: plugin-clean plugin-base script-storage
	i2p.plugin.native -name=$(STORAGE) \
		-signer=$(SIGNER) \
		-version "$(VERSION)" \
		-author=$(SIGNER) \
		-autostart=true \
		-clientname=$(STORAGE) \
		-consolename="$(STORAGE) - $(CONSOLEPOSTNAME)" \
		-name="$(STORAGE)" \
		-delaystart="1" \
		-desc="`cat desc`" \
		-exename=$(STORAGE) \
		-icondata=icon/icon.png \
		-updateurl="http://idk.i2p/$(REPO)/$(STORAGE).su3" \
		-website="http://idk.i2p/$(REPO)/" \
		-command="$(STORAGE) $$PLUGIN $$CONFIG $$I2P" \
		-license=AGPL \
		-res=conf/
	unzip -o $(STORAGE).zip -d $(STORAGE)-zip &> /dev/null

script-introducer:
	@echo '#! /usr/bin/env sh' | tee conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo 'set -euo' | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo 'export PLUGIN=$$1' | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo 'export CONFIG=$$2' | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo 'export I2P=$$3' | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '. $$PLUGIN/lib/usr/bin/activate' | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo 'if [ ! -d "$$PLUGIN/introducer_config" ]; then' | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo "	 SUFFIX=\`cat /dev/urandom | tr -dc '[:alpha:]' | fold -w $${1:-4} | head -n 1\`"  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  tahoe create-introducer --hostname=`cat $$PLUGIN/b32.txt` --introducer=$(INTRODUCERURL) --listen=tcp -C $$PLUGIN/introducer_config'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "reveal-ip-address = false" >> $$PLUGIN/introducer_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  sed -i "s|`grep tub.location $$PLUGIN/introducer_config/tahoe.cfg`|tub.location = i2p:[YOUR .B32.I2P ADDRESS HERE]|g" $$PLUGIN/introducer_config/tahoe.cfg' | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  sed -i "s|`grep tub.port $$PLUGIN/introducer_config/tahoe.cfg`|tub.port = tcp:7690:interface=127.0.0.1|g" $$PLUGIN/introducer_config/tahoe.cfg' | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "[i2p]" >> $$PLUGIN/introducer_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "enabled = true" >> $$PLUGIN/introducer_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "[connections]" >> $$PLUGIN/introducer_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "tcp = disabled" >> $$PLUGIN/introducer_config/tahoe.cfg'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  mkdir -p $$PLUGIN/introducer_config/private'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "introducers:" >> $$PLUGIN/introducer_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "  zoidberg:" >> $$PLUGIN/introducer_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "    furl: pb://cys5w43lvx3oi5lbgk6liet6rbguekuo@i2p:sagljtwlctcoktizkmyv3nyjsuygty6tpkn5riwxlruh3f2oze2q.b32.i2p/introducer" >> $$PLUGIN/introducer_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "  darknut:" >> $$PLUGIN/introducer_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "    furl: pb://vxtvdbdibl46yhcjmn4i7yyyskdhfenk@i2p:axru35rlyahg25ydfpcubp5bzktmrafv5bo5ydf5xdox43e3koua.b32.i2p/66p6uo7td6ubnj3moeb23zwjzxb6egus" >> $$PLUGIN/introducer_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo '  echo "  forgetmeknott:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://u647svxoz3my32pn7vsauqksgglo7sjg@i2p:stziep7vjd5unz747t65xz2mafqz2p5h2zc6lzfo5cgpp52lo2vq.b32.i2p/fiajaih6owud2rnuao3hxynjxkyhs5pe" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  happyintroducer1:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://aglapqqo434phjmkljwrr4l3yohbw7ch@i2p:6ekzwdlrrh3l7gx2stijiiyzrowwbzurrnbjlq5x5ou4sjovzcda.b32.i2p/vehp4lg6ayuge2tuqkvsfounfm2iexdc" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "  callmeeverytime:" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo '  echo "    furl: pb://sshobna54uio463egaci2ow3rynnnwqm@i2p:jf6me53hm7og42ypdvcqm2mqcxt4p7rhpn5ccxxmpzaqnmeor4rq.b32.i2p/iry5xmjbo4xlg4q76fxx2bftcrcpzaz7" >> $$PLUGIN/client_config/private/introducers.yaml'  | tee -a conf/lib/tahoe-lafs-i2p-client.sh
	@echo 'fi'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	@echo 'tahoe run --basedir=$$PLUGIN/introducer_config'  | tee -a conf/lib/tahoe-lafs-i2p-introducer.sh
	cp -v conf/lib/tahoe-lafs-i2p-introducer.sh $(INTRODUCER)

plugin-introducer: plugin-clean plugin-base script-introducer
	i2p.plugin.native -name=$(INTRODUCER) \
		-signer=$(SIGNER) \
		-version "$(VERSION)" \
		-author=$(SIGNER) \
		-autostart=true \
		-clientname=$(INTRODUCER) \
		-consolename="$(INTRODUCER) - $(CONSOLEPOSTNAME)" \
		-name="$(INTRODUCER)" \
		-delaystart="1" \
		-desc="`cat desc`" \
		-exename=$(INTRODUCER) \
		-icondata=icon/icon.png \
		-updateurl="http://idk.i2p/$(REPO)/$(INTRODUCER).su3" \
		-website="http://idk.i2p/$(REPO)/" \
		-command="$(INTRODUCER) $$PLUGIN $$CONFIG $$I2P" \
		-license=AGPL \
		-res=conf/
	unzip -o $(INTRODUCER).zip -d $(INTRODUCER)-zip &> /dev/null

clean: plugin-clean
	rm -rf conf *.zip *.su3 *-zip tahoe-lafs-i2p

docker:
	docker build -t eyedeekay/tahoe-lafs .

docker-client:
	docker run -it --net=host --name tahoe-lafs-client eyedeekay/tahoe-lafs bash -c "/app/lib/tahoe-lafs-client /app /app /app"
	#docker run -it --net=host --name tahoe-lafs-client eyedeekay/tahoe-lafs ls lib

index:
	@echo "<html>" > index.html
	@echo "<head>" >> index.html
	@echo "<title>Tahoe-LAFS I2P Plugin</title>" >> index.html
	@echo "</head>" >> index.html
	@echo "<body>" >> index.html
	markdown README.md >> index.html
	@echo "</body>" >> index.html
	@echo "</html>" >> index.html
	