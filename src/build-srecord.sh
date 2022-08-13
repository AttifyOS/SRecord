#!/bin/sh

set -e
apt update && apt install --yes build-essential libgcrypt-dev libboost-dev libtool-bin groff ghostscript patchelf
wget https://sourceforge.net/projects/srecord/files/srecord/1.64/srecord-1.64.tar.gz
tar xf srecord-1.64.tar.gz
mkdir srecord-1.64-build
cd srecord-1.64
./configure --prefix="$(realpath ../srecord-1.64-build)"
make && make install
cd ../srecord-1.64-build
patchelf --set-rpath '$ORIGIN/../lib' bin/srec_cat
patchelf --set-rpath '$ORIGIN/../lib' bin/srec_cmp
patchelf --set-rpath '$ORIGIN/../lib' bin/srec_info
tar czf ../srecord-1.64-build.tar.gz *
