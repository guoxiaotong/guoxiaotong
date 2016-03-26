//
//  UserModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"

@class UserRoleInfoModel, UserInfoModel;

@interface UserModel : BaseModel

@property (nonatomic, strong) NSArray<UserRoleInfoModel *> *roleInfoList;
@property (nonatomic, strong) UserInfoModel *userInfo;


@end
