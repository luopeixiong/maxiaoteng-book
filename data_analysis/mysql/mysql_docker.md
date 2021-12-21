# Mysql Docker

docker run 
```
-e MYSQL_ROOT_PASSWORD=my-secret-pw 
```
mysql command line client 
docker run -it --network some-network --rm mysql mysql -hsome-mysql -uexample-user -p
# 用于登陆非docker的mysql
docker run -it --rm mysql mysql -hsome.mysql.host -usome-mysql-user -p


# docker create -p 3306:3306 --name docker_mysql -v /root/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=xx mysql