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
- (void)didLogin {
    //userId已知
    [self getProfileWithCallBack:^(BOOL isSuccess, UserInfoModel *userInfo) {
        if (isSuccess) {
            SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
            shareInfo.userName = userInfo.userName;
        }
    }];
    
    
}

#pragma mark - 用户登录
- (void)loginWithName:(NSString *)name password:(NSString *)password callBack:(void (^)(BOOL))requestCallBack {
    [LoadingView showCenterActivity:_view];
    //    __weak typeof (*&self)weakSelf = self;
    NSDictionary *params = @{@"userName": name, @"password": password};
    [_clientManager get:API_LOGIN_URL requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", responseObject);
        NSDictionary *json = responseObject;
        NSDictionary *userDict = json[@"user"];
        if (userDict) {
            UserLoginModel *loginModel = [[UserLoginModel alloc] initWithDictionary:userDict];
            //登录成功之后需要做的事情
            SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
            shareInfo.userId = loginModel.userId;
            shareInfo.picPath = loginModel.picPath;
            [self didLogin];
        }
        if (requestCallBack) {
            requestCallBack(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LoadingView hideCenterActivity:self.view];
        NSLog(@"%@", error);
        if (requestCallBack) {
            requestCallBack(NO);
        }
    }];
}

#pragma mark - 获取用户资料
- (void)getProfileWithCallBack:(void (^)(BOOL, UserInfoModel *))callBack {
    [LoadingView showCenterActivity:_view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    [_clientManager get:API_ROLELIST_URL requestParams:@{@"userId": shareInfo.userId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
- (void)editProfileWithData:(NSString *)dataFormatter callBack:(void (^)(BOOL))callBack {
    [LoadingView showCenterActivity:_view];
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", API_EDIT_PROFILE_URL, dataFormatter];
    [_clientManager get:requestUrl requestParams:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    [_clientManager get:API_ROLELIST_URL requestParams:@{@"userId": userId} success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

@end
