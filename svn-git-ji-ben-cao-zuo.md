# svn - git 基本操作

## 功能

- **初始化仓库**

```
git init
```

- **检出代码到本地**

```
# git
git clone git_url

# svn
svn checkout svn_url
```

- **将文件添加到版本库**

```
# git
git add .  # 添加所有内容到版本库
git add file_name  # 添加指定文件到版本库

# svn
svn add new_file
```

- **提交更改**

```
# git
git commit -m '更改说明'  # 提交更改到本地版本库
git push  # 推送代码到默认线上仓库
git push gitlab master  # 推送代码到指定的线上仓库

# svn
svn commit -m '更改说明'  # 提交更改到版本库, 并推送到线上
```

- **重置暂存区**

```
git reset --hard
```

- **显示提交记录**

```
git log  # 显示commit记录

git log --graph --oneline firstbranch_name secondbranch_name  # 按图形显示
```

- **检出某一版本**

```
git checkout commit_id  # 检出某一id的状态
git checkout branch_name  # 检出指定分支的代码
```

- **更新本地代码**

```
# git
git pull
git pull remote_name branch_name 

# svn
svn update
svn update -r m svn_path  # 更新指定版本的代码
```

- **查看当前状态**

```
# git
git status

# svn
svn status
```

- **比较工作区和代码库的差异**

```
# git
git diff  # 比较工作区和暂存区的差异
git diff commit_1 commit_2  # 比较两次提交的差异
git diff --staged  # 比较暂存区和代码库的差异

# svn
svn diff
```

- **remote 管理**

```
# 1. 查看remote
git remote -v

# 2. 增加新的remote** 
git remote add gitlab git_url
git push gitlab master

# 3. 修改remote的url**
git remote set-url gitlab git_url
```

- **rm 撤销已加入追踪的文件**

```
# 删除本地和仓库
git rm file_name
git rm -r directory/

# 只删除仓库, 保留本地文件
git rm --cached file_name

```
