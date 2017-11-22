#!/bin/bash

GIT_URL=https://github.com/google/material-design-icons.git
GIT_DIR=material-design-icons
TARGET_DIR=icons
QRC_FILE=$TARGET_DIR/icons.qrc
TXT_FILE=src/demo/qml/icons.txt

function copy_icon()
{
    for FILE in $ICONS; do
        ICON=$(basename $FILE)
        NEW_NAME=$(echo $ICON | sed -E 's/ic_(.*)_24px.svg/\1.svg/' | sed -E 's/ic_(.*)_26x24px.svg/\1.svg/' | sed -E 's/ic_(.*)_48px.svg/\1.svg/')
        BASE_NAME=$(echo $NEW_NAME | sed -E 's/.svg//')
        if [ ! -f $TARGET_DIR/$CATEGORY/$NEW_NAME ]; then
            cp $FILE $TARGET_DIR/$CATEGORY/$NEW_NAME
            chmod 644 $TARGET_DIR/$CATEGORY/$NEW_NAME
            echo "        <file>$CATEGORY/$NEW_NAME</file>" >> $QRC_FILE
            echo -e "\t$BASE_NAME" >> $TXT_FILE
        fi
    done
}

rm -rf $GIT_DIR
git clone $GIT_URL

CATEGORIES=$(ls -1 -d  $GIT_DIR/*/drawable-mdpi | awk -F/ '{ print $2 }')

rm -rf $TARGET_DIR
mkdir -p $TARGET_DIR

> $TXT_FILE

echo "<RCC>
    <qresource prefix=\"/Fluid/Controls/\">" > $QRC_FILE
for CATEGORY in ${CATEGORIES[*]}; do
    echo "$CATEGORY" >> $TXT_FILE

    if [ -d $TARGET_DIR/$CATEGORY ]; then
    	rm -r $TARGET_DIR/$CATEGORY
    fi

    mkdir $TARGET_DIR/$CATEGORY

    ICONS=$(ls $GIT_DIR/$CATEGORY/svg/production/*48px*)
    copy_icon

    ICONS=$(ls $GIT_DIR/$CATEGORY/svg/production/*24px*)
    copy_icon
done

echo "    </qresource>
</RCC>
" >> $QRC_FILE

rm -rf $GIT_DIR
