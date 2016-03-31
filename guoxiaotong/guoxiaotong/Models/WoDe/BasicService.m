//
//  BasicService.m
//  guoxiaotong
//
//  Created by zxc on 16/3/21.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BasicService.h"
#import "ContectMemberModel.h"
#import "ContectRoleModel.h"

#import "TrendModel.h"
#import "ImageModel.h"

#import "SchoolModel.h"
#import "GradeModel.h"
#import "ClassModel.h"

#import "RelationModel.h"
#import "TaskDoneModel.h"

@interface BasicService()

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) HttpClient *manager;

@end

@implementation BasicService

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        _view = view;
        _manager = [[HttpClient alloc] init];
    }
    return self;
}

- (void)getContect:(NSDictionary *)params callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_CONTACTLIST_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *roles = json[@"members"];
        NSMutableArray *roleList = [NSMutableArray array];
        if (roles) {
            for (NSDictionary *roleDict in roles) {
                ContectRoleModel *roleModel = [[ContectRoleModel alloc] initWithDictionary:roleDict];
                NSMutableArray *memberList = [NSMutableArray array];
                NSArray *members = roleDict[@"userBean"];
                if (members) {
                    for (NSDictionary *memberDict in members) {
                        ContectMemberModel *memberModel = [[ContectMemberModel alloc] initWithDictionary:memberDict];
                        [memberList addObject:memberModel];
                    }
                    roleModel.memberList = memberList;
                }
                [roleList addObject:roleModel];
            }
        }
        if (callBack) {
            callBack(YES, roleList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

- (void)getCollectTrendList:(NSDictionary *)params callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_COLLECT_TREND_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *trends = json[@"comment"];
        NSMutableArray *trendList = [NSMutableArray array];
        if (trends) {//
            for (NSDictionary *trendDict in trends) {
                TrendModel *trendModel = [[TrendModel alloc] initWithDictionary:trendDict];
                NSDictionary *userDict = trendDict[@"userBean"];
                UserInfoModel *userInfoModel = [[UserInfoModel alloc] initWithDictionary:userDict];
                trendModel.userInfo = userInfoModel;
                NSArray *images = trendDict[@"picBean"];
                NSMutableArray *imageList = [NSMutableArray array];
                if (images) {
                    for (NSDictionary *imageDict in images) {
                        ImageModel *imageModel = [[ImageModel alloc] initWithDictionary:imageDict];
                        [imageList addObject:imageModel];
                    }
                    trendModel.imageList = imageList;
                }
                [trendList addObject:trendModel];
            }
        }
        if (callBack) {
            callBack(YES, trendList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

- (void)getCollectImageList:(NSDictionary *)params callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_COLLECT_IMAGE_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *images = json[@"comment"];
        NSMutableArray *imageList = [NSMutableArray array];
        if (images) {//
            for (NSDictionary *dict in images) {
                ImageModel *imageModel = [[ImageModel alloc] initWithDictionary:dict];
                [imageList addObject:imageModel];
            }
        }
        if (callBack) {
            callBack(YES, imageList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

- (void)getSchoolListWithCityName:(NSString *)cityName callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_BASIC_SCHOOLLIST_URL requestParams:@{@"cityName": cityName} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *schools = json[@"school"];
        NSMutableArray *schoolList = [NSMutableArray array];
        if (schools) {//
            for (NSDictionary *dict in schools) {
                SchoolModel *schoolModel = [[SchoolModel alloc] initWithDictionary:dict];
                [schoolList addObject:schoolModel];
            }
        }
        if (callBack) {
            callBack(YES, schoolList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

- (void)getGradeListWithSchoolId:(NSString *)schoolId callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_BASIC_CLASSLIST_URL requestParams:@{@"schoolId": schoolId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)getRelationListCallBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_BASIC_RELATION_URL requestParams:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *relations = json[@"relation"];
        NSMutableArray *relationList = [NSMutableArray array];
        if (relations.count) {
            for (NSDictionary *dict in relations) {
                RelationModel *model = [[RelationModel alloc] initWithDictionary:dict];
                [relationList addObject:model];
            }
        }
        if (callBack) {
            callBack(YES, relationList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

- (void)addChild:(NSDictionary *)params callBack:(void (^)(NSInteger, NSString *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_ADD_CHILD_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *json = responseObject;
        [LoadingView hideCenterActivity:self.view];
        if (callBack) {
            callBack([json[@"code"] integerValue], json[@"msg"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(-1, @"请求失败");
        }
    }];
}

- (void)applyForHeader:(NSDictionary *)params callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_APPLY_XIAOZHANG_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)uploadImage:(NSData *)imageFile callBack:(void (^)(BOOL, NSString *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_UPDATE_ICON_URL requestParams:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        // 设置时间格式
//        formatter.dateFormat = @"yyyyMMddHHmmss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"png"];
       /*
              此方法参数
                  1. 要上传的[二进制数据]
                  2. 对应网站上[upload.php中]处理文件的[字段"file"]
                  3. 要保存在服务器上的[文件名]
                  4. 上传文件的[mimeType]
             */
        [formData appendPartWithFileData:imageFile name:@"file" fileName:fileName mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", operation.responseString);
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSString *picPath = json[@"url"];
        if (callBack) {
            callBack(YES, picPath);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

- (void)doTask:(NSString *)type callBack:(void (^)(NSInteger, NSString *, NSString *, NSString *, NSString *))callBack {
    [LoadingView showCenterActivity:_view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"userId": shareInfo.userId, @"type": type};
    [_manager post:API_DO_TASK_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *json = responseObject;
        [LoadingView hideCenterActivity:self.view];
        if (callBack) {
            callBack([json[@"code"] integerValue], json[@"msg"], json[@"reward"], json[@"totalPoint"], json[@"lastday"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(-1, @"请求失败", nil, nil, nil);
        }
    }];
}

- (void)getTaskDidListCallBack:(void (^)(NSInteger, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"userId": shareInfo.userId};
    [_manager post:API_DID_TASKS_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *json = responseObject;
        NSArray *tasks = json[@"myTask"];
        [LoadingView hideCenterActivity:self.view];
        NSMutableArray *taskList = [NSMutableArray array];
        for (NSDictionary *dict in tasks) {
            TaskDoneModel *model = [[TaskDoneModel alloc] initWithDictionary:dict];
            [taskList addObject:model];
        }
        if (callBack) {
            callBack([json[@"code"] integerValue], taskList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(-1, nil);
        }
    }];
}

- (void)getUserInfo:(NSString *)loginName callBack:(void (^)(BOOL, UserInfoModel *))callBack {
    [_manager post:API_ROLELIST_URL requestParams:@{@"loginName": loginName} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *json = responseObject;
        NSDictionary *userInfo = json[@"userBean"];
        UserInfoModel *infoModel;
        if (userInfo) {
            infoModel = [[UserInfoModel alloc] initWithDictionary:userInfo];
        }
        if (callBack) {
            callBack(YES, infoModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

@end
