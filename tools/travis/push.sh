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

has_git_changes() {
  git diff-index --quiet HEAD -- || echo "Has untracked files."
}

setup_git() {
  echo "Configuring git."
  git config --global user.email "herdy.handoko@gmail.com"
  git config --global user.name "Herdy Handoko"
  git checkout master
}

commit_website_files() {
  echo "Adding untracked files."
  git add --all docs
  git status
  git commit --message "Update docs (Travis build: ${TRAVIS_BUILD_NUMBER})" --message "See https://travis-ci.org/hhandoko/diskusi/builds/${TRAVIS_BUILD_ID}"
}

upload_files() {
  echo "Pushing documentation upstream."
  git remote add origin-docs https://${GH_TOKEN}@github.com/hhandoko/diskusi.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-docs master
}

if has_git_changes; then
  setup_git
  commit_website_files
  upload_files
fi
