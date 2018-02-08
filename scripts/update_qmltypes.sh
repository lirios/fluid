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

$cmd Fluid.Core 1.0 $1 > $rootpath/src/imports/core/plugins.qmltypes
$cmd Fluid.Controls 1.0 $1 > $rootpath/src/imports/controls/plugins.qmltypes
$cmd Fluid.Controls.Private 1.0 $1 > $rootpath/src/imports/controls-private/plugins.qmltypes
$cmd Fluid.Effects 1.0 $1 > $rootpath/src/imports/effects/plugins.qmltypes
$cmd Fluid.Layouts 1.0 $1 > $rootpath/src/imports/layouts/plugins.qmltypes
$cmd Fluid.Templates 1.0 $1 > $rootpath/src/imports/templates/plugins.qmltypes
