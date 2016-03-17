//
//  UITextField+CustomStyle.m
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "UITextField+CustomStyle.h"

@implementation UITextField (CustomStyle)

-(void)setTextFieldLeftPaddingforWidth:(CGFloat)leftWidth {
    CGRect frame = self.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

- (void)setTextFieldLeftPadding:(NSString *)imageName forWidth:(CGFloat)leftWidth {
    CGRect frame = self.frame;
    frame.size.width = leftWidth;
    frame.origin.x += 10;
    UIImageView *leftview = [[UIImageView alloc] initWithFrame:frame];
    leftview.image = [UIImage imageNamed:imageName];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

@end
