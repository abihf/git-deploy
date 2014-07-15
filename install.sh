#!/bin/sh

BIN_PATH=/usr/bin
SHARE_PATH=/usr/share/git-deploy

do_install() {
    echo installing
    install -m 755 bin/git-deploy $BIN_PATH
    install -m 755 bin/git-deploy-hook $BIN_PATH
    mkdir -m 755 -p $SHARE_PATH/hooks
    install -m 755 share/hooks/* $SHARE_PATH/hooks/
    echo DONE
}

do_uninstall() {
    echo uninstalling
    rm $BIN_PATH/git-deploy $BIN_PATH/git-deploy-hook $SHARE_PATH/hooks/*
    rmdir $SHARE_PATH/hooks
    rmdir $SHARE_PATH
    echo DONE
}


if [ "-u" = "$1" ]; then
    do_uninstall
else
    do_install
fi
