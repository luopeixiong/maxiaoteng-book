# Brotli

1. demo

    ```python
    import brotli
    if r.headers['Content-Encoding'] == 'br':
        res_text = brotli.decompress(r.content)
    else:
        res_text = r.text()
    ```
