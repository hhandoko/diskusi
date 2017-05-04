#!/bin/sh

###
# File     : push.sh
# License  :
#   Copyright (c) 2017 Herdy Handoko
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
# Notes    :
#   See https://gist.github.com/willprice/e07efd73fb7f13f917ea
###

setup_git() {
  git config --global user.email "herdy.handoko@gmail.com"
  git config --global user.name "Herdy Handoko"
}

commit_website_files() {
  git checkout -b master
  git add docs/*
  git commit --message "Update docs (build: $TRAVIS_BUILD_NUMBER)"
}

upload_files() {
  git remote add origin-docs https://${GH_TOKEN}@github.com/hhandoko/diskusi.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-docs master
}

if [ git diff-index --quiet HEAD -- ] && [ "$TRAVIS_BRANCH" == "master" ]; then
  setup_git
  commit_website_files
  upload_files
fi
