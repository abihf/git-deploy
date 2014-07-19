#!/bin/sh
#  git-deploy 0.1-alpha
#  Copyright (C) 2014 Abi Hafshin <abi@hafs.in>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

APP_NAME=git-deploy
BIN_PATH=/usr/bin
SHARE_PATH=/usr/share

hook_path=$SHARE_PATH/$APP_NAME/hooks
doc_path=$SHARE_PATH/doc/$APP_NAME

do_install() {
    echo "checking deppendency ..."
    check_dependency || exit 1
    echo "dependency ok"

    echo "now installing ..."
    install -m 755 bin/git-deploy $BIN_PATH
    install -m 755 bin/git-deploy-hook $BIN_PATH

    mkdir -m 755 -p $hook_path
    install -m 755 share/hooks/* $hook_path/

    mkdir -m 755 -p $doc_path
    install -m 755 README.md $doc_path/
    install -m 755 LICENSE $doc_path
    
    echo DONE
}

check_dependency() {
    deps="bash git mkdir ln touch"
    ok=1
    for dep in $deps; do
        program_exists $dep || notfound=1
        if [ "1" = "$notfound" ]; then
            echoerr "ERROR: '$dep' not found. Please install this program"
            ok=0
        fi
    done
    
    if [ "$ok" = "1" ]; then
        program_exists php || echo "Please install php to enable composer hook"
        program_exists node || echo "Please install nodejs to enable npm hook"
        return 0
    else
        return 1
    fi
}

do_uninstall() {
    echo uninstalling
    rm $BIN_PATH/git-deploy $BIN_PATH/git-deploy-hook \
        $hook_path/* $doc_path/*
        
    rmdir $hook_path
    rmdir $doc_path
    rmdir $SHARE_PATH/$APP_NAME
    
    echo DONE
}

program_exists() { which $1 &> /dev/null; }
echoerr() { echo "$@" 1>&2; }

if [ "-u" = "$1" ]; then
    do_uninstall
else
    do_install
fi
