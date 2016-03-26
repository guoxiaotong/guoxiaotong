//
//  TrendModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/22.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"
#import "ImageModel.h"
#import "UserInfoModel.h"

@interface TrendModel : BaseModel

@property (nonatomic, copy) NSString *praise;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSNumber *readed;
@property (nonatomic, copy) NSString *dynamicType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSNumber *dynamicId;
@property (nonatomic, copy) NSString *sendTime;
@property (nonatomic, strong) UserInfoModel *userInfo;
@property (nonatomic, strong) NSArray<ImageModel *> *imageList;

@end
