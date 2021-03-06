#!/bin/bash
(
  cd user_img
  ./boot_script.sh
)

BR_NAME=buildroot-2020.02
BR_FILE=${BR_NAME}.tar.bz2
BR_DL=../${BR_FILE}
set -e
if [ ! -f ${BR_DL} ] || ! (bzip2 -q -t ${BR_DL}); then
  (
    cd ..
    rm -f ${BR_FILE}
    wget https://buildroot.org/downloads/${BR_FILE}
  )
fi
tar -xjf ${BR_DL}
cp BR_config ${BR_NAME}/.config
cd buildroot-2020.02
for i in ../patches/*; do
  patch -p1 <$i
done
make

virtualenv -p python3 .venv
source .venv/bin/activate
pip install -r requirements.txt
