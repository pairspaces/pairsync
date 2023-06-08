#!/bin/sh

set -ue

# Region="${INPUT_PAIRSPACE_REGION}"
RepositoryName="${INPUT_REPOSITORY_NAME}"
CommitUrl="https://git-codecommit.us-east-1.amazonaws.com/v1/repos/${RepositoryName}"

git config --global --add safe.directory /github/workspace
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git remote add sync ${CommitUrl}
git push sync --mirror
