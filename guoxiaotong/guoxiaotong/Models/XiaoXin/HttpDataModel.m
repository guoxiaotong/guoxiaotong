//
//  HttpDataModel.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "HttpDataModel.h"


@implementation HttpDataModel

+(void)urlhead:(NSString *)headStr Andurlbody:(NSDictionary *)bodyDict blk:(MyBlock3)blkc{
    
    
__block NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
    
    AFHTTPRequestOperationManager *requst = [AFHTTPRequestOperationManager manager];
    //设置响应格式为NSData
    requst.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [requst  POST:headStr parameters:bodyDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功ffdgfgfg");
        
        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
       
     
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
    }];
    
    
    }

@end
