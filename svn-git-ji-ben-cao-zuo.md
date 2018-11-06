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

git push -u github master  # 将会修改设置默认的推送流

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


## 撤销修改

3.1 首先了解一下,git有三个概念\(工作区, 暂存区 和 仓库区\)

3.2 通常有几种:

- 撤销工作区的修改, 还没有add到版本库

```
git checkout .  # 撤销全部更改
git checkout XX.file  # 撤销特定文件

# svn
svn revert -r path_name  # 丢弃未提交的代码 
svn revert file_name
```
* 撤销暂存区的修改, add到了暂存区,还没有commit

```
git reset --hard
git reset HEAD //撤销add的所有更改
git reset HEAD XX.file //撤销XX.file的添加
```
* 撤销版本库里面的修改

```
git revert HEAD //撤销之前的commit
git revert HEAD^ //撤销前前一次的commit
git revert commit-id //撤销指定版本, 也会作为一次提交commit
```
**注意: git revert是恢复指定版本的修改, 作为一次新提交上传,版本会递增**


## 配置git

- **git config --list 查看配置**

- **全局修改，建议将最常用的账号配置到globle中**

```
git config --globle user.name xxx
git config --globle user.email xxx@xxx.xxx
```
- **当前项目**

```
git config user.name xxx
git config user.email xxx@xxx.xxx
```

## 解决每次git pull/push都要输入密码的问题

    git config --global credential.helper store

**基本每次都要配置如下:**

```
git config --global user.name maxiaoteng
git config --global user.email maxiaoteng@yunfutech.com
git config --global credential.helper store
```

## 远程代码库回滚
- 本地代码库回滚
```
git reset --hard commit-id :回滚到commit-id，讲commit-id之后提交的commit都去除
git reset --hard HEAD~3：将最近3次的提交回滚
```

- 远程代码库回滚
```
git checkout the_branch
git pull
git branch the_branch_backup //备份一下这个分支当前的情况
git reset --hard the_commit_id //把the_branch本地回滚到the_commit_id
git push origin :the_branch //删除远程 the_branch
git push origin the_branch //用回滚后的本地分支重新建立远程分支
git push origin :the_branch_backup
```