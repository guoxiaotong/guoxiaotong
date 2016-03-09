//
//  HttpClient.m
//  GXTTest
//
//  Created by zxc on 16/3/8.
//  Copyright © 2016年 zxc. All rights reserved.
//

#import "HttpClient.h"
#import "LoadingView.h"

@implementation HttpClient

- (void)get:(NSString *)url requestParams:(NSDictionary *)requestParams success:(httpSuccess)success failure:(httpFailure)failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", API_ROOT_URL, url];
    [manager GET: requestUrl parameters: requestParams success: success failure: failure];
}

@end
