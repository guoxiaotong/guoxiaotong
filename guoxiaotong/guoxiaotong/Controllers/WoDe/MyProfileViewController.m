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
#import "CustomView.h"

@interface MyProfileViewController ()<UIScrollViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *birthTextField;
@property (strong, nonatomic) UIView *sexBackView;
@property (strong, nonatomic) UIButton *manButton;
@property (strong, nonatomic) UIButton *womanButton;
@property (strong, nonatomic) UILabel *sexLabel;
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UITextField *QQTextField;
@property (strong, nonatomic) UITextField *weChatTextField;
@property (strong, nonatomic) UITextField *emailTextField;
@property (strong, nonatomic) UIButton *submitButton;
@property (strong, nonatomic) UIFont *titleFont;
@property (strong, nonatomic) UIFont *textFieldFont;
@property (copy, nonatomic) NSString *gender;

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
    _titleFont = [UIFont systemFontOfSize:16.0];
    _textFieldFont = [UIFont systemFontOfSize:14.0];
    [self viewWithTitle:@"姓名" index:0];
    [self viewWithTitle:@"生日" index:1];
    [self viewWithTitle:@"性别" index:2];
    [self viewWithTitle:@"手机" index:3];
    [self viewWithTitle:@"QQ" index:4];
    [self viewWithTitle:@"微信" index:5];
    [self viewWithTitle:@"邮箱" index:6];
    
    _submitButton = [CustomView buttonWithTitle:@"提交" width:150 orginY:400];
    [_submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    self.submitButton.hidden = YES;
    [self.scrollView addSubview:_submitButton];
    if (self.submitButton.frame.origin.y+50 <HEIGHT) {
        self.scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    }
}

- (void)viewWithTitle:(NSString *)title index:(NSInteger)index {
    CGFloat width = 60;
    CGRect frame = CGRectMake(0, index*50, WIDTH, 50);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, width, 30)];
    titleLabel.font = _titleFont;
    titleLabel.text = title;
    [view addSubview:titleLabel];
    
    if (index == 2) {
        _sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(width+20, 10, 100, 30)];
        _sexLabel.font = _textFieldFont;
        [view addSubview:_sexLabel];
        
        _sexBackView = [[UIView alloc] initWithFrame:CGRectMake(width+20, 10, WIDTH-120, 30)];
        
        _manButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _manButton.frame = CGRectMake(0, 0, 100, 30);
        _manButton.backgroundColor = [UIColor clearColor];
        [_manButton setImage:[UIImage imageNamed:@"button_check_no"] forState:UIControlStateNormal];
        [_manButton setImage:[UIImage imageNamed:@"button_check_yes"] forState:UIControlStateHighlighted];
        //button图片的偏移量，距上左下右分别(5, 20, 5, 60)像素点
        _manButton.imageEdgeInsets = UIEdgeInsetsMake(5, 20, 5, 60);
        [_manButton setTitle:@"男" forState:UIControlStateNormal];
        //button标题的偏移量，这个偏移量是相对于图片的
        _manButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [_manButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _manButton.titleLabel.font = _textFieldFont;
        [_manButton addTarget:self action:@selector(manClick) forControlEvents:UIControlEventTouchUpInside];
        [_sexBackView addSubview:_manButton];
        
        _womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _womanButton.frame = CGRectMake(100, 0, 100, 30);
        _womanButton.backgroundColor = [UIColor clearColor];
        [_womanButton setImage:[UIImage imageNamed:@"button_check_no"] forState:UIControlStateNormal];
        [_womanButton setImage:[UIImage imageNamed:@"button_check_yes"] forState:UIControlStateHighlighted];
        //button图片的偏移量，距上左下右分别(5, 20, 5, 60)像素点
        _womanButton.imageEdgeInsets = UIEdgeInsetsMake(5, 20, 5, 60);
        [_womanButton setTitle:@"女" forState:UIControlStateNormal];
        //button标题的偏移量，这个偏移量是相对于图片的
        _womanButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [_womanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _womanButton.titleLabel.font = _textFieldFont;
        [_womanButton addTarget:self action:@selector(womanClick) forControlEvents:UIControlEventTouchUpInside];
        [_sexBackView addSubview:_womanButton];
        
        [view addSubview:_sexBackView];
        _sexBackView.hidden = YES;
        
    }else {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(width+20, 5, WIDTH-width-40, 40)];
        textField.borderStyle = UITextBorderStyleNone;
        textField.font = _textFieldFont;
        textField.delegate = self;
        textField.enabled = NO;
        [view addSubview:textField];
        switch (index) {
            case 0:
                _nameTextField = textField;
                break;
            case 1:
                _birthTextField = textField;
                break;
            case 2:
                break;
            case 3:
                textField.keyboardType = UIKeyboardTypeNumberPad;
                _phoneTextField = textField;
                break;
            case 4:
                textField.keyboardType = UIKeyboardTypeNumberPad;
                _QQTextField = textField;
                break;
            case 5:
                textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                _weChatTextField = textField;
                break;
            case 6:
                textField.keyboardType = UIKeyboardTypeEmailAddress;
                _emailTextField = textField;
                break;
            default:
                break;
        }
    }
    
    UILabel *border = [[UILabel alloc]initWithFrame:CGRectMake(0, 49.5, WIDTH, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:border];
    
    [self.scrollView addSubview:view];
    
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    UserService *service = [[UserService alloc] initWithView:self.view];
    [service getProfileWithCallBack:^(BOOL isSuccess, UserInfoModel *userInfo) {
        if (isSuccess) {
            weakSelf.nameTextField.text = userInfo.userName;
            weakSelf.birthTextField.text = userInfo.birthday;
            if ([userInfo.gender isEqualToString:@"0"]) {
                weakSelf.sexLabel.text = @"女";
            }else {
                weakSelf.sexLabel.text = @"男";
            }
            weakSelf.gender = userInfo.gender;
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
- (void)manClick {
    [self.manButton setImage:[UIImage imageNamed:@"button_check_yes"] forState:UIControlStateNormal];
    [self.womanButton setImage:[UIImage imageNamed:@"button_check_no"] forState:UIControlStateNormal];
    self.gender = @"1";
}
- (void)womanClick {
    [self.manButton setImage:[UIImage imageNamed:@"button_check_no"] forState:UIControlStateNormal];
    [self.womanButton setImage:[UIImage imageNamed:@"button_check_yes"] forState:UIControlStateNormal];
    self.gender = @"0";
}

- (void)submitClick {
    //修改用户信息
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    UserService *service = [[UserService alloc] initWithView:self.view];
    __weak typeof (*&self)weakSelf = self;
    
    NSDictionary *params = @{@"userId": shareInfo.userId, @"gender": _gender, @"phone": _phoneTextField.text, @"birthday": _birthTextField.text, @"qq": _QQTextField.text, @"wechat": _weChatTextField.text, @"email": _emailTextField.text};
    [service editProfileWithParams:params callBack:^(BOOL isSuccess) {
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
