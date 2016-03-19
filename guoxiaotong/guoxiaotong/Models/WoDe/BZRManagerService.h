//
//  BZRManagerService.h
//  guoxiaotong
//
//  Created by zxc on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZRQuanXianModel.h"

@interface BZRManagerService : NSObject

- (instancetype)initWithView:(UIView *)view;

/**班主任管理（获取课程列表）*/
-(void)getCourseList:(NSString *)classId page:(NSInteger)page callBack:(void (^)(BOOL isSuccess, NSArray *courseList))callBack;

/**班主任管理（获取学生列表classId userId）*/
- (void)getStudentList:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess, NSArray *studentList))callBack;

/**班主任管理：学生管理（删除监护人）*/
- (void)deleteJianhuren:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess))callBack;

/**班主任 获取班级权限*/
- (void)getSettings:(NSString *)classId callBack:(void (^)(BOOL isSuccess, BZRQuanXianModel *quanxianModel))callBack;

/**班主任 设置权限*/
- (void)setSettings:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess))callBack;

@end
