# 安装

1. debian ubuntu安装
    ```
    sudo apt update
    echo '安装解压缩软件'
    apt-get install aptitude -y
    aptitude install bzip2 tar xz-utils gcc -y
    echo '安装依赖'
    sudo aptitude install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev -y
    curl -O https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tar.xz
    tar -xf Python-3.8.2.tar.xz
    cd Python-3.8.2 && ./configure --enable-optimizations
    make -j 4
    sudo make altinstall
    echo 'install success'
    ```
2. centos