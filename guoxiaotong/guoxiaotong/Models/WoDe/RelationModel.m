//
//  RelationModel.m
//  guoxiaotong
//
//  Created by zxc on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "RelationModel.h"

@implementation RelationModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _relationId = value;
    }
}

@end
