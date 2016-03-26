//
//  XuanZhePhonData.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/24.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XuanZhePhonData.h"

@implementation XuanZhePhonData

+(id)shareImage{

    static XuanZhePhonData *xzData=nil;
    if (xzData==nil) {
        xzData=[[XuanZhePhonData alloc]init];
    }

    return xzData;

}

@end
