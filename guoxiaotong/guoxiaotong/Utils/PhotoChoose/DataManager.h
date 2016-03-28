//
//  DataManager.h
//  PhotoChoose
//
//  Created by oyzk on 15/7/2.
//  Copyright (c) 2015年 lijunxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+(id)shareManager;
@property(nonatomic,strong)NSMutableArray*dataArr;
@property(nonatomic,strong)NSMutableArray*imageArr;
+(void)addDataArr;
@end

