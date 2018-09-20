# Ajax
Asynchronous JavaScript + XML

## HTTP瓶颈

1. 表单提交  
一次操作渲染整个页面
有些操作将会增加带宽(点赞)  
有的操作会影响使用当前使用(视频网站的收藏\点赞等)

2. 内容的实时更新  
通知/私信等提醒

## Ajax的实现

**只做局部更新**

一个demo

### ajax函数 
```
var log = function() {
    console.log.apply(console, arguments)
}

var e = function(sel) {
    return document.querySelector(sel)
}

/* 
 ajax 函数
*/
var ajax = function(method, path, data, responseCallback) {
    var r = new XMLHttpRequest()
    // 设置请求方法和请求地址
    r.open(method, path, true)
    // 设置发送的数据的格式为 application/json
    // 这个不是必须的
    r.setRequestHeader('Content-Type', 'application/json')
    // 注册响应函数
    r.onreadystatechange = function() {
        if(r.readyState === 4) {
            // r.response 存的就是服务器发过来的放在 HTTP BODY 中的数据
            responseCallback(r.response)
        }
    }
    // 把数据转换为 json 格式字符串
    data = JSON.stringify(data)
    // 发送请求
    r.send(data)
}

// TODO API
// 获取所有 todo
var apiTodoAll = function(callback) {
    var path = '/api/todo/all'
    ajax('GET', path, '', callback)
}

// 增加一个 todo
var apiTodoAdd = function(form, callback) {
    var path = '/api/todo/add'
    ajax('POST', path, form, callback)
}

// 删除一个 todo
var apiTodoDelete = function(id, callback) {
    var path = '/api/todo/delete?id=' + id
    ajax('GET', path, '', callback)
    //    get(path, callback)
}

// 更新一个 todo
var apiTodoUpdate = function(form, callback) {
    var path = '/api/todo/update'
    ajax('POST', path, form, callback)
    //    post(path, form, callback)
}

// load weibo all
var apiWeiboAll = function(callback) {
    var path = '/weibo/all'
    ajax('GET', path, '', callback)
}

// 增加一个 微博
var apiWeiboAdd = function(form, callback) {
    var path = '/weibo/add'
    ajax('POST', path, form, callback)
}

// 删除一个微博
var apiWeiboDelete = function(weibo_id, callback) {
    var path = '/weibo/delete?id='+weibo_id
    ajax('GET', path, '', callback)
}

// 更新一个微博
var apiWeiboUpdate = function(form, callback) {
   var path = '/weibo/update'
   ajax('POST', path, form, callback)
}

// 增加一条微博评论
var apiCommentAdd = function(form, callback){
    var path = '/weibo/commentAdd'
    ajax('POST', path, form, callback)
}

// 删除一条微博评论
var apiCommentDelete = function(comment_id, callback){
    var path = '/weibo/commentDelete?id='+comment_id
    ajax('GET', path, '', callback)
}
```

