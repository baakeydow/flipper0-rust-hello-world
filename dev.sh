#!/usr/bin/env bash

ROOT_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
export FLIPPER_FW_SRC_PATH="$ROOT_DIR/RogueMaster"
export FLIPPER_APP_DIR="$ROOT_DIR/flipper0"

if [ -d "$FLIPPER_FW_SRC_PATH" ] && [ -f "$FLIPPER_APP_DIR/examples/hello-fap.rs" ];
then
  cd $FLIPPER_APP_DIR && cargo +nightly build -p=fap-build-example --target=thumbv7em-none-eabihf && \
  cd $FLIPPER_FW_SRC_PATH && ./fbt fap_fap-build-example && \
  python3 scripts/storage.py send build/f7-firmware-C/.extapps/fap-build-example.fap /ext/apps/Misc/app-build-example.fap && \
  echo "Done building and sending hello-fap.rs"
else
  echo "Nope that's not quite right... try running `init_hello-world.sh` first"
  echo "You launched the script from $ROOT_DIR"
  exit 1
fi