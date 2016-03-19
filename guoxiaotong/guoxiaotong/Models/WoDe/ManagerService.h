//
//  ManagerService.h
//  guoxiaotong
//
//  Created by zxc on 16/3/17.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SchoolModel.h"
#import "CourseModel.h"

#import "GradeModel.h"
#import "ClassModel.h"
#import "BZRModel.h"

#import "TeacherModel.h"
#import "XZEmailModel.h"
#import "SchoolPermissionModel.h"

@interface ManagerService : NSObject

@property (nonatomic, strong) UIView *view;

/**在view上显示加载动画*/
- (instancetype)initWithView:(UIView *)view;

/**获取学校信息<传入schoolId，只有校长看得到>*/
- (void)getSchoolInfo:(NSInteger)schoolId callBack:(void (^)(BOOL isSuccess, SchoolModel *schoolInfo))callBack;
/**获取课程列表《传入schoolId，page》*/
- (void)getCourseList:(NSInteger)schoolId page:(NSInteger)page callBack:(void (^)(BOOL isSuccess, NSArray *courseList))callBack;

/**班级管理（获取班级列表）*/
- (void)getClassList:(NSInteger)schoolId callBack:(void (^)(BOOL isSuccess, NSArray *gradeList))callBack;

/**老师管理（获取老师列表——schoolId）*/
- (void)getTeacherList:(NSInteger)schoolId callBack:(void (^)(BOOL isSuccess, NSArray *teacherList))callBack;

/**获取老师列表（搜索关键字）*/
- (void)getTeacherList:(NSInteger)schoolId keyWord:(NSString *)keyWord callBack:(void (^)(BOOL isSuccess, NSArray *teacherList))callBack;

/**添加教师（userId，teachername，phone=loginName）*/
- (void)addTeacher:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess))callBack;

/**删除教师（schoolId，teacherid）*/
- (void)deleteTeacher:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess))callBack;

/**获取校长信箱列表*/
- (void)getEmailListWithUserId:(NSString *)userId page:(NSInteger)page callBack:(void (^)(BOOL isSuccess, NSArray *emailList))callBack;

/**获取学校权限*/
- (void)getSchoolPermission:(NSInteger)schoolId callBack:(void (^)(BOOL isSuccess, SchoolPermissionModel *schollPermission))callBack;

/**设置学校权限(传入userId，权限列表)*/
- (void)setSchoolPermission:(NSString *)userId permissions:(NSDictionary *)permissions callBack:(void (^)(BOOL isSuccess))callBack;

/**删除课程（传入courseId）*/
- (void)deleteCourseWithCourseId:(NSString *)courseId callBack:(void (^)(BOOL isSuccess))callBack;

/**添加课程（传入）*/
- (void)addCourseWith:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess))callBack;

@end
