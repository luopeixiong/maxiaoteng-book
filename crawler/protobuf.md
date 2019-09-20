# Protobuf 

## 1. 介绍
Protobuf（Protocol Buffers），是 Google 开发的一种跨语言、跨平台的可扩展机制，用于序列化结构化数据。  
与 XML 和 JSON 格式相比，protobuf 更小、更快、更便捷。protobuf 目前支持 C++、Java、Python、Objective-C，如果使用 proto3，还支持 C#、Ruby、Go、PHP、JavaScript 等语言。
- 官网地址：https://developers.google.cn/protocol-buffers/
- GitHub 地址：https://github.com/protocolbuffers/protobuf

    来自merciari美国app中的接口

1. 优点：
   1. 性能好, 序列化和反序列化快, 占用空间小
   2. 跨语言
2. 缺点：
   1. 二进制格式可读性差：为了提高性能，protobuf 采用了二进制格式进行编码，这直接导致了可读性差。
   2. 缺乏自描述: XML 是自描述的，而 protobuf 不是，不配合定义的结构体是看不出来什么作用的。

## 2. 使用

1. 