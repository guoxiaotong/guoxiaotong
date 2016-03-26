//
//  Singleton.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+(id)shareUser{
    
    static Singleton *singLe=nil;
    
    if (singLe==nil) {
        singLe=[[Singleton alloc]init];
    }
    return singLe;

}

@end
