//
//  BZRAddJianhurenViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/21.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BZRAddJianhurenViewController.h"
#import "BZRJianhurenModel.h"
#import "BZRManagerService.h"
#import "ListPickerView.h"
#import "BasicService.h"
#import "RelationModel.h"
#import "CustomView.h"

@interface BZRAddJianhurenViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *jianhurenTextField;
@property (nonatomic, strong) UITextField *relationTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) NSNumber *relationId;

@end

@implementation BZRAddJianhurenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加监护人";
    [self viewWithTitle:@"学生姓名：" index:0];
    [self viewWithTitle:@"监护人姓名：" index:1];
    [self viewWithTitle:@"与学生关系：" index:2];
    [self viewWithTitle:@"手机：" index:3];
    
    _nameTextField.text = _jianhurenInfo.studentName;
    _nameTextField.enabled = NO;
    
    UIButton *sureButton = [ CustomView buttonWithTitle:@"确定添加" width:120 orginY:300];
    [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];
    
}

- (void)viewWithTitle:(NSString *)title index:(NSInteger)index {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50*index, WIDTH, 50)];
    
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
            _jianhurenTextField = textField;
            break;
        case 2:
            _relationTextField = textField;
            break;
        case 3:
            textField.keyboardType = UIKeyboardTypeNumberPad;
            _phoneTextField = textField;
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
    if (self.relationId) {
        [self addJianhuren];
    }else {
        //提示
    }
}

- (void)addJianhuren {
    __weak typeof (*&self)weakSelf = self;
    BZRManagerService *service = [[BZRManagerService alloc] initWithView:self.view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"userName": self.jianhurenTextField.text, @"studentId": _jianhurenInfo.studentId, @"loginName": self.phoneTextField.text, @"userId": shareInfo.userId, @"relationId": self.relationId};
    [service addJianhuren:params callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:true];
        }
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _relationTextField) {
        //xuanze
        [self.view endEditing:YES];
        __weak typeof (*&self)weakSelf = self;
        BasicService *service = [[BasicService alloc] initWithView:self.view];
        [service getRelationListCallBack:^(BOOL isSuccess, NSArray *relationList) {
            ListPickerView *listPicker = [[ListPickerView alloc] init];
            [listPicker.dataList addObjectsFromArray:relationList];
            [listPicker show];
            listPicker.SureCallBack = ^(id model) {
                RelationModel *relationModel = model;
                weakSelf.relationId = relationModel.relationId;
                weakSelf.relationTextField.text = relationModel.typeName;
            };
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
