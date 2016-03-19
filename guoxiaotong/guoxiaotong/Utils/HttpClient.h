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
/**get:所有的网络请求方法*/
- (void)post:(NSString *)url requestParams:(id)parameters success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
