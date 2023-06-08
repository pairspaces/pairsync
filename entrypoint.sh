#!/bin/sh

set -ue

REGION="${INPUT_REGION}"
REPOSITORY=`echo "${INPUT_REPOSITORY}" | sed 's/\//-/g'`
USER="${INPUT_USER}"
URL="https://git-codecommit.${REGION}.amazonaws.com/v1/repos/${USER}-${REPOSITORY}"

git config --global --add safe.directory /github/workspace
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git remote add pairspace ${URL}
git push pairspace --mirror
