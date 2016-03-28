//
//  HttpDataModel.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpDataModel : NSObject

@property(nonatomic,strong)NSMutableArray *marry;

typedef NSDictionary*(^MyBlock3)();

+(void)urlhead:(NSString *)headStr Andurlbody:(NSDictionary *)bodyDict blk:(MyBlock3)blkc;

@end
