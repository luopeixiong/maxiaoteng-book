# Git

## 0. 注意: 在进行任何commit之前,要pull,确认和云端没有冲突

## 1. 为本地仓库与云端仓库连接

    `git remote add origin git-ssl-url`

    `// origin表示指定任意名, 以区分不同的云端仓库`

## 2. 撤销已加入追踪的文件

	1. `git rm  XX.file  -r`

	2. 将XX.file添加到 .gitignore

	3. git commit/ git push

## 3. 撤销修改

	3.1 首先了解一下,git有三个概念\(工作区, 暂存区 和 仓库区\)

	3.2 通常有几种:

	- 撤销工作区的修改, 还没有add到版本库

		\``git checkout XX.file`

	- 撤销暂存区的修改, add到了暂存区,还没有commit

		`git reset HEAD           //撤销add的所有更改`

		`git reset HEAD  XX.file        //撤销XX.file的添加`

	- 撤销版本库里面的修改

		`git revert HEAD           //撤销之前的commit`

		`git revert HEAD^        //撤销前前一次的commit`

		`git revert commit-id    //撤销指定版本, 也会作为一次提交commit`

            **注意: git revert是恢复指定版本的修改, 作为一次新提交上传,版本会递增**

## 4. remote 管理

**1. 查看remote**

	git remote -v

**2. 增加新的remote**

	`git remote add gitlab git_url`

	`git push gitlab master`

**`3. 修改remote的url`**

	`git remote set-url gitlab git_url`

## 5. 验证修改后的ssh连接

	`ssh -T git_url`

## 6. git config --list 查看配置

全局修改，建议将最常用的账号配置到globle中

	git config --globle user.name xxx

	git config --globle user.email xxx@xxx.xxx

当前项目

	git config user.name xxx

	git config user.email xxx@xxx.xxx

\#\# 解决每次git pull/push都要输入密码的问题

	git config --global credential.helper store

	

	\`\`\`

	git config --global user.name maxiaoteng

	git config --global user.email maxiaoteng@yunfutech.com

	git config --global credential.helper store

	

\`\`\`

