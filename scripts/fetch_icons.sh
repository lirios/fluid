#!/bin/bash

GIT_URL=https://github.com/google/material-design-icons.git
GIT_DIR=material-design-icons
TARGET_DIR=icons
QRC_FILE=$TARGET_DIR/icons.qrc

rm -rf $GIT_DIR
git clone $GIT_URL

CATEGORIES=(action av communication device file image maps notification social toggle alert content editor hardware navigation)

rm -rf $TARGET_DIR
mkdir -p $TARGET_DIR

echo "<RCC>
    <qresource prefix=\"/Fluid/Controls/\">" > $QRC_FILE
for CATEGORY in ${CATEGORIES[*]}; do
    if [ -d $TARGET_DIR/$CATEGORY ]; then
    	rm -r $TARGET_DIR/$CATEGORY
    fi

    mkdir $TARGET_DIR/$CATEGORY

    ICONS=$(ls $GIT_DIR/$CATEGORY/svg/production/*48px*)

    for FILE in $ICONS; do
        ICON=$(basename $FILE)
        NEW_NAME=$(echo $ICON | sed -E 's/ic_(.*)_48px.svg/\1.svg/')
        cp $FILE $TARGET_DIR/$CATEGORY/$NEW_NAME
        echo "        <file>$CATEGORY/$NEW_NAME</file>" >> $QRC_FILE
    done
done

echo "    </qresource>
</RCC>
" >> $QRC_FILE

rm -rf $GIT_DIR
