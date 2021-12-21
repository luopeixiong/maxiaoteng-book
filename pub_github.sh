#!/usr/bin/env sh

# abort on errors
set -e

# 刷新目录
python3 docsify_sidebar.py

# if you are deploying to a custom domain
# echo 'notebook.maxiaoteng.xyz' > CNAME

# if you are deploying to https://<USERNAME>.github.io/<REPO>
git push 
cd -