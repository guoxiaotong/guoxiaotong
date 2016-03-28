//
//  ContectRoleModel.m
//  guoxiaotong
//
//  Created by zxc on 16/3/21.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ContectRoleModel.h"

@implementation ContectRoleModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super initWithDictionary:dict]) {
        _open = NO;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
