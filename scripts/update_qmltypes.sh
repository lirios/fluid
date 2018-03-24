#!/bin/bash

QMLPLUGINDUMP=${QMLPLUGINDUMP-qmlplugindump}

case $1 in
-h|--help)
    echo "Usage: $(basename $0) [IMPORT_PATH]"
    echo "it uses either '$(which qmlplugindump)' or the one set by 'QMLPLUGINDUMP'"
    exit 1
;;
esac

cmd="${QMLPLUGINDUMP} -noinstantiate -notrelocatable -platform minimal"
curpath=`dirname $0`
rootpath=`dirname $(readlink -e $curpath)`

function update() {
    impname=$1
    impver=$2
    module=$3

    echo "Update $impname $impver ..."
    $cmd $impname $impver > $rootpath/src/imports/$module/plugins.qmltypes
}

update Fluid.Core 1.0 core
update Fluid.Controls 1.0 controls
update Fluid.Controls.Private 1.0 controls-private
update Fluid.Effects 1.0 effects
update Fluid.Layouts 1.0 layouts
update Fluid.Templates 1.0 templates
