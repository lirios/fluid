#!/bin/bash
#
# This file is part of Hawaii.
#
# Copyright (C) 2016 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
#
# $BEGIN_LICENSE:BSD$
#
# You may use this file under the terms of the BSD license as follows:
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#    * Redistributions of source code must retain the above copyright
#      notice, this list of conditions and the following disclaimer.
#    * Redistributions in binary form must reproduce the above copyright
#      notice, this list of conditions and the following disclaimer in the
#      documentation and/or other materials provided with the distribution.
#    * Neither the name of the Hawaii Project nor the
#      names of its contributors may be used to endorse or promote products
#      derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL Pier Luigi Fiorini BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# $END_LICENSE$
#

function check_availability() {
    which $1 >/dev/null
    if [ ! $? -eq 0 ]; then
        echo "$1 is missing, please install it"
        exit 1
    fi
}

# Restrict Bintray deployment to certain branches and a compile
# in order to create artifacts only once
if [ $TRAVIS_BRANCH != "develop" ]; then
    echo "Will not make artifacts for branch $TRAVIS_BRANCH"
    exit 0
fi
if [ $CC != "gcc" ]; then
    echo "Will not make artifacts on $CC builds"
    exit 0
fi

# Check if we are called from the right path
if [ ! -f .travis.yml ]; then
    echo "Please run bintray.sh from the source code directory!"
    exit 1
fi

# Check programs availability
check_availability curl
check_availability makepkg
check_availability repo-add

curdir=$(dirname `readlink -f $0`)
builddir=$curdir/../cibuild
arch=$(uname -m)
gitreponame=$(basename `git rev-parse --show-toplevel`)
gitrev=$(git log -1 --format="%h")
gitdate=$(date -d @$(git log -1 --format="%at") +%Y-%m-%dT%H:%M:%S%z)
pkgver=$(git log -1 --format="%cd" --date=short | tr -d '-').$(git log -1 --format="%h")
version="${_gitdate}.${_gitver}"
today=$(date +"%Y-%m-%d")

api="https://api.bintray.com"
package_url="${api}/packages/${BINTRAY_REPO_OWNER}/archlinux-${TRAVIS_BRANCH}/${gitreponame}"
curl="curl -u${BINTRAY_USER}:${BINTRAY_API_KEY} \
      -H Content-Type:application/json \
      -H Accept:application/json"

function remove_versions() {
    readarray -t versions < <( \
    curl -X GET "${package_url}" \
        | sed -nr 's|.*"versions":\["([^]]*)"\].*|\1|p' \
        | sed 's|","|\n|g' )
    for ((i=0;i<${#versions[@]};i++)); do
        delete_version "${versions[$i]}" || exit $?
    done
}

function delete_version() {
    ${curl} -X DELETE "${package_url}/versions/$1"
}

function make_package() {
    mkdir -p $builddir || exit $?
    cat $curdir/bintray.json.in | \
    sed -e "s,@GITREV@,$gitrev,g" \
        -e "s,@GITDATE@,$gitdate,g" \
        -e "s,@GITBRANCH@,$TRAVIS_BRANCH,g" \
        -e "s,@PKGVER@,$pkgver,g" \
        -e "s,@ARCH@,$arch,g" \
        -e "s,@TODAY@,$today,g" \
        > $builddir/bintray.json || exit $?
    cat $curdir/PKGBUILD.in | \
    sed -e "s,@GITBRANCH@,$TRAVIS_BRANCH,g" \
        -e "s,@PKGVER@,$pkgver,g" \
        > $builddir/PKGBUILD
    pushd $builddir >/dev/null
    makepkg || exit $?
    repo-add ${gitreponame}.db.tar.gz *.pkg.tar.xz || exit $?
    popd >/dev/null

    remove_versions
}

make_package
