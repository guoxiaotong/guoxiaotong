//
//  RegisterViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/14.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "RegisterViewController.h"
#import "TextFieldWithButton.h"
#import "CustomView.h"


@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UITextField *nickNameTextField;
@property (nonatomic, strong) TextFieldWithButton *passwordTextField;
@property (nonatomic, strong) UIButton *codeButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    [self setUI];
    if (HEIGHT > 400) {
        self.scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    }else {
        self.scrollView.contentSize = CGSizeMake(WIDTH, 400);
    }
}

- (void)setUI {
    [self viewWithTitle:@"手机" placeHolder:@"请输入手机号码" index:0];
    [self viewWithTitle:@"验证码" placeHolder:@"请输入验证码" index:1];
    [self viewWithTitle:@"用户昵称" placeHolder:@"请输入用户昵称" index:2];
    [self viewWithTitle:@"密码" placeHolder:@"请输入密码" index:3];
    UIButton *submitButton = [CustomView buttonWithTitle:@"注册" width:100 orginY:350];
    [submitButton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:submitButton];
    
}

- (void)getCode:(UIButton *)btn {
    
}

- (void)registerClick {
    
}


- (void)viewWithTitle:(NSString *)title placeHolder:(NSString *)placeholder index:(NSInteger)index {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 80*index, WIDTH, 80)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, WIDTH-40, 40)];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    titleLabel.text = title;
    [view addSubview:titleLabel];
    
    UITextField *textField;
    switch (index) {
        case 0:
            textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 40, WIDTH-120, 40)];
            _phoneTextField = textField;
            _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _codeButton.frame = CGRectMake(CGRectGetMaxX(_phoneTextField.frame)+5, 40, 100, 40);
            _codeButton.backgroundColor = [UIColor colorWithRed:146/225.0 green:230/225.0 blue:73/225.0 alpha:1.0];
            _codeButton.layer.cornerRadius = 5;
            _codeButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [_codeButton setTitleColor:BUTTON_TEXTCOLOR_NORMAL forState:UIControlStateNormal];
            [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_codeButton addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:_codeButton];
            break;
        case 1:
            textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 40, WIDTH-10, 40)];
            _codeTextField = textField;
            break;
        case 2:
            textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 40, WIDTH-10, 40)];
            _nickNameTextField = textField;
            break;
        case 3:
            textField = [[TextFieldWithButton alloc] initEyeButtonWithFrame:CGRectMake(5, 40, WIDTH-10, 40)];
            _passwordTextField = (TextFieldWithButton *)textField;
        default:
            break;
    }
    textField.placeholder = placeholder;
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [view addSubview:textField];

    [self.scrollView addSubview:view];
}

@end
