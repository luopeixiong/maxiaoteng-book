# OCR 百度api调用
[TOC]

1. 文档 https://ai.baidu.com/ai-doc/OCR/fk3h7xu7h
2. 注册
    1. 控制台选择文字识别 --> 通用文字识别 --> 创建应用 --> 获取到api key 和secrec key
    2. 获取access token, 有效期一个月
        ```python
            # encoding:utf-8
            import requests 

            # client_id 为官网获取的AK， client_secret 为官网获取的SK
            host = 'https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=【官网获取的AK】&client_secret=【官网获取的SK】'
            response = requests.get(host)
            if response:
                print(response.json())
        ```
    3. 发请求
        ```
        def general_basic(pic_path):
            '''
            百度文字识别接口
            通用文字识别
            '''
            request_url = "https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic"
            # 二进制方式打开图片文件
            f = open(pic_path, 'rb')
            img = base64.b64encode(f.read())

            params = {"image":img}
            access_token = '------'
            request_url = request_url + "?access_token=" + access_token
            headers = {'content-type': 'application/x-www-form-urlencoded'}
            response = requests.post(request_url, data=params, headers=headers)
            print('百度api返回:{}'.format(response.json()))
            if response:
                words = response.json().get('words_result')
                if words == []:
                    return ''
                else:
                    return words[0].get('words')
        ```
    4. 费用: 
        1. 通用文字每天5w免费
        2. https://ai.baidu.com/ai-doc/OCR/fk3h7xu7h