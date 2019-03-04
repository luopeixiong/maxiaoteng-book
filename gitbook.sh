cd /home/ec2-user/gitbook/maxiaoteng-book
git checkout master
# git add .
# git commit -m $1
# git push -u origin master
# 脚本在服务器端,用于拉取后发布书
git pull

# 此处需要延迟1分钟来等待git build的执行

git checkout pages
cp -r _book/* .
git add .
git commit -m $1
git push -u origin pages
git checkout master
