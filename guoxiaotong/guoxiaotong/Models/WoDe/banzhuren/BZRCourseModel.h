//
//  BZRCourseModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"

@interface BZRCourseModel : BaseModel

@property (nonatomic, copy) NSString *courseName;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *courseId;
@property (nonatomic, copy) NSString *courseTeacher;
@property (nonatomic, assign) NSInteger teacherId;

@end
