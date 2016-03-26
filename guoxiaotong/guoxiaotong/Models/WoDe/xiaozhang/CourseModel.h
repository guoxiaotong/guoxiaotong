//
//  CourseModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/18.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"
#import "SchoolModel.h"

@interface CourseModel : BaseModel

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger courseId;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *addTime;
@property (nonatomic, assign) NSInteger isValid;
@property (nonatomic, copy) NSString *courseName;
@property (nonatomic, strong) SchoolModel *school;

@end
