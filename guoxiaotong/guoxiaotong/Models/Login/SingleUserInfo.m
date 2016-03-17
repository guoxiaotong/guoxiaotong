//
//  SingleUserInfo.m
//  guoxiaotong
//
//  Created by zxc on 16/3/14.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "SingleUserInfo.h"

@implementation SingleUserInfo


+ (SingleUserInfo *)shareUserInfo {
    static SingleUserInfo *userInfo = nil;
    if (!userInfo) {
        userInfo = [[SingleUserInfo alloc] init];
    }
    return userInfo;
}

@end
