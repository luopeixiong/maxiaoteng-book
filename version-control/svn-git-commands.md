# svn - git 基本操作

## 1. 功能

1. **初始化仓库**
    ```
    git init
    ```

2. **检出代码到本地**
    ```
    # git
    git clone git_url

    # svn
    svn checkout svn_url
    ```

3. **将文件添加到版本库**
    ```
    # git
    git add .  # 添加所有内容到版本库
    git add file_name  # 添加指定文件到版本库

    # svn
    svn add new_file
    ```

4. **提交更改**
    ```
    # git
    git commit -m '更改说明'  # 提交更改到本地版本库
    git push  # 推送代码到默认线上仓库
    git push gitlab master  # 推送代码到指定的线上仓库

    git push -u github master  # 将会修改设置默认的推送流

    # svn
    svn commit -m '更改说明'  # 提交更改到版本库, 并推送到线上
    ```

5. **重置暂存区**
    ```
    git reset --hard
    ```

6. **显示提交记录**
    ```
    git log  # 显示commit记录
    git log --graph --oneline firstbranch_name secondbranch_name  # 按图形显示
    git log -1 -- [file path]   # 查看指定文件的记录, 即时删除了也支持
    ```

7. **检出某一版本**
    ```
    git checkout commit_id  # 检出某一id的状态
    git checkout branch_name  # 检出指定分支的代码
    ```

8. **更新本地代码**
    ```
    # git
    git pull
    git pull remote_name branch_name 
    # svn
    svn update
    svn update -r m svn_path  # 更新指定版本的代码
    ```

9. **查看当前状态**
    ```
    # git
    git status
    # svn
    svn status
    ```

10. **查看代码库的信息**
    ```
    # git
    git remote -v  # 显示远程仓库的链接
    # svn
    svn info  # 显示仓库所有信息
    svn info |grep URL/http  
    cat .svn/entries |grep http  
    ```

11. **比较工作区和代码库的差异**
    ```
    # git
    git diff  # 比较工作区和暂存区的差异
    git diff commit_1 commit_2  # 比较两次提交的差异
    git diff --staged  # 比较暂存区和代码库的差异
    # svn
    svn diff
    ```

12. **remote 管理**
    ```
    # 1. 查看remote
    git remote -v
    # 2. 增加新的remote** 
    git remote add gitlab git_url
    git push gitlab master
    # 3. 修改remote的url**
    git remote set-url gitlab git_url
    ```

13. **rm 撤销已加入追踪的文件**
    ```
    # 删除本地和仓库
    git rm file_name
    git rm -r directory/
    # 只删除仓库, 保留本地文件
    git rm --cached file_name
    # svn
    svn rm --keep-local my_important_file  # 将只删除版本库的文件，而不删除本地
    ```


## 2. 撤销修改
1.  首先了解一下,git有三个概念\(工作区, 暂存区 和 仓库区\)
2. 通常有几种情况:
    1. 撤销工作区的修改, 还没有add到版本库
        ```
        # git
        git checkout .  # 撤销全部更改
        git checkout XX.file  # 撤销特定文件
        # svn
        svn revert -r path_name  # 丢弃未提交的代码 
        svn revert file_name
        ```
    2. 撤销暂存区的修改, add到了暂存区,还没有commit
        ```
        git reset --hard
        git reset HEAD //撤销add的所有更改
        git reset HEAD XX.file //撤销XX.file的添加
        ```
    3. 撤销版本库里面的修改
        ```
        git revert HEAD //撤销之前的commit
        git revert HEAD^ //撤销前前一次的commit
        git revert commit-id //撤销指定版本, 也会作为一次提交commit
        ```
        **注意: git revert是恢复指定版本的修改, 作为一次新提交上传,版本会递增**


## 3. 配置git
1. **git config --list 查看配置**

2. **全局修改，建议将最常用的账号配置到globle中**
    ```
    git config --global user.name xxx
    git config --global user.email xxx@xxx.xxx
    ```

3. **当前项目**
    ```
    git config user.name xxx
    git config user.email xxx@xxx.xxx
    ```

## 4. 解决每次git pull/push都要输入密码的问题

    `git config --global credential.helper store`

    **基本每次都要配置如下:**

    ```
    git config --global user.name maxiaoteng
    git config --global user.email maxiaoteng@yunfutech.com
    git config --global credential.helper store
    ```

## 5. 远程代码库回滚
1. 本地代码库回滚
    ```
    git reset --hard commit-id :回滚到commit-id，讲commit-id之后提交的commit都去除
    git reset --hard HEAD~3：将最近3次的提交回滚
    ```

2. 远程代码库回滚
    ```
    git checkout the_branch
    git pull
    git branch the_branch_backup //备份一下这个分支当前的情况
    git reset --hard the_commit_id //把the_branch本地回滚到the_commit_id
    git push origin :the_branch //删除远程 the_branch
    git push origin the_branch //用回滚后的本地分支重新建立远程分支
    git push origin :the_branch_backup
    ```

## 6. 分支操作

1. 新建分支
    ```
        git checkout -b iss53
        
        # 将会新建一个空白分支, 所有文件处于待提交状态
        git checkout --orphan iss53

        # 相当于
        git branch iss53
        git checkout iss53
    ```

2. 切换分支
    ```
        git checkout master
        # 注意切换分支的时候最好保持一个清洁的工作区域
    ```

3. 合并到master
    ```
        git checkout master
        git merge hotfix

        # 如果master修改了影响开发分支的内容，可以
        git merge master
    ```

4. 删除分支
    ```
        git branch -d hotfix
        # 合并之后，旧的分支不再有用，可以删除
        
        git branch -D hotfix
        # 未合并过的分支如果删除会提醒，用D强制删除
    ```

5. 冲突解决
    ```
        # 冲突的文件会保留在工作区，修改后使用git add
        # 一旦暂存，表示冲突解决，然后git status，git commit 来提交即可
    ```

6. 查看当前分支
    ```
        git branch
        git branch -v   # 查看各分支当前的最新版本
        git branch --merged # 查看合并到当前分支的其他分支
        git branch --no-merged # 查看未合并的分支
    ```

## 7. clone 指定分支
1. clone指定分支
    ```
        # 默认clone master
        git clone XXX.git
        # 制定
        git clone -b branch-name XXX.git
    ```

2. 如果clone了master，其他分支隐藏
    ```
        # 查看
        git branch -a

        # 快速检出分支
        # detached Head， 所做修改不会提交到任何分支
        git checkout origin/feature 

        # 快速创建一个本地分支
        git checkout -b feature origin/feature
        git checkout -t origin/feature  #会在本地创建一个和远程分支同名
    ```