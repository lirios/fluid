#!/bin/bash
#
# This file is part of Liri.
#
# Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
#
# $BEGIN_LICENSE:MIT$
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
#
# $END_LICENSE$
#

# Deployment procedure as seen in https://oncletom.io/2016/travis-ssh-deploy/

filename=$1

if [ -z "$filename" ]; then
    echo "Usage: $0 [filename]"
    exit 1
fi

destfilename=$(basename $filename)

ssh-keyscan $DEPLOY_HOST 2>&1 | tee -a $HOME/.ssh/known_hosts
openssl aes-256-cbc -K $encrypted_a841ddf051d0_key -iv $encrypted_a841ddf051d0_iv -in .travis/github_deploy_key_liri_ci.enc -out /tmp/github_deploy_key_liri_ci -d
chmod 600 /tmp/github_deploy_key_liri_ci
eval "$(ssh-agent -s)"
ssh-add /tmp/github_deploy_key_liri_ci
rsync -crvz --rsh="ssh" --delete-after --delete-excluded build/default/fluid-online-doc.*/qdoc_html/ $DEPLOY_USER@$DEPLOY_HOST:$TRAVIS_BRANCH
scp $filename $DEPLOY_USER@$DEPLOY_HOST:$TRAVIS_BRANCH/$destfilename
