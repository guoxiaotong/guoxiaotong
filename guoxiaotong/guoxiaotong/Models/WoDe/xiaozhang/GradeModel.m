//
//  GradeModel.m
//  guoxiaotong
//
//  Created by zxc on 16/3/18.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "GradeModel.h"

@implementation GradeModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super initWithDictionary:dict]) {
        _open = NO;
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
