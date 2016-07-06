#! /bin/bash

GIT_DIR=material-design-icons
TARGET_DIR=icons

CATEGORIES=(action av communication device file image maps notification social toggle alert content editor hardware navigation)

if [ -d $GIT_DIR ]; then
    pushd $GIT_DIR; git pull; popd
else
    git clone https://github.com/google/material-design-icons.git $GIT_DIR
fi

mkdir -p $TARGET_DIR

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
	done
done
