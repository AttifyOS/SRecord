#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${APM_TMP_DIR}" ]]; then
    echo "APM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${APM_PKG_INSTALL_DIR}" ]]; then
    echo "APM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${APM_PKG_BIN_DIR}" ]]; then
    echo "APM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/AttifyOS/SRecord/releases/download/v1.64/srecord-1.64-build.tar.gz -O $APM_TMP_DIR/srecord-1.64-build.tar.gz
  tar xf $APM_TMP_DIR/srecord-1.64-build.tar.gz -C $APM_PKG_INSTALL_DIR/
  chmod +x $APM_PKG_INSTALL_DIR/bin/srec_{cat,cmp,info}
  ln -s $APM_PKG_INSTALL_DIR/bin/srec_{cat,cmp,info} $APM_PKG_BIN_DIR/
  rm $APM_TMP_DIR/srecord-1.64-build.tar.gz
}

uninstall() {
  rm -rf $APM_PKG_INSTALL_DIR/{bin,include,share,lib}
  rm $APM_PKG_BIN_DIR/srec_{cat,cmp,info}
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1