#!/usr/bin/env bash

# 2 = Origin
# 1 = Tag number

git tag -d $1
# delete remote tag '12345' (eg, GitHub version too)
git push $2 :refs/tags/$1

git tag $1
git push $2 --tags
