#!/bin/bash

# pip install git-filter-repo

git filter-repo --path .vscode/ext01_ms-vscode.cpptools-1.17.5_linux-x64.vsix --invert-paths --force

git for-each-ref --format="delete %(refname)" refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now

git push origin --force --all
git push origin --force --tags

git log --all -- .vscode/ext01_ms-vscode.cpptools-1.17.5_linux-x64.vsix
