分享, 尝试多让浏览器执行JS脚本来简化执行

比如: 之前需要不断下拉来加载数据, 可靠性不是很高, 内存占用也很高, 成功了较低
改善: 使用js发送ajax请求, 然后将返回内容插入到浏览器中, 再用js移除, 这样不仅降低了内存占用, 而且加载速度快了很多, 成功率显著提高