#!/bin/bash

# pip install git-filter-repo

git log --all -- .vscode/ext01_ms-vscode.cpptools-1.17.5_linux-x64.vsix

git filter-repo --path .vscode/ext01_ms-vscode.cpptools-1.17.5_linux-x64.vsix --invert-paths --force

git for-each-ref --format="delete %(refname)" refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now


git remote add origin https://cnb.cool/8888/c/apue.git

git push origin --force --all
git push origin --force --tags


git push gitcode --force --all
git push gitcode --force --tags

git push github --force --all
git push github --force --tags


# 获取所有远程仓库的名称
remotes=$(git remote)

# 遍历所有远程仓库并执行推送操作
for remote in $remotes; do
    echo "推动到ing $remote... 进行中"
    git push "$remote" --force --all  # 推送所有分支,如果你只想推送当前分支,可以用 HEAD:master(或其他分支名)
    git push "$remote" --force --tags # 推送所有标签(可选)
done

echo "已经想远端所有的目标进行了推送"

git log --all -- .vscode/ext01_ms-vscode.cpptools-1.17.5_linux-x64.vsix
