//
//  UserLoginModel.m
//  guoxiaotong
//
//  Created by zxc on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "UserLoginModel.h"

@implementation UserLoginModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super initWithDictionary:dict]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
