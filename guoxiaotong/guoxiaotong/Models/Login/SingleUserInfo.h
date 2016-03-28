//
//  SingleUserInfo.h
//  guoxiaotong
//
//  Created by zxc on 16/3/14.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserRoleInfoModel.h"

@interface SingleUserInfo : NSObject

@property (nonatomic, assign) NSInteger roleId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *picPath;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *loginName;

@property (nonatomic, strong) NSMutableArray *roleList;
@property (nonatomic, strong) UserRoleInfoModel *roleInfo;

+ (SingleUserInfo *)shareUserInfo;

@end
