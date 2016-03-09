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

typedef void(^httpSuccess)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^httpFailure)(AFHTTPRequestOperation *operation, NSError *error);

@interface HttpClient : NSObject

- (void)get:(NSString *)url requestParams:(NSDictionary *)requestParams success:(httpSuccess)success failure:(httpFailure)failure;

@end
