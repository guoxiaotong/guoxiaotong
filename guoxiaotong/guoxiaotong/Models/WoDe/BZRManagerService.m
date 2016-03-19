//
//  BZRManagerService.m
//  guoxiaotong
//
//  Created by zxc on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BZRManagerService.h"
#import "BZRCourseModel.h"
#import "BZRJianhurenModel.h"

@interface BZRManagerService()

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) HttpClient *manager;

@end

@implementation BZRManagerService

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        _view = view;
        _manager = [[HttpClient alloc] init];
    }
    return self;
}

- (void)getCourseList:(NSString *)classId page:(NSInteger)page callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"classesId": classId, @"page": [NSNumber numberWithInteger:page]};
    [_manager post:API_BASIC_CLASS_COURSELIST_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *courses = json[@"courseList"];
        NSMutableArray *courseList = [NSMutableArray array];
        if (courses) {
            for (NSDictionary *courseDict in courses) {
                BZRCourseModel *courseModel = [[BZRCourseModel alloc] initWithDictionary:courseDict];
                [courseList addObject:courseModel];
            }
        }
        if (callBack) {
            callBack(YES, courseList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

- (void)getStudentList:(NSDictionary *)params callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_BASIC_GUARDIANLIST_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *guardians = json[@"guardian"];
        NSMutableArray *studentList = [NSMutableArray array];
        if (guardians) {
            for (NSDictionary *guardianDict in guardians) {
                BZRJianhurenModel *jianhurenModel = [[BZRJianhurenModel alloc] initWithDictionary:guardianDict];
                [studentList addObject:jianhurenModel];
            }
        }
        if (callBack) {
            callBack(YES, studentList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

- (void)deleteJianhuren:(NSDictionary *)params callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_CLASS_DEL_JIANHUREN_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)getSettings:(NSString *)classId callBack:(void (^)(BOOL, BZRQuanXianModel *))callBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"classId": classId};
    [_manager post:API_CLASS_GET_QUANXIAN_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSDictionary *permission = json[@"permission"];
        BZRQuanXianModel *quanxianModel;
        if (permission) {
            quanxianModel = [[BZRQuanXianModel alloc] initWithDictionary:permission];
        }
        if (callBack) {
            callBack(YES, quanxianModel);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

- (void)setSettings:(NSDictionary *)params callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_CLASS_SET_QUANXIAN_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
