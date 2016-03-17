//
//  LoadingView.m
//  GXTTest
//
//  Created by zxc on 16/3/8.
//  Copyright © 2016年 zxc. All rights reserved.
//

#import "LoadingView.h"
#import <UIView+Toast.h>

@implementation LoadingView

+ (void)showCenterActivity:(UIView *)view {
    [view makeToastActivity:CSToastPositionCenter];
}

+ (void)hideCenterActivity:(UIView *)view {
    [view hideToastActivity];
}

+ (void)showBottom:(UIView *)view messages:(NSArray<NSString *> *)messages {
    [self showBottom:view message: [messages componentsJoinedByString:@"\n"]];
}

+ (void)showBottom:(UIView *)view message:(NSString *)message {
    CSToastStyle *style = [CSToastManager sharedStyle];
    style.messageAlignment = NSTextAlignmentCenter;
    [view makeToast:message duration:2 position:CSToastPositionBottom style:style];
}

+ (void)showDownCenter:(UIView *)view messages:(NSArray *)messages {
    [self showDownCenter:view message:[messages componentsJoinedByString:@"\n"]];
}

+ (void)showDownCenter:(UIView *)view message:(NSString *)message {
    CSToastStyle *style = [CSToastManager sharedStyle];
    style.messageAlignment = NSTextAlignmentCenter;
    CGPoint point = CGPointMake(view.center.x, HEIGHT-200);
    [view makeToast:message duration:1 position:[NSValue valueWithCGPoint:point] style:style];
}
@end
