# Templates 模板

## 1. 使用django模板
1. 位置，项目根目录下`/templates`
   1. 每个应用存放在单独的文件夹中
   2. 默认查找每个app的`/polls/templates/polls/index.html`
2. `/project/settings.py`中生效
    ```
    ...
    TEMPLATES = [
        {
            ...
            'DIRS': [os.path.join(BASE_DIR, 'templates'),],       # 修改位置
            ...
        },
    ]
    ```
3. 使用render渲染
    ```python
    # 见views
    from django.shortcuts import render
    render(request, 'polls/index.html', context=context)
    # loader
    from django.template import loader
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    template = loader.get_template('polls/index.html')
    context = {
        'latest_question_list': latest_question_list,
    }
    return HttpResponse(template.render(context, request))
    # 404
    try:
        question = Question.objects.get(pk=question_id)
    except Question.DoesNotExist:
        raise Http404("Question does not exist")
    return render(request, 'polls/detail.html', {'question': question})
    # get-object-or-404
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'polls/detail.html', {'question': question})
    ```

4. 静态文件[static_files.md](static_files.md)
5. django 命名空间
    1. templace中的url避免硬编码
        ```python
        <a href="/polls/{{ question.id }}/">{{ question.question_text }}</a>
        # 等价
        <a href="{% url 'detail' question.id %}">{{ question.question_text }}</a>
        # urls中的内容, name='detail' 关联detail
        '''
        path('<int:question_id>/', views.detail, name='detail'),
        '''
        # 如果需要修改views.detail这个视图的url, 不需要批量修改templates中的内容, 只需要修改path即可
        ```
    2. 一个项目可能有多个app, 也许每个app都会有detail path, 那么views如何区分不同的url
            ```python
            # polls/urls.py
            app_name = 'polls'
            # template
            '''
            <a href="{% url 'polls.detail' question.id %}"><a/>
            '''
            ```
6. Use generic views
    1. 抽象listView和detailView
    ```python
    from django.views import generic
    # template_name 默认 <app name>/<model name>_list.html
    # context_object_name 默认 <model name>_list
    class IndexView(generic.ListView):
        template_name = 'polls/index.html'
        context_object_name = 'latest_question_list'
        def get_queryset(self):
            """Return the last five published questions."""
            return Question.objects.order_by('-pub_date')[:5]
    # template_name 默认 <app name>/<model name>_detail.html
    # context_object_name 默认 <model name>
    class DetailView(generic.DetailView):
        model = Question
        template_name = 'polls/detail.html'
    ```
    