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

+ (void)showOnView:(UIView *)view;
+ (void)hiddenForView:(UIView *)view;

@end
