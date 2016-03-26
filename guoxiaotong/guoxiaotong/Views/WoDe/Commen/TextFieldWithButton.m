//
//  TextFieldWithButton.m
//  guoxiaotong
//
//  Created by zxc on 16/3/25.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "TextFieldWithButton.h"
#import "Tools.h"

@interface TextFieldWithButton()

@property (nonatomic, assign) BOOL on;
@property (nonatomic, strong) UIButton *button;

@end

@implementation TextFieldWithButton

- (instancetype)initSerachButtonWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:14.0];
        
        self.borderStyle = UITextBorderStyleRoundedRect;
        CGRect frame = self.frame;
        frame.size.width = frame.size.height+20;
        UIView *view = [[UIView alloc] initWithFrame:frame];
        CGFloat wid = [Tools getSizeFromImage:@"search_icon"].width/2;
        CGFloat hig = [Tools getSizeFromImage:@"search_icon"].height/2;
        frame.origin.x = (frame.size.width-wid)/2;
        frame.origin.y = (frame.size.height-hig)/2;
        frame.size.width = wid;
        frame.size.height = hig;
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = frame;
        [_button setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_button];
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = view;
    }
    return self;
}

- (instancetype)initEyeButtonWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:14.0];
        
        self.borderStyle = UITextBorderStyleRoundedRect;
        CGRect frame = self.frame;
        frame.size.width = frame.size.height+20;
        UIView *view = [[UIView alloc] initWithFrame:frame];
        CGFloat wid = [Tools getSizeFromImage:@"isshow_off"].width/2;
        CGFloat hig = [Tools getSizeFromImage:@"isshow_off"].height/2;
        frame.origin.x = (frame.size.width-wid)/2;
        frame.origin.y = (frame.size.height-hig)/2;
        frame.size.width = wid;
        frame.size.height = hig;
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = frame;
        [_button setImage:[UIImage imageNamed:@"isshow_off"] forState:UIControlStateNormal];
        _on = NO;
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:_button];
        self.secureTextEntry = YES;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = view;
    }
    return self;
}

- (void)buttonClick {
    if (_buttonCallBack) {
        _buttonCallBack();
    }else {
        //
        _on = !self.on;
        if (_on) {
            [_button setImage:[UIImage imageNamed:@"isshow_on"] forState:UIControlStateNormal];
            self.secureTextEntry = NO;
        }else {
            [_button setImage:[UIImage imageNamed:@"isshow_off"] forState:UIControlStateNormal];
            self.secureTextEntry = YES;
        }
    }
}

@end
