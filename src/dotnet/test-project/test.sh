#!/bin/bash
cd $(dirname "$0")

source test-utils.sh vscode

# Run common tests
checkCommon

# Image specific tests
check "dotnet" dotnet --info
check "nuget" dotnet restore
check "msbuild" dotnet msbuild
sudo rm -rf obj bin
check "nvm" bash -c ". /usr/local/share/nvm/nvm.sh && nvm install 10"
check "nvm-node" bash -c ". /usr/local/share/nvm/nvm.sh && node --version"
check "yarn" bash -c ". /usr/local/share/nvm/nvm.sh && yarn --version"
check "git" git --version

git_version_satisfied=false
if (echo a version 2.38.1; git --version) | sort -Vk3 | tail -1 | grep -q git; then
    git_version_satisfied=true
fi

check "gitVersionSatisifed" $git_version_satisfied

# Report result
reportResults
