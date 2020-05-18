# tesserocr OCR图片识别文字
[参考https://cuiqingcai.com/5189.html](https://cuiqingcai.com/5189.html)

1. install tesseract
    1. linux
        1. yum install -y tesseract
    2. macos
        1. brew install imagemagick 
        2. brew install tesseract
        3. brew install tesseract-lang
    3. 查看支持语言
        1. tesseract --list-langs
    4. 测试
        1. tesseract image.png result -l eng && cat result.txt
2. install tesserocr
    1. >pip3.6 install pillow  图片工具
    2. >CFLAGS='-stdlib=libc++  -mmacosx-version-min=10.7' pip3.6 install tesserocr
        1. [参考https://diverse.space/2018/10/%E5%9C%A8-Mojave-%E4%B8%8B%E7%BC%96%E8%AF%91-SpiderMonkey](https://diverse.space/2018/10/%E5%9C%A8-Mojave-%E4%B8%8B%E7%BC%96%E8%AF%91-SpiderMonkey) 
3. demo
    ```
        import tesserocr
        from PIL import Image
        image = Image.open('ocr_demo_eng.jpg')
        print(tesserocr.image_to_text(image))
    ```