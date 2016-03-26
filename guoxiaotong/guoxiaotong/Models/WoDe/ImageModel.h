//
//  ImageModel.h
//  guoxiaotong
//
//  Created by zxc on 16/3/22.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseModel.h"

@interface ImageModel : BaseModel

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSNumber *picId;
@property (nonatomic, copy) NSString *imageUrl;

@end
