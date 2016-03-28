//
//  UITextField+CustomStyle.m
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "UITextField+CustomStyle.h"
#import "Tools.h"

@implementation UITextField (CustomStyle)

-(void)setTextFieldLeftPaddingforWidth:(CGFloat)leftWidth {
    CGRect frame = self.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

- (void)setTextFieldLeftPadding:(NSString *)imageName {
    
    self.font = [UIFont systemFontOfSize:14.0];
    
    self.borderStyle = UITextBorderStyleNone;
    CGRect frame = self.frame;
    frame.size.width = frame.size.height+20;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    CGFloat wid = [Tools getSizeFromImage:imageName].width;
    CGFloat hig = [Tools getSizeFromImage:imageName].height;
    frame.origin.x = (frame.size.width-wid)/2;
    frame.origin.y = (frame.size.height-hig)/2+5;
    frame.size.width = wid;
    frame.size.height = hig;
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:frame];
    imageV.image = [UIImage imageNamed:imageName];
    [view addSubview:imageV];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = view;
}

- (void)setTextFieldRightPaddingList {
    
    self.font = [UIFont systemFontOfSize:14.0];
    
    self.borderStyle = UITextBorderStyleRoundedRect;
    CGRect frame = self.frame;
    frame.size.width = frame.size.height+20;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    CGFloat wid = [Tools getSizeFromImage:@"section_closed"].width;
    CGFloat hig = [Tools getSizeFromImage:@"section_closed"].height;
    frame.origin.x = (frame.size.width-wid)/2;
    frame.origin.y = (frame.size.height-hig)/2;
    frame.size.width = wid;
    frame.size.height = hig;
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:frame];
    imageV.image = [UIImage imageNamed:@"section_closed"];
    [view addSubview:imageV];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = view;
}

- (void)setTextFieldRightPaddingSearch {
    self.font = [UIFont systemFontOfSize:14.0];
    
    self.borderStyle = UITextBorderStyleRoundedRect;
    CGRect frame = self.frame;
    frame.size.width = frame.size.height+20;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    CGFloat wid = [Tools getSizeFromImage:@"search_icon"].width;
    CGFloat hig = [Tools getSizeFromImage:@"search_icon"].height;
    frame.origin.x = (frame.size.width-wid)/2;
    frame.origin.y = (frame.size.height-hig)/2;
    frame.size.width = wid;
    frame.size.height = hig;
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:frame];
    imageV.image = [UIImage imageNamed:@"search_icon"];
    [view addSubview:imageV];
    self.rightViewMode = UITextFieldViewModeAlways;
    self.rightView = view;
}

- (BOOL)isEmpty {
    if (!self.text || [self.text isEqualToString:@""]) {
        return YES;
    }else {
        return NO;
    }
}

@end
