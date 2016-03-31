//
//  UserService.h
//  guoxiaotong
//
//  Created by zxc on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

typedef void(^HttpRequestCallBack)(BOOL isSuccessed, id data, NSError *error);

@interface UserService : NSObject
/**初始化：在view上显示加载动画*/
- (instancetype)initWithView:(UIView *)view;
/**登录*/
- (void)loginWithName:(NSString *)name password:(NSString *)password callBack:(void (^)(BOOL isSuccess, NSString *msg))requestCallBack;
/**获取用户信息*/
- (void)getProfileWithCallBack:(void (^)(BOOL isSuccess, UserInfoModel *userInfo))callBack;
/**修改用户信息*/
- (void)editProfileWithParams:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess))callBack;
/**获取用户角色列表信息*/
- (void)getRoleListWithUserId:(NSString *)userId callBack:(void (^)(BOOL isSuccess, NSArray *roleList))requestCallBack;

/**修改图像*/
- (void)editIconWithParams:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess))callBack;

/**修改角色昵称*/
- (void)editRoleName:(NSDictionary *)params callBack:(void (^)(NSInteger code, NSString *msg))callBack;

/**修改密码*/
- (void)editPassword:(NSDictionary *)params callBack:(void (^)(NSInteger code, NSString *msg))callBack;

/**获取验证码*/
- (void)getCode:(NSDictionary *)params callBack:(void (^)(NSInteger code, NSString *msg))callBack;

/**验证验证码*/
- (void)checkCode:(NSDictionary *)params callBack:(void (^)(NSInteger code, NSString *msg))callBack;
/**注册*/
- (void)registerInfo:(NSDictionary *)params callBack:(void (^)(NSInteger code, NSString *msg))callBack;
/**找回密码*/
- (void)forgetPassword:(NSDictionary *)params callBack:(void (^)(NSInteger code, NSString *msg))callBack;

@end
