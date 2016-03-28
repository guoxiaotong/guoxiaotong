//
//  SingleUserInfo.m
//  guoxiaotong
//
//  Created by zxc on 16/3/14.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "SingleUserInfo.h"

@implementation SingleUserInfo

- (instancetype)init {
    if (self = [super init]) {
        _roleList = [NSMutableArray array];
    }
    return self;
}

+ (SingleUserInfo *)shareUserInfo {
    static SingleUserInfo *userInfo = nil;
    if (!userInfo) {
        userInfo = [[SingleUserInfo alloc] init];
    }
    return userInfo;
}

@end
