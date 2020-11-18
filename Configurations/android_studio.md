1. gradle
    1. https://blog.csdn.net/pzgmissyou/article/details/108013485?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param
    2. gradle依赖下载太慢, 可以替换
        ```
        gradle->wrapper->gradle-wrapper.properties

        distributionBase=GRADLE_USER_HOME
        distributionPath=wrapper/dists
        zipStoreBase=GRADLE_USER_HOME
        zipStorePath=wrapper/dists
        distributionUrl=https\://services.gradle.org/distributions/gradle-4.10.1-all.zip
        # 改为
        distributionUrl=file\:///origin_dir/gradle-4.10.1-all.zip  
        ```