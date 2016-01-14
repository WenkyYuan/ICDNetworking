# ICDNetworking
基于[AFNetworking](https://github.com/AFNetworking/AFNetworking)3.0+的iOS应用网络层框架，使用Block方式向上层传递请求结果。

ICDNetworking网络层结构参照[YTKNetworking](https://github.com/yuantiku/YTKNetwork)，可看作是它的精简版，但是YTKNetworking目前（2016.1.14）不支持AFNetworking3.0+版本，仍然使用AFHTTPOperationManager进行网络请求，AFNetworking3.0+已经摈弃了封装自NSURLConnetion的类，使用AFHTTPSessionManager替代了AFHTTPOperationManager。故我重新弄了个轮子，以适应需求。

##版本
1.0.0版本：框架雏形，暂只支持POST和GET请求，支持URL缓存

##网络层结构
######ICDServerAPIUtils --> ServerAPI层（继承自ICDBaseRequest）--> Service层

ICDServerAPIUtils为网络底层处理的工具类，使用AFNetWorking的AFHTTPSessionManager进行网络请求操作。

ServerAPI层为离散型网络请求发起层，每个请求都封装成一个类，继承自基类ICDBaseRequest，基类提供requestURI、requestMethod、requestJson等方法，由子类继承来覆盖默认值。基类同时封装好了URL缓存逻辑，提供URL缓存对象供外部调用。

Service层按功能模块调用API，把同一个功能模块的相关API放到同一个Service里进行操作，同时把API请求获取的Response数据解析为Model数据，供业务程序员进行界面布局。

##Demo
ICDNetworkingDemo具有完整的项目结构，包括网络层(ICDNetworking)和使用MVVM设计模式的业务层。

- 请求

HTTP URL:
>
http://test.zone.icloudoor.com/icloudoor-web/user/api/social/listTopicByScopeWithPaging.do?sid=ae883e5d6f184e22afa3752a38aafa53&ver=iOS_1.0&imei=E0394C69-742A-46C8-B787-8FA792CE1F28


HTTP Header:

```
    {
    	"User-Agent" = "iPhone Simulator, iOS 9.2, version 1.0",
    	"Content-Type" = "application/json",
    	"Content-Length" = "33",
    	"FA" = "E0394C69-742A-46C8-B787-8FA792CE1F28",
    	"FV" = "578C00D4-C56E-44BE-8667-CEFD89F7D5C0"
    }
```



HTTP Body:

```
{
	"limit":10,
	"scope":1,
	"offset":0
}
```

- 响应


```
{
    code = 1;
    data =     {
        topics =         (
                        {
                commentCnt = 2;
                content = "\U8fdb\U4f53\U68c0\U660e\U5929";
                createTime = "2016-01-13 22:41:35";
                l1ZoneId = 14331243631100885781;
                likeCnt = 1;
                photoUrls =                 (
                    "http://icloudoor-web-test.b0.upaiyun.com/user/14356309311000227477/repair_report/2016-01-13/5485aecc759747e0889b50f38874db30.jpg",
                    "http://icloudoor-web-test.b0.upaiyun.com/user/14356309311000227477/repair_report/2016-01-13/5bdaa62b0f464ad2a09a203e64b1ee33.jpg",
                    "http://icloudoor-web-test.b0.upaiyun.com/user/14356309311000227477/repair_report/2016-01-13/e0629f051d5d44a28509aacd8ab1d408.jpg",
                    "http://icloudoor-web-test.b0.upaiyun.com/user/14356309311000227477/repair_report/2016-01-13/1e4fec858e0246c89c46e4433056edec.jpg",
                    "http://icloudoor-web-test.b0.upaiyun.com/user/14356309311000227477/repair_report/2016-01-13/83a99d0ee7f4401ba63f8177400c2e81.jpg"
                );
                publishUser =                 {
                    mobile = 13802441204;
                    nickname = jacky;
                    portraitUrl = "http://icloudoor-web-test.b0.upaiyun.com//user/14356309311000227477/portrait/f9675f635af94d4dab979225b496636b.jpg";
                    userId = 14356309311000227477;
                };
                socialId = 14526960949996427399;
            },
            ...
        );
    };
    message = "";
}
```
