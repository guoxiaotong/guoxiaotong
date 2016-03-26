//
//  SchoolPermissionModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/18.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"

@interface SchoolPermissionModel : BaseModel

@property (nonatomic, copy) NSString *familyChat;
@property (nonatomic, copy) NSString *familyShare;
@property (nonatomic, copy) NSString *stuShare;
@property (nonatomic, copy) NSString *teacherChat;
@property (nonatomic, copy) NSString *principalMail;
@property (nonatomic, copy) NSString *teacherGroup;
@property (nonatomic, copy) NSString *tutorInfo;
@property (nonatomic, copy) NSString *stuChat;

@end
