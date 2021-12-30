# 嵌套生成sidebar
import os
import json

print(__file__)
docs_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)))
print(docs_dir)


def get_markdown_name(file_path):
    with open(file_path, 'r') as f:
        for i in f.readlines():
            if i.startswith('#'):
                return i.strip().replace('# ', '').capitalize()
    print('请检查文件{}格式, 为了正确生成目录, 首行必须以#开头, markdown的标题'.format(file_path))


def for_catalog(file_dir):
    files = os.listdir(file_dir)
    sidebar_item = {}
    disable_fold = ['aspex', 'assets', 'back_up', 'others', 'interview', 'bar']
    for file in files:
        if file.startswith('.') or file.startswith('_') or file == 'node_modules' or file in disable_fold:
            continue
        else:
            file_path = os.path.join(file_dir, file)
            if os.path.isdir(file_path):
                group_name, sub_catalog = for_group_catalog(file_path)
                sidebar_item[group_name] = sub_catalog
    return sidebar_item


def for_group_catalog(group_dir):
    '''
    传入 ./crawler
    主分类 group crawler, 之后的都是sub_dir(crawler下的scrapy)
    '''
    files = os.listdir(group_dir)
    children = []
    rm_file_path = os.path.join(group_dir, 'README.md')
    if 'README.md' not in files:
        print('{}无README.md, 自动创建'.format(group_dir))
        with open(rm_file_path, 'w') as f:
            title = '# {}\n'.format(os.path.split(group_dir)[-1].upper())
            f.write(title)
    group_name = get_markdown_name(rm_file_path)
    # 记录目录迭代深度, 方便写目录, 默认0
    tab = 1
    for file in files:
        if file=='README.md':
            child_item = {
                'text': group_name,
                'link': rm_file_path,
                'tab': tab-1,
            }
            children.append(child_item)
        elif os.path.isdir(os.path.join(group_dir, file)):
            # 对目录迭代处理
            sub_dir = os.path.join(group_dir, file)
            sub_children = for_sub_catalog(sub_dir, tab+1)
            children.append(sub_children)
        elif file.endswith('.md'):
            title_name = get_markdown_name(os.path.join(group_dir, file))
            child_item = {'text': title_name, 'link': os.path.join(group_dir, file), 'tab': tab}
            children.append(child_item)
        else:
            print('异常文件: {}, {}'.format(group_dir, file))
    return group_name, children


def for_sub_catalog(sub_dir, tab):
    '''
    传入 ./crawler/scrapy
    '''
    files = os.listdir(sub_dir)
    fold_name = os.path.split(sub_dir)[-1]
    children = []
    rm_file_path = os.path.join(sub_dir, 'README.md')
    if 'README.md' not in files:
        print('{}无README.md, 自动创建'.format(sub_dir))
        with open(rm_file_path, 'w') as f:
            title = '# {}\n'.format(os.path.split(sub_dir)[-1].upper())
            f.write(title)
    sub_name = get_markdown_name(rm_file_path)
    for file in files:
        if file=='README.md':
            child_item = {
                'text': sub_name,
                'link': rm_file_path,
                'tab': tab-1,
            }
            children.append(child_item)
        elif os.path.isdir(os.path.join(sub_dir, file)):
            # 对目录迭代处理
            tmp_tab = tab+1
            print('tmp_tab', tmp_tab)
            sub_children = for_sub_catalog(os.path.join(sub_dir, file), tab=tmp_tab)
            children.append(sub_children)
        elif file.endswith('.md'):
            title_name = get_markdown_name(os.path.join(sub_dir, file))
            child_item = {'text': title_name, 'link': os.path.join(sub_dir, file), 'tab': tab}
            children.append(child_item)
        else:
            print('异常文件: {}, {}'.format(sub_dir, file))
    return {
        'fold_name': fold_name,
        'children': children,
    }


def children_to_sidebar(sidebar_item):
    # 更新到三级目录
    with open('_sidebar.md', 'w') as f:
        # f.write('# Sidebar\n')
        for group_name, group_v in sidebar_item.items():
            # f.write('\n## {}\n\n'.format(group_name))

            for file in group_v:
                # group也应该可以跳转, 也作为navbar item
                if 'README.md' in file.get('link', ''):
                    f.write('* [{}]({})\n'.format(file.get('text'), file.get('link').replace(docs_dir, '')))
                    break
            
            for file in group_v:
                # 文件夹
                if file.get('fold_name'):
                    sub_files = file.get('children')
                    for sub_file in sub_files:
                        if 'README.md' in sub_file.get('link', ''):
                            f.write('{}* [{}]({})\n'.format('  '*int(sub_file.get('tab', 0)), sub_file.get('text'), sub_file.get('link').replace(docs_dir, '')))
                            break
                    for sub_file in sub_files:
                        # 文件
                        if sub_file.get('link', '') and 'README.md' not in sub_file.get('link', ''):
                            f.write('{}* [{}]({})\n'.format('  '*int(sub_file.get('tab', 0)), sub_file.get('text'), sub_file.get('link').replace(docs_dir, '')))
                        
                        # 三级文件夹
                        elif sub_file.get('fold_name'):
                            sub_sub_files = sub_file.get('children')
                            for sub_sub_file in sub_sub_files:
                                if 'README.md' in sub_sub_file.get('link', ''):
                                    f.write('{}* [{}]({})\n'.format('  '*int(sub_sub_file.get('tab', 0)), sub_sub_file.get('text'), sub_sub_file.get('link').replace(docs_dir, '')))
                                    break
                            for sub_sub_file in sub_sub_files:
                                if sub_sub_file.get('link', '') and 'README.md' not in sub_sub_file.get('link', ''):
                                    f.write('{}* [{}]({})\n'.format('  '*int(sub_sub_file.get('tab', 0)), sub_sub_file.get('text'), sub_sub_file.get('link').replace(docs_dir, '')))
                                elif sub_sub_file.get('fold_name'):
                                    print('四级及更深目录不再展示, {}'.format(sub_sub_file))

                # 文件
                elif 'README.md' not in file['link']:
                    # 此处不再重复写文件夹对应的README
                    f.write('{}* [{}]({})\n'.format('  '*int(file.get('tab', 0)), file.get('text'), file.get('link').replace(docs_dir, '')))


def children_to_navbar(sidebar_item):
    # 只更新到二级分类
    with open('_navbar.md', 'w') as f:
        # f.write('# Navbar\n\n')
        for group_name, group_v in sidebar_item.items():
            for file in group_v:
                # group也应该可以跳转, 也作为navbar item
                if 'README.md' in file.get('link', ''):
                    f.write('* [{}]({})\n'.format(file.get('text'), file.get('link').replace(docs_dir, '')))
                    break


sidebar_item = for_catalog(docs_dir)

children_to_sidebar(sidebar_item)
# 一般手动补充
# children_to_navbar(sidebar_item)

# sub_dir = '/Users/maxiaoteng/xiaoteng_projects/maxiaoteng-book/crawler'
# sub_dir = '/Users/maxiaoteng/xiaoteng_projects/maxiaoteng-book/crawler/selenium'
# children = for_sub_catalog(sub_dir, tab=1)
# print(children)