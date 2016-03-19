//
//  ManagerService.m
//  guoxiaotong
//
//  Created by zxc on 16/3/17.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ManagerService.h"

@interface ManagerService()

@property (nonatomic, strong) HttpClient *manager;

@end

@implementation ManagerService

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        _view = view;
        _manager = [[HttpClient alloc] init];
    }
    return self;
}

- (void)getSchoolInfo:(NSInteger)schoolId callBack:(void (^)(BOOL, SchoolModel *))callBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"schoolId": [NSNumber numberWithInteger:schoolId]};
    [_manager post:API_BASIC_SCHOOLLIST_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *schools = json[@"school"];
        NSDictionary *school = [schools firstObject];
        SchoolModel *schoolInfo;
        if (school) {
            schoolInfo = [[SchoolModel alloc] initWithDictionary:school];
        }
        if (callBack) {
            callBack(YES, schoolInfo);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

- (void)getCourseList:(NSInteger)schoolId page:(NSInteger)page callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"schoolId": [NSNumber numberWithInteger:schoolId], @"page": [NSNumber numberWithInteger:page]};
    [_manager post:API_BASIC_SCHOOL_COURSELIST_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *courses = json[@"courseList"];
        NSMutableArray *courseList = [NSMutableArray array];
        if (courses.count) {
            for (NSDictionary *dict in courses) {
                CourseModel *model = [[CourseModel alloc] initWithDictionary:dict];
#warning 课程里面有schoolInfo《需不需要解？》
                [courseList addObject:model];
            }
        }
        if (callBack) {
            callBack(YES, courseList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

- (void)getClassList:(NSInteger)schoolId callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"schoolId": [NSNumber numberWithInteger:schoolId]};
    [_manager post:API_BASIC_CLASSLIST_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *grades = json[@"grade"];
        NSMutableArray *gradeList = [NSMutableArray array];
        if (grades.count) {
            for (NSDictionary *dict in grades) {
                GradeModel *gradeModel = [[GradeModel alloc] initWithDictionary:dict];
                NSArray *classes = dict[@"classesBean"];
                NSMutableArray *classList = [NSMutableArray array];
                if (classes.count) {
                    for (NSDictionary *classDict in classes) {
                        ClassModel *classModel = [[ClassModel alloc] initWithDictionary:classDict];
                        NSDictionary *bzrDict = classDict[@"tutorBean"];
                        if (bzrDict) {
                            BZRModel *bzrModel = [[BZRModel alloc] initWithDictionary:bzrDict];
                            classModel.bzrInfo = bzrModel;
                        }
                        [classList addObject:classModel];
                    }
                    gradeModel.classList = classList;
                }
                [gradeList addObject:gradeModel];
            }
        }
        if (callBack) {
            callBack(YES, gradeList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

- (void)getTeacherList:(NSInteger)schoolId callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"schoolId": [NSNumber numberWithInteger:schoolId]};
    [_manager post:API_BASIC_TEACHERLIST_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *teachers = json[@"teacherList"];
        NSMutableArray *teacherList = [NSMutableArray array];
        if (teachers) {
            for (NSDictionary *teacherDict in teachers) {
                TeacherModel *teacherModel = [[TeacherModel alloc] initWithDictionary:teacherDict];
                [teacherList addObject:teacherModel];
            }
        }
        if (callBack) {
            callBack(YES, teacherList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

- (void)getTeacherList:(NSInteger)schoolId keyWord:(NSString *)keyWord callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"schoolId": [NSNumber numberWithInteger:schoolId], @"keyword": keyWord};
    [_manager post:API_BASIC_TEACHERLIST_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *teachers = json[@"teacherList"];
        NSMutableArray *teacherList = [NSMutableArray array];
        if (teachers) {
            for (NSDictionary *teacherDict in teachers) {
                TeacherModel *teacherModel = [[TeacherModel alloc] initWithDictionary:teacherDict];
                [teacherList addObject:teacherModel];
            }
        }
        if (callBack) {
            callBack(YES, teacherList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

- (void)addTeacher:(NSDictionary *)params callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_ADD_SCHOOL_TEACHER_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        if (callBack) {
            callBack(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO);
        }
    }];
}

- (void)deleteTeacher:(NSDictionary *)params callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_DEL_SCHOOL_TEACHER_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        if (callBack) {
            callBack(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO);
        }
    }];
}

- (void)getEmailListWithUserId:(NSString *)userId page:(NSInteger)page callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"userId": userId, @"page": [NSNumber numberWithInteger:page]};
    [_manager post:API_XIAOZHANG_EMAILLIST_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *emails = json[@"comment"];
        NSMutableArray *emailList = [NSMutableArray array];
        if (emails.count) {
            for (NSDictionary *emailDict in emails) {
                XZEmailModel *emailModel = [[XZEmailModel alloc] initWithDictionary:emailDict];
                NSDictionary *userDict = emailDict[@"userBean"];
                if (userDict) {
                    UserInfoModel *userInfoModel = [[UserInfoModel alloc] initWithDictionary:userDict];
                    emailModel.userInfo = userInfoModel;
                }
                [emailList addObject:emailModel];
            }
        }
        if (callBack) {
            callBack(YES, emailList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

- (void)getSchoolPermission:(NSInteger)schoolId callBack:(void (^)(BOOL, SchoolPermissionModel *))callBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"schoolId": [NSNumber numberWithInteger:schoolId]};
    [_manager post:API_SCHOOL_SETTING_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSDictionary *permissionDict = json[@"permission"];
        SchoolPermissionModel *schoolPermissModel;
        if (permissionDict) {
            schoolPermissModel = [[SchoolPermissionModel alloc] initWithDictionary:permissionDict];
        }
        if (callBack) {
            callBack(YES, schoolPermissModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

- (void)setSchoolPermission:(NSString *)userId permissions:(NSDictionary *)permissions callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:permissions];
    [params setObject:userId forKey:@"userId"];
    [_manager post:API_SET_SCHOOL_SETTING_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        if (callBack) {
            callBack(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO);
        }
    }];
}

- (void)deleteCourseWithCourseId:(NSString *)courseId callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"courseId": courseId};
    [_manager post:API_DEL_SCHOOL_COURSE_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        if (callBack) {
            callBack(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO);
        }
    }];
}

- (void)addCourseWith:(NSDictionary *)params callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_ADD_SCHOOL_COURSE_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        if (callBack) {
            callBack(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO);
        }
    }];

}

@end
