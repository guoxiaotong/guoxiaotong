//
//  ClassModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/18.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"
#import "BZRModel.h"

@interface ClassModel : BaseModel

@property (nonatomic, assign) NSInteger classId;
@property (nonatomic, copy) NSString *classesName;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *schoolName;
@property (nonatomic, strong) NSNumber *schoolId;
@property (nonatomic, strong) BZRModel *bzrInfo;

@end
