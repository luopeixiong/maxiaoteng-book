## windows7 安装mysql

启动: 服务中找到mysql, 点击启动即可

- char  
- varchar
    >> char(n)和varchar(n)的n表示字符的个数, 不表示字节数, 
    >> char不管实际值都会占用n个空间, 而varchar占用实际字符+1<=n, 
    >> 超过n的上限就会被截断, char上限255字节, varchar上限65535字节,text上限65535
- text
    >> char存储时会截断尾部空格, varchar和text不会

    - varchar
        - > 255 tinytext
        - > 500 text
        - > 20000  mediumtext
- blob