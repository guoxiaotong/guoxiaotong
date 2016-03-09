//
//  LoadingView.m
//  GXTTest
//
//  Created by zxc on 16/3/8.
//  Copyright © 2016年 zxc. All rights reserved.
//

#import "LoadingView.h"
#import <MBProgressHUD.h>

@implementation LoadingView

+ (void)showOnView:(UIView *)view {
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)hiddenForView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
