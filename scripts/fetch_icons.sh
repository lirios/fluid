#!/bin/bash

rootdir=$(readlink -f `dirname $0`/..)

GIT_URL=https://github.com/google/material-design-icons.git
GIT_DIR=material-design-icons
TARGET_DIR=${rootdir}/src/imports/controls/icons
RELATIVE_DIR=icons
QRC_FILE=${rootdir}/src/imports/controls/icons.qrc
TXT_FILE=${rootdir}/src/demo/qml/icons.txt

function copy_icon()
{
    for NAME in $ICONS; do
        source_path=$GIT_DIR/src/$CATEGORY/$NAME/materialicons/24px.svg
        [ ! -f $source_path ] && continue
        dest_path=$TARGET_DIR/$CATEGORY/$NAME.svg
        if [ ! -f $dest_path ]; then
            cp $source_path $dest_path
            chmod 644 $dest_path
            echo "        <file>$RELATIVE_DIR/$CATEGORY/$NAME.svg</file>" >> $QRC_FILE
            echo -e "\t$NAME" >> $TXT_FILE
        fi
    done
}

if [ -d $GIT_DIR ]; then
    (cd $GIT_DIR && git pull)
else
    git clone --depth 1 $GIT_URL
fi

CATEGORIES=$(ls -1 -d  $GIT_DIR/src/*/*/materialicons/*.svg | awk -F/ '{ print $3 }' | uniq)

rm -rf $TARGET_DIR
mkdir -p $TARGET_DIR

> $TXT_FILE

cat > $QRC_FILE <<EOF
<RCC>
    <qresource prefix="/liri.io/imports/Fluid/Controls/">
EOF
for CATEGORY in ${CATEGORIES[*]}; do
    echo "$CATEGORY" >> $TXT_FILE

    if [ -d $TARGET_DIR/$CATEGORY ]; then
    	rm -r $TARGET_DIR/$CATEGORY
    fi

    mkdir $TARGET_DIR/$CATEGORY

    ICONS=$(ls -1 $GIT_DIR/src/$CATEGORY)
    copy_icon
done
cat >> $QRC_FILE <<EOF
    </qresource>
</RCC>
EOF
