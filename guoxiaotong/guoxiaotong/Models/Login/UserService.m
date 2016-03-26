//
//  UserService.m
//  guoxiaotong
//
//  Created by zxc on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "UserService.h"
#import "HttpClient.h"
#import "Config.h"

#import "UserLoginModel.h"
#import "UserRoleInfoModel.h"
#import "UserInfoModel.h"
#import "SingleUserInfo.h"

@interface UserService()

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) HttpClient *clientManager;
@property (nonatomic, copy) NSString *url;

@end

@implementation UserService

- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        _view = view;
        _clientManager = [[HttpClient alloc] init];
    }
    return self;
}
#pragma mark - 登陆之后需要请求及保存数据
- (void)didLogin:(NSString *)loginName password:(NSString *)password {
    //userId已知
    [self getProfileWithCallBack:^(BOOL isSuccess, UserInfoModel *userInfo) {
        if (isSuccess) {
            SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
            shareInfo.userName = userInfo.userName;
            shareInfo.loginName = userInfo.loginName;
        }
    }];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:loginName forKey:@"loginName"];
    [def setObject:password forKey:@"password"];
    [def synchronize];
}

#pragma mark - 用户登录
- (void)loginWithName:(NSString *)name password:(NSString *)password callBack:(void (^)(BOOL, NSString *))requestCallBack {
    [LoadingView showCenterActivity:_view];
    NSDictionary *params = @{@"userName": name, @"password": password};
    [_clientManager post:API_LOGIN_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", responseObject);
        NSDictionary *json = responseObject;
        [LoadingView showBottom:self.view messages:@[json[@"msg"]]];
        if ([json[@"code"] integerValue] == 0) {
            NSDictionary *userDict = json[@"user"];
            if (userDict) {
                UserLoginModel *loginModel = [[UserLoginModel alloc] initWithDictionary:userDict];
                //登录成功之后需要做的事情
                SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
                shareInfo.userId = loginModel.userId;
                shareInfo.picPath = loginModel.picPath;
                [self didLogin:loginModel.loginName password:password];
            }
            if (requestCallBack) {
                requestCallBack(YES, json[@"msg"]);
            }
        }else {
            if (requestCallBack) {
                requestCallBack(NO, json[@"msg"]);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (requestCallBack) {
            requestCallBack(NO, @"登录失败");
        }
    }];
}

#pragma mark - 获取用户资料
- (void)getProfileWithCallBack:(void (^)(BOOL, UserInfoModel *))callBack {
    [LoadingView showCenterActivity:_view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    [_clientManager post:API_ROLELIST_URL requestParams:@{@"userId": shareInfo.userId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
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
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

#pragma mark - 修改用户资料
- (void)editProfileWithParams:(NSDictionary *)params callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    [_clientManager post:API_EDIT_PROFILE_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        if (callBack) {
            callBack(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        if (callBack) {
            callBack(NO);
        }
        NSLog(@"%@", error);
    }];
}

#pragma mark - 获取角色列表
- (void)getRoleListWithUserId:(NSString *)userId callBack:(void (^)(BOOL, NSArray *))requestCallBack {
    [LoadingView showCenterActivity:_view];
    [_clientManager post:API_ROLELIST_URL requestParams:@{@"userId": userId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        NSArray *roles = json[@"roleInfo"];
        NSMutableArray *roleList = [NSMutableArray array];
        if (roles.count != 0) {
            for (NSDictionary *role in roles) {
                UserRoleInfoModel *roleInfo = [[UserRoleInfoModel alloc] initWithDictionary:role];
                [roleList addObject:roleInfo];
            }
        }
        if (requestCallBack) {
            requestCallBack(YES, roleList);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

- (void)editIconWithParams:(NSDictionary *)params callBack:(void (^)(BOOL))callBack {
    [_clientManager post:API_EDIT_PROFILE_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callBack) {
            callBack(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callBack) {
            callBack(NO);
        }
        NSLog(@"%@", error);
    }];
}

- (void)editRoleName:(NSDictionary *)params callBack:(void (^)(NSInteger, NSString *))callBack {
    [LoadingView showCenterActivity:_view];
    [_clientManager post:API_EDIT_ROLENAME_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        if (callBack) {
            callBack([json[@"code"] integerValue], json[@"msg"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

- (void)editPassword:(NSDictionary *)params callBack:(void (^)(NSInteger, NSString *))callBack {
    [LoadingView showCenterActivity:_view];
    [_clientManager post:API_EDIT_PWD_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSDictionary *json = responseObject;
        if (callBack) {
            callBack([json[@"code"] integerValue], json[@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
    }];
}

@end
