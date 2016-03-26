//
//  EditPassWordViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "EditPassWordViewController.h"
#import "TextFieldWithButton.h"
#import "CustomView.h"
#import "UserService.h"

@interface EditPassWordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) TextFieldWithButton *oldPasswordTextField;
@property (nonatomic, strong) TextFieldWithButton *nowPasswordTextField;
@property (nonatomic, strong) TextFieldWithButton *nowPasswordTextFieldConfim;

@end

@implementation EditPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改密码";
    [self setUI];
}

- (void)setUI {
    
    [self viewWithTitle:@"原密码" placeHolder:@"请输入原密码" index:0];
    [self viewWithTitle:@"新密码" placeHolder:@"请输入新密码" index:1];
    [self viewWithTitle:@"确认密码" placeHolder:@"请再次输入新密码" index:2];
    
    UIButton *sureButton = [CustomView buttonWithTitle:@"确定" width:100 orginY:300];
    [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
    
}

- (void)viewWithTitle:(NSString *)title placeHolder:(NSString *)placeholder index:(NSInteger)index {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 80*index, WIDTH, 80)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, WIDTH-40, 40)];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    titleLabel.text = title;
    [view addSubview:titleLabel];
    
    TextFieldWithButton *textField = [[TextFieldWithButton alloc] initEyeButtonWithFrame:CGRectMake(5, 40, WIDTH-10, 40)];
    textField.placeholder = placeholder;
    textField.delegate = self;
    [view addSubview:textField];
    switch (index) {
        case 0:
            _oldPasswordTextField = textField;
            break;
        case 1:
            _nowPasswordTextField = textField;
            break;
        case 2:
            _nowPasswordTextFieldConfim = textField;
            break;
            
        default:
            break;
    }
    
    [self.view addSubview:view];
}

- (void)sureClick {
    if ([_oldPasswordTextField isEmpty] || [_nowPasswordTextField isEmpty] || [_nowPasswordTextFieldConfim isEmpty]) {
        [LoadingView showBottom:self.view messages:@[@"密码不能为空"]];
    }else if ([_nowPasswordTextField.text isEqualToString:_nowPasswordTextFieldConfim.text]) {
        SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
        UserService *service = [[UserService alloc] initWithView:self.view];
        NSDictionary *params = @{@"username": shareInfo.loginName, @"password": _oldPasswordTextField.text, @"newpassword": _nowPasswordTextField.text};
        __weak typeof (*&self)weakSelf = self;
        [service editPassword:params callBack:^(NSInteger code, NSString *msg) {
            [LoadingView showBottom:weakSelf.view messages:@[msg]];
            if (code == 0) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    }else {
        [LoadingView showBottom:self.view messages:@[@"两次密码输入不一致"]];
    }
}


@end
