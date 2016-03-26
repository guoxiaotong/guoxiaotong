//
//  LoadAlassetData.h
//  PhotoChoose
//
//  Created by oyzk on 15/7/3.
//  Copyright (c) 2015年 lijunxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
typedef void(^returnImageBlock)(ALAsset*result);
@interface LoadAlassetData : NSObject

+(instancetype)shareManager;//刷新数据
-(void)LoadAlAsset;
@property(nonatomic,copy)returnImageBlock getImage;
@property(nonatomic,strong)NSMutableArray*dataArray;

@end