### 具体操作dom
```
var timeString = function(timestamp) {
    t = new Date(timestamp * 1000)
    t = t.toLocaleString('ja-JP')
    return t
}

var commentsTemplate = function(comments) {
    var html = ''
    for(var i = 0; i < comments.length; i++) {
        var c = comments[i]
        var t = `
            <div class='comment-form' id='comment-id-${c.id}' data-id=${c.id}>
                <br>
                [${c.username}]:${c.content}
                <br>
                <span>[创建时间]: ${timeString(c.ct)}</span>
                <button class='comment-delete'>删除评论</button>
            </div>
        `
        html += t
    }
    return html
}

var WeiboTemplate = function(Weibo) {
    var content = Weibo.content
    var id = Weibo.id
    var ct = Weibo.ct
    var visitor = Weibo.visitor
    var comments = commentsTemplate(Weibo.comments)
    var t = `
        <div class='Weibo-cell' id='Weibo-${id}' data-id=${id}>
            <div class='Weibo-single'>
                [${visitor}]: <span class='Weibo-content'>${content}</span>
                <br>
                <span>[留言时间]: ${timeString(ct)}</span>
                <br><br>
            </div>
            <button class="Weibo-delete">删除留言</button>
            <button class="Weibo-edit">编辑留言</button>
            <div class="comment-list">
                现有评论: ${comments}
            </div>
            <div class="comment-form">
                <input type="hidden" name="weibo_id" value="">
                <br>
                评论内容:<input class='comment-content'name="content">
                <br><br>
                评论人(默认匿名):<input class='comment-username' name='username'>
                <br><br>
                <button class="comment-add">添加评论</button>
            </div>
            <p>============================================================</p>
        </div>
    `
    return t
}

var insertWeibo = function(Weibo) {
    var WeiboCell = WeiboTemplate(Weibo)
    // log('单个微博html标签', WeiboCell)
    // 插入 Weibo-list
    var WeiboList = e('.Weibo-list')
    WeiboList.insertAdjacentHTML('beforeend', WeiboCell)
}

var insertEditForm = function(cell, content) {
    var form = `
        <div class='Weibo-edit-form'>
            <input class="Weibo-edit-input">
            // <button class='Weibo-update'>更新</button>
        </div>
    `
    cell.insertAdjacentHTML('afterBegin', form)
    var input = e('.Weibo-edit-input')
    input.value = content
}

var loadWeibos = function() {
        // 调用 ajax api 来载入数据
    apiWeiboAll(function(r) {
        // console.log('load all', r)
        // 解析为 数组
        var Weibos = JSON.parse(r)
        // 循环添加到页面中
        for(var i = 0; i < Weibos.length; i++) {
            var Weibo = Weibos[i]
            insertWeibo(Weibo)
        }
    })
}

var bindEventWeiboAdd = function() {
    var b = e('#id-button-add-weibo')
    // 注意, 第二个参数可以直接给出定义函数
    b.addEventListener('click', function(){
        var input1 = e('#id-input-weibo')
        var content = input1.value
        var input2 = e('#id-visitor-weibo')
        var visitor = input2.value
        log('click add', content, visitor)
        var form = {
            'content': content,
            'visitor': visitor,
        }
        input1.value = ''
        input2.value = ''
        if(content.length>2){
            apiWeiboAdd(form, function(r) {
                // 收到返回的数据, 插入到页面中
                var Weibo = JSON.parse(r)
                insertWeibo(Weibo)
            })
        }
        else{
            alert("留言内容太少了吧!")
        }
    })
}

var bindEventWeiboDelete = function() {
    var WeiboList = e('.Weibo-list')
    // 注意, 第二个参数可以直接给出定义函数
    WeiboList.addEventListener('click', function(event){
        var self = event.target
        if(self.classList.contains('Weibo-delete')){
            // 删除这个 Weibo
            var WeiboCell = self.parentElement
            var Weibo_id = WeiboCell.dataset.id
            log('点击到了删除按钮, 微博id是:', Weibo_id)
            apiWeiboDelete(Weibo_id, function(r){
                log('删除成功', Weibo_id)
                var return_wb = JSON.parse(r)
                if(return_wb.id==Weibo_id){
                    WeiboCell.remove()
                }
            })
        }
    })
}

var bindEventWeiboEdit = function() {
    var WeiboList = e('.Weibo-list')
    // 注意, 第二个参数可以直接给出定义函数
    WeiboList.addEventListener('click', function(event){
        var self = event.target
        if(self.classList.contains('Weibo-edit')){
            // 删除这个 Weibo
            var WeiboCell = self.parentElement
            // 从微博cell中选出展示微博内容的那部分,缩小了查找范围
            var weibo_content = WeiboCell.querySelector('.Weibo-content')
            var content = weibo_content.innerHTML
            // 将原来的展示内容改为修改框
            weibo_content.parentElement.style.display="none"
            // 插入更新框
            insertEditForm(WeiboCell, content)
        }
    })
}

var bindEventWeiboUpdate = function() {
    var WeiboList = e('.Weibo-list')
    // 注意, 第二个参数可以直接给出定义函数
    WeiboList.addEventListener('click', function(event){
        var self = event.target
        if(self.classList.contains('Weibo-update')){
            log('点击了 update ')
            //
            var editForm = self.parentElement
            // querySelector 是 DOM 元素的方法
            // document.querySelector 中的 document 是所有元素的祖先元素
            var input = editForm.querySelector('.Weibo-edit-input')
            var content = input.value
            // 用 closest 方法可以找到最近的直系父节点
            var WeiboCell = self.closest('.Weibo-cell')
            var Weibo_id = WeiboCell.dataset.id
            var form = {
                'id': Weibo_id,
                'content': content,
            }
            apiWeiboUpdate(form, function(r){
                log('更新成功', Weibo_id)
                var Weibo = JSON.parse(r)
                log(Weibo)
                var selector = '#Weibo-' + Weibo.id
                var WeiboCell = e(selector)
                var contentSpan = WeiboCell.querySelector('.Weibo-content')
                contentSpan.innerHTML = Weibo.content
                // 显示微博内容框
                contentSpan.parentElement.style.display=""
                // 将编辑框删除
                var edit_form = WeiboCell.querySelector(".Weibo-edit-form")
                edit_form.remove()
                //  WeiboCell.remove()
            })
        }
    })
}


// 插入评论函数
var insertCommentCell = function(comment){
    var comments = [comment]
    var commentCell = commentsTemplate(comments)
    var weibo_id = comment.weibo_id
    var weiboCell = e('#Weibo-' + weibo_id)
    // log('weiboCell:', weiboCell)
    var commentsList = weiboCell.querySelector('.comment-list')
    commentsList.insertAdjacentHTML('beforeend', commentCell)
}


// 绑定添加评论事件
var bindEventCommentAdd = function(){
    var WeiboList = e('.Weibo-list')
    WeiboList.addEventListener('click', function(event){
        var self = event.target
        if(self.classList.contains("comment-add")){
            // log('点击到了评论按钮', self)
            var comment_form = self.parentElement
            var input1 = comment_form.querySelector('.comment-content')
            var comment_content = input1.value
            var input2 = comment_form.querySelector('.comment-username')
            var comment_username= input2.value
            var WeiboCell = comment_form.parentElement
            var Weibo_id = WeiboCell.dataset.id
            // log('当前微博的id', Weibo_id)
            var form = {
              'weibo_id': Weibo_id,
              'content': comment_content,
              'username': comment_username,
            }
            input1.value = ''
            input2.value = ''
            if(comment_content.length>0){
                apiCommentAdd(form, function(r){
                    // 收到响应, 先log出来
                    var new_comment = JSON.parse(r)
                    // log('评论已添加', new_comment)
                    insertCommentCell(new_comment)
                })
            }else{
                alert('评论内容不可为空')
            }
        }
    })
}


// 绑定删除评论事件
var bindEventCommentDelete = function(){
    var WeiboList = e('.Weibo-list')
    WeiboList.addEventListener('click', function(event){
        var self = event.target
        if(self.classList.contains("comment-delete")){
            log('点击到了删除评论按钮', self)
            var comment_form = self.parentElement
            comment_id = comment_form.dataset.id
            log('报告,当前要删除的评论id', comment_id)
            apiCommentDelete(comment_id, function(r){
                var delete_comment = JSON.parse(r)
                comment_form = e('#comment-id-'+comment_id)
                // log('报告,我要移除的评论标签:', comment_form)
                comment_form.remove()
            })
        }
    })
}


var bindEvents = function() {
    bindEventWeiboAdd()
    bindEventWeiboDelete()
//    bindEventWeiboEdit()
//    bindEventWeiboUpdate()
    bindEventCommentAdd()
//    bindEventCommentDelete()
}


var __main = function() {
    bindEvents()
    loadWeibos()
}

__main()

```

