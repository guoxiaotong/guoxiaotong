//
//  LoadingView.h
//  GXTTest
//
//  Created by zxc on 16/3/8.
//  Copyright © 2016年 zxc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoadingView : NSObject

+ (void)showCenterActivity:(UIView *)view;
+ (void)hideCenterActivity:(UIView *)view;

+ (void)showBottom:(UIView *)view messages:(NSArray *)messages;
+ (void)showDownCenter:(UIView *)view messages:(NSArray *)messages;

@end
