//
//  BZRAddStudentViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BZRAddStudentViewController.h"
#import "CustomView.h"
#import "DatePicker.h"
#import "BZRManagerService.h"

@interface BZRAddStudentViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *birthTextField;
@property (strong, nonatomic) UIView *sexBackView;
@property (strong, nonatomic) UIButton *manButton;
@property (strong, nonatomic) UIButton *womanButton;
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UIFont *titleFont;
@property (strong, nonatomic) UIFont *textFieldFont;
@property (copy, nonatomic) NSString *gender;


@end

@implementation BZRAddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加学生";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

- (void)setUI {
    _titleFont = [UIFont systemFontOfSize:16.0];
    _textFieldFont = [UIFont systemFontOfSize:14.0];
    [self viewWithTitle:@"姓名" index:0];
    [self viewWithTitle:@"性别" index:1];
    [self viewWithTitle:@"生日" index:2];
    [self viewWithTitle:@"手机" index:3];
    
    UIButton *_submitButton = [CustomView buttonWithTitle:@"提交" width:150 orginY:400];
    [_submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitButton];
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
    
    if (index == 1) {
        
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
        [self manClick];
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
    }else {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(width+20, 5, WIDTH-width-40, 40)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.font = _textFieldFont;
        textField.delegate = self;
        [view addSubview:textField];
        switch (index) {
            case 0:
                _nameTextField = textField;
                break;
            case 1:
                break;
            case 2:
                _birthTextField = textField;
                break;
            case 3:
                textField.keyboardType = UIKeyboardTypeNumberPad;
                _phoneTextField = textField;
                break;
            default:
                break;
        }
    }
    UILabel *border = [[UILabel alloc]initWithFrame:CGRectMake(0, 49.5, WIDTH, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:border];
    
    [self.view addSubview:view];
}

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
    if ([_nameTextField isEmpty] || [_birthTextField isEmpty]) {
        [LoadingView showBottom:self.view messages:@[@"完善信息"]];
    }else {
        SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
        BZRManagerService *service = [[BZRManagerService alloc] initWithView:self.view];
        __weak typeof (*&self)weakSelf = self;
        NSDictionary *params = @{@"userId": shareInfo.userId, @"gender": _gender, @"phone": _phoneTextField.text, @"birthday": _birthTextField.text, @"userName": _nameTextField.text, @"classId": _roleInfo.classId};
        [service addStudent:params callBack:^(BOOL isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [LoadingView showBottom:weakSelf.view messages:@[@"添加成功"]];
        }];
    }
}

#pragma mark - TFdelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _birthTextField) {
        //
        [self.view endEditing:YES];
        __weak typeof (*&self)weakSelf = self;
        //弹出选择器//
        DatePicker *picker = [[DatePicker alloc] initDate:self.birthTextField.text];
        picker.dateCallBack = ^(NSString *dateString) {
            weakSelf.birthTextField.text = dateString;
        };
        return NO;
    }else {
        return YES;
    }
}

@end
