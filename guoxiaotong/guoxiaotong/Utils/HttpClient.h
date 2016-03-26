//
//  HttpClient.h
//  GXTTest
//
//  Created by zxc on 16/3/8.
//  Copyright © 2016年 zxc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Config.h"

@interface HttpClient : NSObject
/**get:所有的基于http://121.42.27.199:8888/csCampus/的网络请求方法*/
- (void)post:(NSString *)url requestParams:(id)parameters success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**上传方法*/
- (void)post:(NSString *)url requestParams:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**独立网址的网络请求*/
- (void)postSingleUrl:(NSString *)url requestParams:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure;

@end
