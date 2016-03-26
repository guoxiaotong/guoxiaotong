//
//  ContectRoleModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/21.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"
#import "ContectMemberModel.h"

@interface ContectRoleModel : BaseModel

@property (nonatomic, copy) NSString *issueTime;
@property (nonatomic, copy) NSString *memo;
@property (nonatomic, copy) NSString *roleName;
@property (nonatomic, copy) NSString *roleType;
@property (nonatomic, copy) NSString *roleId;
@property (nonatomic, strong) NSArray<ContectMemberModel *> *memberList;
@property (nonatomic, assign) BOOL open;

@end
