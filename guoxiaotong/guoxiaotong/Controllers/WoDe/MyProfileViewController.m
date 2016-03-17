//
//  MyProfileViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "MyProfileViewController.h"
#import "DatePicker.h"
#import "UserService.h"
#import "SingleUserInfo.h"

@interface MyProfileViewController ()<UIScrollViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthTextField;
@property (weak, nonatomic) IBOutlet UIView *sexBackView;
@property (weak, nonatomic) IBOutlet UIButton *manButton;
@property (weak, nonatomic) IBOutlet UIButton *womanButton;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *QQTextField;
@property (weak, nonatomic) IBOutlet UITextField *weChatTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (assign, nonatomic) BOOL isMan;

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    self.navigationItem.title = @"个人资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    [self setUI];
    [self loadData];
}

- (void)setUI {
    //代码布局
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    UserService *service = [[UserService alloc] initWithView:self.view];
    [service getProfileWithCallBack:^(BOOL isSuccess, UserInfoModel *userInfo) {
        if (isSuccess) {
            weakSelf.nameTextField.text = userInfo.userName;
            weakSelf.birthTextField.text = userInfo.birthday;
            if (userInfo.gender == 0) {
                weakSelf.sexLabel.text = @"女";
                weakSelf.isMan = NO;
            }else {
                weakSelf.sexLabel.text = @"男";
                weakSelf.isMan = YES;
            }
            weakSelf.phoneTextField.text = userInfo.phone;
            weakSelf.QQTextField.text = userInfo.qq;
            weakSelf.weChatTextField.text = userInfo.weChat;
            weakSelf.emailTextField.text = userInfo.email;
        }
    }];
}

- (void)changeState:(UITextField *)textField placeHolder:(NSString *)placeholder{
    [textField setTextFieldLeftPaddingforWidth:15];
    textField.enabled = YES;
    textField.layer.borderWidth = 0.25;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor
    ;
    textField.layer.cornerRadius = 5;
    textField.placeholder = placeholder;
}

- (void)edit {
    self.sexBackView.hidden = NO;
    self.sexLabel.hidden = YES;
    self.submitButton.hidden = NO;
    self.navigationItem.rightBarButtonItem = nil;
    [self changeState:self.nameTextField placeHolder:@"请输入姓名"];
    self.birthTextField.enabled = YES;
    [self changeState:self.phoneTextField placeHolder:@"请输入手机号码"];
    [self changeState:self.QQTextField placeHolder:@"请输入QQ号码"];
    [self changeState:self.weChatTextField placeHolder:@"请输入微信号码"];
    [self changeState:self.emailTextField placeHolder:@"请输入邮箱地址"];
}


#pragma mark - IBAction
- (IBAction)manClick:(id)sender {
    [self.manButton setBackgroundImage:[UIImage imageNamed:@"button_check_yes"] forState:UIControlStateNormal];
    [self.womanButton setBackgroundImage:[UIImage imageNamed:@"button_check_no"] forState:UIControlStateNormal];
    self.isMan = YES;
}
- (IBAction)womanClick:(id)sender {
    [self.manButton setBackgroundImage:[UIImage imageNamed:@"button_check_no"] forState:UIControlStateNormal];
    [self.womanButton setBackgroundImage:[UIImage imageNamed:@"button_check_yes"] forState:UIControlStateNormal];
    self.isMan = NO;
}

- (IBAction)submitClick:(id)sender {
    //修改用户信息
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    UserService *service = [[UserService alloc] initWithView:self.view];
    NSString *gender;
    if (self.isMan) {
        gender = @"1";
    }else {
        gender = @"0";
    }
    NSString *dataFormatter = [NSString stringWithFormat:@"userId=%@&gender=%@&phone=%@&birthday=%@&qq=%@&wechat=%@&email=%@", shareInfo.userId, gender, self.phoneTextField.text, self.birthTextField.text, self.QQTextField.text, self.weChatTextField.text, self.emailTextField.text];
    __weak typeof (*&self)weakSelf = self;
    
    [service editProfileWithData:dataFormatter callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.birthTextField) {
        __weak typeof (*&self)weakSelf = self;
        //弹出选择器//
        DatePicker *picker = [[DatePicker alloc] initDate:self.birthTextField.text];
        picker.dateCallBack = ^(NSString *dateString) {
            weakSelf.birthTextField.text = dateString;
        };
        NSLog(@"选择时间");
        return false;
    }else {
        return true;
    }
}


@end
