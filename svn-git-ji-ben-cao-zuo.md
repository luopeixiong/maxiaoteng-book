# svn - git 基本操作

## 功能

- 检出代码到本地

```
# git
git clone git_url

# svn
svn checkout svn_url
```

- 将文件添加到版本库

```
# git
git add .  # 添加所有内容到版本库
git add file_name  # 添加指定文件到版本库

# svn
svn add new_file
```

- 提交更改

```
# git
git commit -m '更改说明'  # 提交更改到本地版本库
git push  # 推送代码到默认线上仓库
git push gitlab master  # 推送代码到指定的线上仓库

# svn
svn commit -m '更改说明'  # 提交更改到版本库, 并推送到线上
```

- 更新本地代码

```
# git
git pull

# svn
svn update
svn update -r m svn_path  # 更新指定版本的代码
```

- 查看当前状态

```
# git
git status

# svn
svn status
```

- 比较工作区和代码库的差异

```
# git
git diff

# svn
svn diff
```

