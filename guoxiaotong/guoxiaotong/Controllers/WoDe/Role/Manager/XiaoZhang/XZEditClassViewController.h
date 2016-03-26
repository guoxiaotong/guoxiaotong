//
//  XZEditClassViewController.h
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GradeModel.h"
#import "BaseScrollViewController.h"

@interface XZEditClassViewController : BaseScrollViewController

@property (nonatomic, strong) UserRoleInfoModel *roleInfo;
@property (nonatomic, strong) NSArray *gradeList;

@end
