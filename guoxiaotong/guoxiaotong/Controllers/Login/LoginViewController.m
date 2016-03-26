//
//  LoginViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "LoginViewController.h"
#import "GXTTabBarController.h"
#import "UserService.h"
#import "RetreveViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *userNameTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIView *userNameBorder;
@property (strong, nonatomic) UIView *passwordBorder;
@property (strong, nonatomic) UIFont *buttonFont;
@property (assign, nonatomic) CGFloat height;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"登录";
    _buttonFont = [UIFont systemFontOfSize:14.0];
    [self setUI];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *userName = [def objectForKey:@"loginName"];
    NSString *password = [def objectForKey:@"password"];
    _userNameTextField.text = userName;
    _passwordTextField.text = password;
    if (_height > HEIGHT) {
        self.scrollView.contentSize = CGSizeMake(WIDTH, _height);
    }else {
        self.scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    }
}

- (void)setUI {
    CGRect imageFrame = CGRectMake((WIDTH-100)/2, 50, 100, 100);
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:imageFrame];
    imageV.image = [UIImage imageNamed:@"login_logo"];
    [self.scrollView addSubview:imageV];
    
    CGRect frame = CGRectMake(10, 200, WIDTH-20, 40);
    
    
    _userNameBorder = [[UIView alloc] initWithFrame:frame];
    _userNameBorder.backgroundColor = [UIColor whiteColor];
    _userNameBorder.layer.borderWidth = 1.0;
    [self.scrollView addSubview:_userNameBorder];

    _userNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, frame.origin.y-5, WIDTH, frame.size.height)];
    _userNameTextField.backgroundColor = [UIColor whiteColor];
    _userNameTextField.delegate = self;
    _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.scrollView addSubview:_userNameTextField];
    
    _passwordBorder = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+10+frame.size.height, frame.size.width, frame.size.height)];
    _passwordBorder.backgroundColor = [UIColor whiteColor];
    _passwordBorder.layer.borderWidth = 1.0;
    [self.scrollView addSubview:_passwordBorder];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, _passwordBorder.frame.origin.y-5, WIDTH, frame.size.height)];
    _passwordTextField.backgroundColor = [UIColor whiteColor];
    _passwordTextField.delegate = self;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.secureTextEntry = YES;
    [self.scrollView addSubview:_passwordTextField];
    
    [_userNameTextField setTextFieldLeftPadding:@"account"];
    _userNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [_userNameTextField becomeFirstResponder];
    [_passwordTextField setTextFieldLeftPadding:@"password"];
    _passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.frame = CGRectMake(WIDTH-120, CGRectGetMaxY(_passwordBorder.frame)+5, 100, 30);
    forgetButton.backgroundColor = [UIColor whiteColor];
    [forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetButton.titleLabel.font = _buttonFont;
    [forgetButton setTitleColor:BUTTON_TEXTCOLOR_NORMAL forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:forgetButton];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(0, CGRectGetMaxY(_passwordBorder.frame)+100, WIDTH, 40);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = _buttonFont;
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[self imageWithColor:DEFAULT_NAVIGATIONBAR_COLOR] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[self imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:loginButton];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(0, CGRectGetMaxY(loginButton.frame)+5, WIDTH, 30);
    registerButton.backgroundColor = [UIColor whiteColor];
    [registerButton setTitle:@"没有账户？注册" forState:UIControlStateNormal];
    registerButton.titleLabel.font = _buttonFont;
    [registerButton setTitleColor:BUTTON_TEXTCOLOR_NORMAL forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:registerButton];
    _height = registerButton.frame.origin.y;
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)forgetClick {
    RetreveViewController *retreveVC = [[RetreveViewController alloc] init];
    [self.navigationController pushViewController:retreveVC animated:YES];
}

- (void)login {
    if ([self.userNameTextField.text isEqualToString:@""]) {
        [LoadingView showBottom:self.view messages:@[@"账户不能为空"]];
    }else {
        __weak typeof (*&self)weakSelf=self;
        UserService *service = [[UserService alloc] initWithView:self.view];
        [service loginWithName:self.userNameTextField.text password:self.passwordTextField.text callBack:^(BOOL isSuccess, NSString *msg) {
            if (isSuccess) {
                GXTTabBarController *tabVC = [[GXTTabBarController alloc] init];
                weakSelf.view.window.rootViewController = tabVC;
            }
        }];
    }
}

- (void)registerClick {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark - TextfieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.userNameTextField) {
        self.userNameBorder.layer.borderColor = [UIColor blueColor].CGColor;
        self.passwordBorder.layer.borderColor = [UIColor grayColor].CGColor;
    }else {
        self.userNameBorder.layer.borderColor = [UIColor grayColor].CGColor;
        self.passwordBorder.layer.borderColor = [UIColor blueColor].CGColor;
    }
}

@end
