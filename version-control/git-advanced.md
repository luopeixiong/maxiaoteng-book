# git 进阶

## git 与 hooks
git 在执行特定的重要动作时能触发自定义的脚本，包含客户端和服务端。 客户端钩子由诸如提交和合并这样的操作所调用， 服务器端的钩子作用于诸如接收被推送的提交这样的联网操作。 你可以随心所欲地运用这些钩子。  
hooks目录： .git/hooks  
可以执行shell脚本， 以及Perl，Python和Ruby等

## webhooks
在用户push了代码之后， 自动回调一个你设定的http地址. 这是一个通用的解决方案, 可以根据需求来编写自己的脚本(比如发邮件,自动部署等)

webhooks的请求方式是POST，body可以是JSON和formdata, 注意其中的密码是明文
```
{
    "before": "fb32ef5812dc132ece716a05c50c7531c6dc1b4d", 
    "after": "ac63b9ba95191a1bf79d60bc262851a66c12cda1", 
    "ref": "refs/heads/master", 
    "user_id": 13,
    "user_name": "123", 
    "user": {
      "name": "123",
      "username": "test123",
      "url": "https://gitee.com/oschina"
    }, 
    "repository": {
        "name": "webhook", 
        "url": "http://git.oschina.net/oschina/webhook", 
        "description": "", 
        "homepage": "https://gitee.com/oschina/webhook"
    }, 
    "commits": [
        {
            "id": "ac63b9ba95191a1bf79d60bc262851a66c12cda1", 
            "message": "1234 bug fix", 
            "timestamp": "2016-12-09T17:28:02 08:00", 
            "url": "https://gitee.com/oschina/webhook/commit/ac63b9ba95191a1bf79d60bc262851a66c12cda1", 
            "author": {
                "name": "123", 
                "email": "123@123.com", 
                "time": "2016-12-09T17:28:02 08:00"
            }
        }
    ], 
    "total_commits_count": 1, 
    "commits_more_than_ten": false, 
    "project": {
        "name": "webhook", 
        "path": "webhook", 
        "url": "https://gitee.com/oschina/webhook", 
        "git_ssh_url": "git@gitee.com:oschina/webhook.git", 
        "git_http_url": "https://gitee.com/oschina/webhook.git", 
        "git_svn_url": "svn://gitee.com/oschina/webhook", 
        "namespace": "oschina", 
        "name_with_namespace": "oschina/webhook", 
        "path_with_namespace": "oschina/webhook", 
        "default_branch": "master"
    }, 
    "hook_name": "push_hooks", 
    "password": "pwd"
}
```
