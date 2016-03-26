//
//  ClassModel.m
//  guoxiaotong
//
//  Created by zxc on 16/3/18.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _classId = [value integerValue];
    }
}

@end
