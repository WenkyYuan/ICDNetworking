# ICDNetWorking
基于AFNetWorking3.0+的iOS应用网络层框架，使用Block方式向上层传递请求结果。

##版本
1.0.0版本：框架雏形，暂只支持POST和GET请求，支持URL缓存

##网络层结构
ICDServerAPIUtils --> ServerAPI层（继承自ICDBaseRequest）--> Service层
##结构说明
ICDServerAPIUtils为网络底层处理的工具类，使用AFNetWorking的AFHTTPSessionManager进行网络请求操作。

ServerAPI层为离散型网络请求发起层，每个请求都封装成一个类，继承自基类ICDBaseRequest，基类提供requestURI、requestMethod、requestJson等方法，由子类继承来覆盖默认值。基类同时封装好了URL缓存逻辑，提供URL缓存对象供外部调用。

Service层按功能模块调用API，把同一个功能模块的相关API放到同一个Service里进行操作，同时把API请求获取的Response数据解析为Model数据，供业务程序员进行界面布局。