# Windows cmd

1. 基本命令行知识

    ```shell
    # type (linux cat)
    type run.log
    # findstr (linux grep)
    type run.log|findstr empty
    # find /c /v "" (linux wc -l)
    type run.log|findstr empty|find /c /v ""
    ```
