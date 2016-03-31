//
//  JZAddMemberViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "JZAddMemberViewController.h"
#import "CustomView.h"
#import "BasicService.h"
#import "RelationModel.h"
#import "ListPickerView.h"
#import "JZManagerService.h"

@interface JZAddMemberViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *relationTextField;
@property (nonatomic, strong) ListPickerView *listPicker;
@property (nonatomic, strong) NSNumber *relationId;

@end

@implementation JZAddMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加家庭成员";
    [self setUI];
}

- (void)setUI {
    self.header.imageView.image = [UIImage imageNamed:@"manager_role_jiazhang_pic"];
    
    [self viewWithTitle:@"姓名：" index:0];
    [self viewWithTitle:@"手机号码：" index:1];
    [self viewWithTitle:@"关系：" index:2];
    
    _nameTextField.placeholder = @"请输入姓名";
    _phoneTextField.placeholder = @"请输入手机号码";
    _relationTextField.placeholder = @"请选择与孩子的关系";
    
    UIButton *sureButton = [CustomView buttonWithTitle:@"确定添加" width:150 orginY:400];
    [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
}

- (void)viewWithTitle:(NSString *)title index:(NSInteger)index {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50*index+150, WIDTH, 50)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    titleLabel.text = title;
    [view addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(120, 10, WIDTH-140, 30)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.delegate = self;
    [view addSubview:textField];
    switch (index) {
        case 0:
            _nameTextField = textField;
            break;
        case 1:
            _phoneTextField = textField;
            break;
        case 2:
            _relationTextField = textField;
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
    if ([_nameTextField isEmpty] || [_phoneTextField isEmpty] || [_relationTextField isEmpty]) {
        [LoadingView showBottom:self.view messages:@[@"完善资料"]];
    }else {
        //
        SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSDictionary *dict = @{@"userName": _nameTextField.text, @"studentId": _roleInfo.studentId, @"loginName": _phoneTextField.text, @"relationId": _relationId, @"userId": shareInfo.userId};
//        [params setValuesForKeysWithDictionary:dict];
        __weak typeof (*&self)weakSelf = self;
        JZManagerService *service = [[JZManagerService alloc] initWithView:self.view];
        [service addMember:dict callBack:^(NSInteger code, NSString *msg) {
            [LoadingView showBottom:weakSelf.view messages:@[msg]];
            if (code == 0) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _relationTextField) {
        //
        if (!_listPicker) {
            _listPicker = [[ListPickerView alloc] init];
        }
        BasicService *service = [[BasicService alloc] initWithView:self.view];
        __weak typeof (*&self)weakSelf = self;
        [service getRelationListCallBack:^(BOOL isSuccess, NSArray *relationList) {
            if (isSuccess) {
                [weakSelf.listPicker.dataList addObjectsFromArray:relationList];
                [weakSelf.listPicker show];
                weakSelf.listPicker.SureCallBack = ^(id model) {
                    RelationModel *relationModel = model;
                    weakSelf.relationTextField.text = relationModel.typeName;
                    weakSelf.relationId = relationModel.relationId;
                };
            }
        }];

        return NO;
    }else {
        return YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
