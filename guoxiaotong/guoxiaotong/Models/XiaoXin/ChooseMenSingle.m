//
//  ChooseMenSingle.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/30.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ChooseMenSingle.h"

@implementation ChooseMenSingle

+(id)shareChooseMen{
    
    static ChooseMenSingle *chooes=nil;
    
    if (chooes==nil) {
        chooes=[[ChooseMenSingle alloc]init];
    }
    return chooes;
    
}


@end
