//
//  XZAddTeacherViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZAddTeacherViewController.h"
#import "ManagerService.h"

@interface XZAddTeacherViewController ()

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;

@end

@implementation XZAddTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加老师";
    [self setUI];
}

- (void)setUI {
    [self viewWithTitle:@"姓名：" textField:_nameTextField index:0];
    [self viewWithTitle:@"手机：" textField:_phoneTextField index:1];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake((WIDTH-120)/2, 200, 120, 30);
    sureButton.backgroundColor = [UIColor greenColor];
    [sureButton setTitle:@"确定添加" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
    
}

- (void)viewWithTitle:(NSString *)title textField:(UITextField *)textfield index:(NSInteger)index {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50*index, WIDTH, 50)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
    titleLabel.text = title;
    [view addSubview:titleLabel];
    
    textfield = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, WIDTH-140, 30)];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    [view addSubview:textfield];
    switch (index) {
        case 0:
            _nameTextField = textfield;
            break;
        case 1:
            _phoneTextField = textfield;
            break;
        default:
            break;
    }
    
    UILabel *border = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:border];
    
    [self.view addSubview:view];
}

- (void)sureClick {
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    __weak typeof (*&self)wewakSelf = self;
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"userId": shareInfo.userId, @"userName": self.nameTextField.text, @"loginName": self.phoneTextField.text};
    [service addTeacher:params callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [wewakSelf.navigationController popViewControllerAnimated:true];
        }else {
            NSLog(@"添加失败！");
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
