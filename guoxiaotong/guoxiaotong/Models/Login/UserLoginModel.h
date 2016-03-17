//
//  UserLoginModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"

@interface UserLoginModel : BaseModel

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *picPath;
@property (nonatomic, copy) NSString *userRoleId;
@property (nonatomic, copy) NSString *loginName;
@property (nonatomic, copy) NSString *userId;

@end


