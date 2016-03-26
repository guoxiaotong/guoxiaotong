//
//  Singleton.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TongXunmodel.h"
#import "LoginModel.h"

@interface Singleton : NSObject

@property(nonatomic,strong)NSMutableArray *SingleMarry;
@property(nonatomic,assign)int a;

@property(nonatomic,strong)LoginModel *model;

+(id)shareUser;

@end
