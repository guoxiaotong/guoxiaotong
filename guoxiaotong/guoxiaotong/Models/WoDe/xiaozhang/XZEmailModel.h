//
//  XZEmailModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/18.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"
#import "UserInfoModel.h"

@interface XZEmailModel : BaseModel

@property (nonatomic, strong) UserInfoModel *userInfo;
@property (nonatomic, assign) NSInteger readed;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *dynamicType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger dynamicId;
@property (nonatomic, copy) NSString *sendTime;


@end
