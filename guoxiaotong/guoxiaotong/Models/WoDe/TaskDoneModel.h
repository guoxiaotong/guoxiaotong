//
//  TaskDoneModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/24.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"

@interface TaskDoneModel : BaseModel

@property (nonatomic, copy) NSString *reward;
@property (nonatomic, copy) NSString *roleId;
@property (nonatomic, copy) NSString *taskId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *taskName;
@property (nonatomic, copy) NSString *issueTime;
@property (nonatomic, copy) NSString *taskDescription;


@end
