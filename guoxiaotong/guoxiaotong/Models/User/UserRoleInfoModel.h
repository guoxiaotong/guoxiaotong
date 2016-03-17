//
//  UserRoleInfoModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"

@class UserRoleSettingModel;


@interface UserRoleInfoModel : BaseModel

@property (nonatomic, assign) NSInteger roleId;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *studentName;
@property (nonatomic, copy) NSString *userRoleId;
@property (nonatomic, copy) NSString *schoolType;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *roleName;
@property (nonatomic, copy) NSString *schoolName;
@property (nonatomic, copy) NSString *classId;
@property (nonatomic, copy) NSString *studentId;
@property (nonatomic, strong) NSArray<UserRoleSettingModel *> *settings;

@end
