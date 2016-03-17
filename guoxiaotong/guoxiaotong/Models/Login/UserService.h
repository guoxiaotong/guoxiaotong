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

- (instancetype)initWithView:(UIView *)view;

- (void)loginWithName:(NSString *)name password:(NSString *)password callBack:(void (^)(BOOL isSuccess))requestCallBack;

- (void)getProfileWithCallBack:(void (^)(BOOL isSuccess, UserInfoModel *userInfo))callBack;

- (void)editProfileWithData:(NSString *)dataFormatter callBack:(void (^)(BOOL isSuccess))callBack;

- (void)getRoleListWithUserId:(NSString *)userId callBack:(void (^)(BOOL isSuccess, NSArray *roleList))requestCallBack;

@end
