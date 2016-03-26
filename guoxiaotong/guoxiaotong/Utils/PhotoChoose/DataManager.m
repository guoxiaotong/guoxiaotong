//
//  DataManager.m
//  PhotoChoose
//
//  Created by lijunxiang on 15/7/2.
//  Copyright (c) 2015年 lijunxiang. All rights reserved.
//

#import "DataManager.h"
static DataManager*manager=nil;
@implementation DataManager
 
+(id)shareManager{
    static  dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[DataManager alloc]init];
    });
    return manager;
}

-(id)init{
    if (self=[super init]) {
        
        self.dataArr=[NSMutableArray arrayWithCapacity:0];
        self.imageArr=[NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
+(void)addDataArr{
    
    
}
@end
