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

- (void)post:(NSString *)url requestParams:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", API_ROOT_URL, url];
    [manager POST:requestUrl parameters:parameters success:success failure:failure];
}

@end
