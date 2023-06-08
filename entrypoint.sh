#!/bin/sh

set -ue

# REGION="${INPUT_PAIRSPACE_REGION}"
REPOSITORY=`echo "${INPUT_REPOSITORY}" | sed 's/\//-/g'`
URL="https://git-codecommit.us-east-1.amazonaws.com/v1/repos/${REPOSITORY}"

git config --global --add safe.directory /github/workspace
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git remote add sync ${URL}
git push sync --mirror
