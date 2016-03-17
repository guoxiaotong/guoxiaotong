//
//  UserRoleSettingModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"

@interface UserRoleSettingModel : BaseModel

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *familyChat;
@property (nonatomic, copy) NSString *familyShare;
@property (nonatomic, copy) NSString *stuShare;
@property (nonatomic, copy) NSString *teacherChat;
@property (nonatomic, copy) NSString *teacherGroup;
@property (nonatomic, copy) NSString *tutorInfo;
@property (nonatomic, copy) NSString *familyGroup;
@property (nonatomic, copy) NSString *familySeeShare;
@property (nonatomic, copy) NSString *stuChat;

@end
