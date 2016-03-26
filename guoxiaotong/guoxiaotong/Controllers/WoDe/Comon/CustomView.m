//
//  CustomView.m
//  guoxiaotong
//
//  Created by zxc on 16/3/22.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

+ (UIButton *)buttonWithTitle:(NSString *)title width:(CGFloat)width orginY:(CGFloat)y {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((WIDTH-width)/2, y, width, 30);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:BUTTON_TEXTCOLOR_NORMAL forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:146/225.0 green:230/225.0 blue:73/225.0 alpha:1.0];
    button.layer.cornerRadius = 5;
    
    return button;
}

@end
