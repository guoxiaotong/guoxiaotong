//
//  EditNickNameView.m
//  guoxiaotong
//
//  Created by zxc on 16/3/24.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "EditNickNameView.h"

@interface EditNickNameView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) CGFloat topHeight;

@end

@implementation EditNickNameView

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:_textField];
        self.frame = [UIScreen mainScreen].bounds;
        UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [backView addGestureRecognizer:tap];
        
        UIFont *font = [UIFont systemFontOfSize:15.0];
        CGFloat height = 100;
        CGFloat wid = WIDTH-120;
        _topHeight = (HEIGHT-height)/2;
        _view = [[UIView alloc] initWithFrame:CGRectMake((WIDTH-wid)/2, _topHeight, wid, height)];
        _view.clipsToBounds = YES;
        _view.layer.cornerRadius = 5;
        _view.backgroundColor = [UIColor whiteColor];
        
        UILabel *signLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wid, 30)];
        signLabel.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
        signLabel.text = @"  输入昵称（限5个字符以内）";
        signLabel.font = font;
        [_view addSubview:signLabel];
        
        UILabel *lin1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, wid, 0.5)];
        lin1.backgroundColor = [UIColor lightGrayColor];
        [_view addSubview:lin1];
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 30.5, wid-40, 30)];
        _textField.delegate = self;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.font = font;
        [_view addSubview:_textField];
        
        UILabel *lin2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 60.5, wid, 0.5)];
        lin2.backgroundColor = [UIColor lightGrayColor];
        [_view addSubview:lin2];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(wid-100, 61, 80, 30);
        [_button setTitle:@"确定" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.titleLabel.font = font;
        _button.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
        _button.clipsToBounds = YES;
        _button.layer.cornerRadius = 5;
        [_button addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [_view addSubview:_button];
        
        [self addSubview:backView];
        [self addSubview:_view];
        [self show];
    }
    return self;
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hide {
    [self removeFromSuperview];
}

- (void)sureClick {
    if (_sureCallBack) {
        _sureCallBack(_textField.text);
        [self hide];
    }
}

- (void)textFieldEditChanged:(NSNotification *)noti {
    UITextField *textField = noti.object;
    NSString *toBeString = textField.text;
    NSString *lang = self.textInputMode.primaryLanguage;//键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRang = [textField markedTextRange];
        if (!selectedRang) {
            if (toBeString.length > 5) {
                textField.text = [toBeString substringToIndex:5];
            }
        }
    }else {
        if (toBeString.length > 5) {
            textField.text = [toBeString substringToIndex:5];
        }
        else {
            
        }
    }
}

@end
