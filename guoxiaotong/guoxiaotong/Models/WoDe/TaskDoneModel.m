//
//  TaskDoneModel.m
//  guoxiaotong
//
//  Created by zxc on 16/3/24.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "TaskDoneModel.h"

@implementation TaskDoneModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"description"]) {
        _taskDescription = value;
    }
}

@end
