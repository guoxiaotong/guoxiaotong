//
//  JZManagerService.h
//  guoxiaotong
//
//  Created by zxc on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZPermissionModel.h"

@interface JZManagerService : NSObject

- (instancetype)initWithView:(UIView *)view;

/**家长 获取成员列表(studentId,userId)*/
- (void)getMemberList:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess, NSArray *memberList))callBack;

/**家长 获取权限（classId，userId）*/
- (void)getPermission:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess, JZPermissionModel *permissions))callBack;
/**家长 设置权限（classId，userId，设置）*/
- (void)setPermission:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess))callBack;

/**设置监护人*/
- (void)changeJHR:(NSDictionary *)params callBack:(void (^)(NSInteger code, NSString *msg))callBack;

/**删除家长*/
- (void)deleteJZ:(NSDictionary *)params callBack:(void (^)(NSInteger code, NSString *msg))callBack;

/**添加家庭成员*/
- (void)addMember:(NSDictionary *)params callBack:(void (^)(NSInteger code, NSString *msg))callBack;

@end
