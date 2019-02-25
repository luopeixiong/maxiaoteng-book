# Scrapyd

## 安装
```
sudo python36 -m pip install scrapyd
```

## 启动服务
```
scrapyd
```
浏览器访问： http://localhost.6800 可以查看scrapyd的web页面，但是页面主要


## API说明

## API说明
以下是postman导出的一个collection，可以重命名为：`scrapyd.postman_collection.json` 导入到postman查看
```
{
    "info": {
        "_postman_id": "ff84db97-b2bd-40af-9b4e-273f48f6dc4e",
        "name": "scrapyd",
        "description": "scrapyd api练习",
        "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
    },
    "item": [
        {
            "name": "daemonstatus",
            "request": {
                "method": "GET",
                "header": [],
                "body": {
                    "mode": "raw",
                    "raw": ""
                },
                "url": {
                    "raw": "http://localhost.6800/daemonstatus.json",
                    "protocol": "http",
                    "host": [
                        "scrapyd",
                        "maxiaoteng",
                        "xyz"
                    ],
                    "path": [
                        "daemonstatus.json"
                    ]
                },
                "description": "查看状态"
            },
            "response": []
        },
        {
            "name": "addversion",
            "request": {
                "method": "POST",
                "header": [],
                "body": {
                    "mode": "file",
                    "file": {}
                },
                "url": {
                    "raw": "http://localhost.6800/addversion.json?project=dianping&version=v01",
                    "protocol": "http",
                    "host": [
                        "scrapyd",
                        "maxiaoteng",
                        "xyz"
                    ],
                    "path": [
                        "addversion.json"
                    ],
                    "query": [
                        {
                            "key": "project",
                            "value": "dianping"
                        },
                        {
                            "key": "version",
                            "value": "v01"
                        }
                    ]
                },
                "description": "为项目增加版本"
            },
            "response": []
        },
        {
            "name": "schedule",
            "request": {
                "method": "POST",
                "header": [],
                "body": {
                    "mode": "raw",
                    "raw": ""
                },
                "url": {
                    "raw": "http://localhost.6800/schedule.json?project=dianping&spider=region",
                    "protocol": "http",
                    "host": [
                        "scrapyd",
                        "maxiaoteng",
                        "xyz"
                    ],
                    "path": [
                        "schedule.json"
                    ],
                    "query": [
                        {
                            "key": "project",
                            "value": "dianping"
                        },
                        {
                            "key": "spider",
                            "value": "region"
                        }
                    ]
                },
                "description": "启动爬虫"
            },
            "response": []
        },
        {
            "name": "cancel",
            "request": {
                "method": "POST",
                "header": [],
                "body": {
                    "mode": "raw",
                    "raw": ""
                },
                "url": {
                    "raw": "http://localhost.6800/cancel.json?project=dianping&job=ae07a0a011b711e9bb7c06c0685ba786",
                    "protocol": "http",
                    "host": [
                        "scrapyd",
                        "maxiaoteng",
                        "xyz"
                    ],
                    "path": [
                        "cancel.json"
                    ],
                    "query": [
                        {
                            "key": "project",
                            "value": "dianping"
                        },
                        {
                            "key": "job",
                            "value": "ae07a0a011b711e9bb7c06c0685ba786",
                            "description": "job_id"
                        }
                    ]
                },
                "description": "取消爬虫"
            },
            "response": []
        },
        {
            "name": "listprojects",
            "request": {
                "method": "GET",
                "header": [],
                "body": {
                    "mode": "raw",
                    "raw": ""
                },
                "url": {
                    "raw": "http://localhost.6800/listprojects.json",
                    "protocol": "http",
                    "host": [
                        "scrapyd",
                        "maxiaoteng",
                        "xyz"
                    ],
                    "path": [
                        "listprojects.json"
                    ]
                },
                "description": "列出所有的爬虫项目"
            },
            "response": []
        },
        {
            "name": "listverisons",
            "request": {
                "method": "GET",
                "header": [],
                "body": {
                    "mode": "raw",
                    "raw": ""
                },
                "url": {
                    "raw": "http://localhost.6800/listversions.json?project=dianping",
                    "protocol": "http",
                    "host": [
                        "scrapyd",
                        "maxiaoteng",
                        "xyz"
                    ],
                    "path": [
                        "listversions.json"
                    ],
                    "query": [
                        {
                            "key": "project",
                            "value": "dianping",
                            "description": "指定项目,返回版本列表"
                        }
                    ]
                },
                "description": "列出指定项目的版本"
            },
            "response": []
        },
        {
            "name": "listspiders",
            "request": {
                "method": "GET",
                "header": [],
                "body": {
                    "mode": "raw",
                    "raw": ""
                },
                "url": {
                    "raw": "http://localhost.6800/listspiders.json?project=dianping",
                    "protocol": "http",
                    "host": [
                        "scrapyd",
                        "maxiaoteng",
                        "xyz"
                    ],
                    "path": [
                        "listspiders.json"
                    ],
                    "query": [
                        {
                            "key": "project",
                            "value": "dianping"
                        }
                    ]
                },
                "description": "列出项目的所有爬虫项目"
            },
            "response": []
        },
        {
            "name": "listjobs",
            "request": {
                "method": "GET",
                "header": [],
                "body": {
                    "mode": "raw",
                    "raw": ""
                },
                "url": {
                    "raw": "http://localhost.6800/listjobs.json?project=dianping",
                    "protocol": "http",
                    "host": [
                        "scrapyd",
                        "maxiaoteng",
                        "xyz"
                    ],
                    "path": [
                        "listjobs.json"
                    ],
                    "query": [
                        {
                            "key": "project",
                            "value": "dianping"
                        }
                    ]
                },
                "description": "列出项目目前正在运行的任务"
            },
            "response": []
        },
        {
            "name": "delversion",
            "request": {
                "method": "POST",
                "header": [],
                "body": {
                    "mode": "raw",
                    "raw": ""
                },
                "url": {
                    "raw": "http://localhost.6800/delversion.json?project=dianping&version=1546759284",
                    "protocol": "http",
                    "host": [
                        "scrapyd",
                        "maxiaoteng",
                        "xyz"
                    ],
                    "path": [
                        "delversion.json"
                    ],
                    "query": [
                        {
                            "key": "project",
                            "value": "dianping"
                        },
                        {
                            "key": "version",
                            "value": "1546759284"
                        }
                    ]
                },
                "description": "列出项目目前正在运行的任务"
            },
            "response": []
        },
        {
            "name": "delproject",
            "request": {
                "method": "POST",
                "header": [],
                "body": {
                    "mode": "raw",
                    "raw": ""
                },
                "url": {
                    "raw": "http://localhost.6800/delproject.json?project=dianping",
                    "protocol": "http",
                    "host": [
                        "scrapyd",
                        "maxiaoteng",
                        "xyz"
                    ],
                    "path": [
                        "delproject.json"
                    ],
                    "query": [
                        {
                            "key": "project",
                            "value": "dianping"
                        }
                    ]
                },
                "description": "删除指定的项目"
            },
            "response": []
        }
    ]
}
```
