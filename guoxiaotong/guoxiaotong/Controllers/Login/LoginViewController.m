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

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *userNameBorder;
@property (weak, nonatomic) IBOutlet UIView *passwordBorder;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    [self setUI];
}

- (void)setUI {
    [self.userNameTextField setTextFieldLeftPadding:@"textfield_left_user" forWidth:30];
    self.userNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.userNameTextField becomeFirstResponder];
    [self.passwordTextField setTextFieldLeftPadding:@"textfield_left_pwd" forWidth:30];
    self.passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;

}

- (IBAction)login:(id)sender {
    __weak typeof (*&self)weakSelf=self;
    UserService *service = [[UserService alloc] initWithView:self.view];
    [service loginWithName:self.userNameTextField.text password:self.passwordTextField.text callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            GXTTabBarController *tabVC = [[GXTTabBarController alloc] init];
            weakSelf.view.window.rootViewController = tabVC;
        }
    }];
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
