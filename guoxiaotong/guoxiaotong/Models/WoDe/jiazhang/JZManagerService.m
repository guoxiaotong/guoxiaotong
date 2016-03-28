//
//  JZManagerService.m
//  guoxiaotong
//
//  Created by zxc on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "JZManagerService.h"
#import "JZMemberModel.h"

@interface JZManagerService()

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) HttpClient *manager;

@end

@implementation JZManagerService

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        _view = view;
        _manager = [[HttpClient alloc] init];
    }
    return self;
}

- (void)getMemberList:(NSDictionary *)params callBack:(void (^)(BOOL, NSArray *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_BASIC_JIAZHANGLIST_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *members = json[@"manager"];
        NSMutableArray *memberList = [NSMutableArray array];
        if (members) {
            for (NSDictionary *dict in members) {
                JZMemberModel *model = [[JZMemberModel alloc] initWithDictionary:dict];
                [memberList addObject:model];
            }
        }
        if (callBack) {
            callBack(YES, memberList);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

- (void)getPermission:(NSDictionary *)params callBack:(void (^)(BOOL, JZPermissionModel *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_JIAZHANG_GET_PERMISSION_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSDictionary *permissions = json[@"permission"];
        JZPermissionModel *model;
        if (permissions) {
            model = [[JZPermissionModel alloc] initWithDictionary:permissions];
        }
        if (callBack) {
            callBack(YES, model);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (callBack) {
            callBack(NO, nil);
        }
    }];
}

- (void)setPermission:(NSDictionary *)params callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_JIAZHANG_SET_PERMISSION_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)changeJHR:(NSDictionary *)params callBack:(void (^)(NSInteger, NSString *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_CLASS_CHANGE_JHR_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
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

- (void)deleteJZ:(NSDictionary *)params callBack:(void (^)(NSInteger, NSString *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_CLASS_DEL_JIAZHANG_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
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

- (void)addMember:(NSDictionary *)params callBack:(void (^)(NSInteger, NSString *))callBack {
    [LoadingView showCenterActivity:_view];
    [_manager post:API_CLASS_ADD_JIAZHANG_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
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

@end
