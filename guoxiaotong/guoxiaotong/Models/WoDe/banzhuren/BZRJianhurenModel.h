//
//  BZRJianhurenModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"

@interface BZRJianhurenModel : BaseModel

@property (nonatomic, strong) NSNumber *parentId;
@property (nonatomic, strong) NSNumber *relationId;
@property (nonatomic, copy) NSString *parentName;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *relationName;
@property (nonatomic, strong) NSNumber *studentId;
@property (nonatomic, copy) NSString *studentName;
@property (nonatomic, copy) NSString *picPath;
@property (nonatomic, strong) NSNumber *classId;

@end
