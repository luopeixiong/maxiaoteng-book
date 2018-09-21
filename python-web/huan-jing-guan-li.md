
# 包管理和虚拟环境

- 包安装方法    
通过Python社区开发的pip, easy_install等工具   
使用系统本身自带的包管理器(yum, apt-get)      
通过源码安装     


## virtualenv安装  
虚拟环境的包是对真实环境包的一个复制  
virtualenv默认有python可执行文件, 常用标准库等.
```
sudo pip install virtualenv  # 安装virtualenv

# 创建一个project
mkdir project
cd project
virtualenv venv  # 启动一个虚拟环境, 默认复制系统所有的第三方包
virtualenv --no-site-packages venv  # 启动一个虚拟环境
,不包含任何第三方包
source venv/bin/activate  # 生效一个虚拟环境
(venv)>which python
> /home.../bin/python
(venv)>deactivate  # 退出虚拟环境
```

## pip 包管理
```
# 使用pip 管理包
pip install requests  # 安装包
pip list  # 列出所有的第三方包
pip freeze > requirement.txt  # 导出当前环境下的所有第三方包
pip install -r requirement.txt  # 根据配置文件生成相同的环境
```


## pipenv
是python项目的依赖管理器
- 根据pipfile自动寻找项目根目录
- 如果不存在,自动生成pipfile和pipfile.lock
- 自动在项目目录的.venv目录创建虚拟环境. 
- 自动管理pipfile新安装和删除的包
- 自动更新pip

使用pipenv代替pip安装包

## pipenv 和autoenv的组合

autoenv可以在切换文件目录的同时, 自动完成激活虚拟环境
**用法**
```
sudo pip install autoenv
source /usr/local/bin/activate.sh

mkdir test
cd test
touch .env
echo 'source /home/xx/venv/bin/activate' > .env
cd
cd test  # 就会自动激活虚拟环境

```



## 使用vim

## 学习Emacs

- 安装

- 两种模式
 - GUI模式
 ```
 emacs  # 默认启动GUI
 emacd -nw FILE  # 终端中启动
 ```
 - Daemon模式

- 学习lisp


## Pycharm安装和使用

## 使用IPython

## Web开发环境配置

