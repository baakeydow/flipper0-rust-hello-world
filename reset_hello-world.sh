#!/usr/bin/env bash

ROOT_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
export FLIPPER_FW_SRC_PATH="$ROOT_DIR/RogueMaster"
export FLIPPER_0="$ROOT_DIR/flipper0"

rustup update nightly && rustup target add thumbv7em-none-eabihf && echo "rustup done"

[ -d "$FLIPPER_FW_SRC_PATH" ] && rm -rf $FLIPPER_FW_SRC_PATH && echo "Removed $FLIPPER_FW_SRC_PATH"
[ -d "$FLIPPER_0" ] && rm -rf $FLIPPER_0 && echo "Removed $FLIPPER_0"

git clone --recursive https://github.com/RogueMaster/flipperzero-firmware-wPlugins.git RogueMaster && \
git clone https://github.com/boozook/flipper0.git flipper0 && cd $_ && \
cargo +nightly build -p=fap-build-example --target=thumbv7em-none-eabihf && \
cd $FLIPPER_FW_SRC_PATH && ./fbt fap_fap-build-example && \
python3 scripts/storage.py send build/f7-firmware-C/.extapps/fap-build-example.fap /ext/apps/Misc/app-build-example.fap && \
echo "Done building and sending hello-fap.rs"