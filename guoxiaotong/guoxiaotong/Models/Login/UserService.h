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
- (void)loginWithName:(NSString *)name password:(NSString *)password callBack:(void (^)(BOOL isSuccess))requestCallBack;
/**获取用户信息*/
- (void)getProfileWithCallBack:(void (^)(BOOL isSuccess, UserInfoModel *userInfo))callBack;
/**修改用户信息*/
- (void)editProfileWithData:(NSString *)dataFormatter callBack:(void (^)(BOOL isSuccess))callBack;
/**获取用户角色列表信息*/
- (void)getRoleListWithUserId:(NSString *)userId callBack:(void (^)(BOOL isSuccess, NSArray *roleList))requestCallBack;

@end
