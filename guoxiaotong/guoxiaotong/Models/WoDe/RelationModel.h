//
//  RelationModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"

@interface RelationModel : BaseModel

@property (nonatomic, strong) NSNumber *relationId;
@property (nonatomic, copy) NSString *sysType;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, strong) NSNumber *priority;

@end
