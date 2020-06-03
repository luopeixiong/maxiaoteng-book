1. https://ecs-buy-me-east-1.aliyun.com/api/v2/region/describeRegions.json?saleStrategy=PrePaid&$$namespace=ecs-buy
   1. 展示支持的地区
   2. {localName: "华北 1 (青岛)", regionId: "cn-qingdao", status: "available"}
2. https://ecs-buy-me-east-1.aliyun.com/api/v2/instance/instanceType/describeInstanceTypes.json?$$namespace=ecs-buy
   1. 展示所有实例的详情
   2. instance_type， instance_type_family
3. https://ecs-buy-me-east-1.aliyun.com/api/quota/getCommonQuota.json?$$namespace=ecs-buy
   1. 每个实例支持的普通配额
4. https://ecs-buy-me-east-1.aliyun.com/api/v2/region/describeAvailableZones.json?saleStrategy=PrePaid&regionId=me-east-1&$$namespace=ecs-buy
   1. 获取可用地区
5. https://ecs-buy-me-east-1.aliyun.com/api/v2/instance/instanceType/describeAvailableInstanceTypes.json?saleStrategy=PrePaid&regionId=me-east-1&zoneId=me-east-1a&$$namespace=ecs-buy
   1. 获取当前地区可获取到的实例
6. https://g.alicdn.com/aliyun/buy-ecs3/0.17.12/ecs/main.bundle.js
   1. cpu类型和实例对应
7. https://g.alicdn.com/aliyun/ecs-price-info/2.0.28/price/js_price/filter_regions_price/cn_qingdao.js
   1. 按地区的价格
   2. "ecs.n1.small", 1, 2, ["0.251", "40.04", "143.0", "1458.6", "2917.2", "4375.8", "5834.4", "7293.0"],["0.251", "40.04", "143.0", "1716.0", "3432.0", "5148.0", "6864.0", "8580.0"]
   3. 实例id, cpu核心，内存(Gb), 打折后[] , [小时，周，月，1年，2年，3年，4年，5年]


## 2. 腾讯云
1. regions，zones
   1. https://iaas.cloud.tencent.com/cgi/area?action=queryRegion