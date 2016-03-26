//
//  GradeModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/18.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"
#import "ClassModel.h"

@interface GradeModel : BaseModel

@property (nonatomic, copy) NSString *gradeId;
@property (nonatomic, copy) NSString *gradeName;
@property (nonatomic, assign) NSInteger classNum;
@property (nonatomic, strong) NSArray *classList;
@property (nonatomic, assign, getter=isOpen) BOOL open;

@end
