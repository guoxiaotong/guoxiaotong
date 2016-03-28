//
//  AddChildViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "AddChildViewController.h"
#import "CustomView.h"
#import "ListPickerView.h"
#import "BasicService.h"
#import "SchoolModel.h"
#import "GradeModel.h"
#import "RelationModel.h"

@interface AddChildViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *cityTextField;
@property (strong, nonatomic) UITextField *schoolTextField;
@property (strong, nonatomic) UITextField *gradeTextField;
@property (strong, nonatomic) UITextField *classTextField;
@property (strong, nonatomic) UITextField *relationshipTextField;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UITextField *phoneTextField;

@property (assign, nonatomic) CGFloat height;
@property (strong, nonatomic) ListPickerView *listPicker;
@property (strong, nonatomic) GradeModel *gradeInfo;
@property (copy, nonatomic) NSString *schoolId;
@property (strong, nonatomic) NSNumber *relationId;

@end

@implementation AddChildViewController

- (ListPickerView *)listPicker {
    if (!_listPicker) {
        _listPicker = [[ListPickerView alloc] init];
    }
    return _listPicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加子女";
    [self setUI];
}

- (void)setUI {
    self.scrollView.backgroundColor = SEAECH_VIEW_BACK_COLOR;
    [self viewWithTitle:@"关键字" placeHolder:nil index:0];
    [self viewWithTitle:@"学校" placeHolder:@"请选择学校" index:1];
    [self viewWithTitle:@"年级" placeHolder:@"请选择年级" index:2];
    [self viewWithTitle:@"班级" placeHolder:@"请选择班级" index:3];
    [self viewWithTitle:@"关系" placeHolder:@"请选择关系" index:4];
    [self viewWithTitle:@"姓名" placeHolder:nil index:5];
    [self viewWithTitle:@"手机" placeHolder:nil index:6];
    
    UIButton *submitButton = [CustomView buttonWithTitle:@"提交" width:100 orginY:_height*8];
    [submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:submitButton];
}

- (void)viewWithTitle:(NSString *)title placeHolder:(NSString *)placeholder index:(NSInteger)index {
    UIFont *titleFont = [UIFont boldSystemFontOfSize:16.0];
    UIFont *textFont = [UIFont systemFontOfSize:14.0];
    _height = 50;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _height*index, WIDTH, _height)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 60, _height-10)];
    titleLabel.text = title;
    titleLabel.font = titleFont;
    [view addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(80, 5, WIDTH-100, _height-10)];
    textField.delegate = self;
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleNone;
    textField.layer.borderWidth = 0.5;
    textField.layer.cornerRadius = 5;
    textField.layer.borderColor = SEAECH_VIEW_BACK_COLOR.CGColor;
    textField.clipsToBounds = YES;
    textField.placeholder = placeholder;
    textField.font = textFont;
    [view addSubview:textField];
    switch (index) {
        case 0:
            [textField setTextFieldRightPaddingSearch];
            _cityTextField = textField;
            break;
        case 1:
            [textField setTextFieldRightPaddingList];
            _schoolTextField = textField;
            break;
        case 2:
            [textField setTextFieldRightPaddingList];
            _gradeTextField = textField;
            break;
        case 3:
            [textField setTextFieldRightPaddingList];
            _classTextField = textField;
            break;
        case 4:
            [textField setTextFieldRightPaddingList];
            _relationshipTextField = textField;
            break;
        case 5:
            _nameTextField = textField;
            break;
        case 6:
            _phoneTextField = textField;
            break;
            
        default:
            break;
    }
    [self.scrollView addSubview:view];
    
}

- (void)submitClick {
    if ([_cityTextField isEmpty] || [_schoolTextField isEmpty] || [_gradeTextField isEmpty] || [_classTextField isEmpty] || [_relationshipTextField isEmpty] || [_nameTextField isEmpty]) {
        [LoadingView showBottom:self.view messages:@[@"完善资料"]];
    }else {
        __weak typeof (*&self)weakSelf = self;
        SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
        BasicService *service = [[BasicService alloc] initWithView:self.view];
        NSString *loginName;
        if ([_phoneTextField isEmpty]) {
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            df.dateFormat = @"yyyyMMddHHmmss";
            NSDate *date = [NSDate date];
            loginName = [df stringFromDate:date];
        }else {
            loginName = _phoneTextField.text;
        }
        NSDictionary *params = @{@"userName": _nameTextField.text, @"className": _classTextField.text, @"schoolId": _schoolId, @"gradeId": _gradeInfo.gradeId, @"relationId": _relationId, @"userId": shareInfo.userId, @"loginName": loginName};
//        NSString *format = [NSString stringWithFormat:@"userName=%@&className=%@&schoolId=%@&gradeId=%@&relationId=%@&userId=%@&loginName=%@&",_nameTextField.text, _classTextField.text, _schoolId , _gradeInfo.gradeId,_relationId,shareInfo.userId,loginName];
        [service addChild:params callBack:^(NSInteger code, NSString *msg) {
            [LoadingView showBottom:weakSelf.view messages:@[msg]];
            if (code == 0) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

- (void)showPicker:(NSInteger)type {
    BasicService *service = [[BasicService alloc] initWithView:self.view];
    __weak typeof (*&self)weakSelf = self;
    
    switch (type) {
        case 0:
        {//school
            if ([_cityTextField isEmpty]) {
                [LoadingView showBottom:self.view messages:@[@"城市不能为空"]];
            }else {
                _schoolId = nil;
                _gradeInfo = nil;
                _gradeTextField.text = @"";
                _classTextField.text = @"";
                [service getSchoolListWithCityName:_cityTextField.text callBack:^(BOOL isSuccess, NSArray *schoolList) {
                    if (isSuccess && schoolList.count) {
                        [weakSelf.listPicker.dataList addObjectsFromArray:schoolList];
                        [weakSelf.listPicker show];
                        weakSelf.listPicker.SureCallBack = ^(id model) {
                            if (model) {
                                SchoolModel *schoolModel = model;
                                weakSelf.schoolTextField.text = schoolModel.name;
                                weakSelf.schoolId = schoolModel.schoolId;
                            }
                        };
                    }else {
                        [LoadingView showBottom:weakSelf.view messages:@[@"获取失败或未找到该城市学校信息"]];
                    }
                }];
            }
        }break;
        case 1:
        {//grade
            if (_schoolId) {
                _gradeInfo = nil;
                [service getGradeListWithSchoolId:_schoolId callBack:^(BOOL isSuccess, NSArray *gradeList) {
                    if (isSuccess && gradeList.count) {
                        [weakSelf.listPicker.dataList addObjectsFromArray:gradeList];
                        [weakSelf.listPicker show];
                        weakSelf.listPicker.SureCallBack = ^(id model) {
                            if (model) {
                                weakSelf.gradeInfo = model;
                                weakSelf.gradeTextField.text = weakSelf.gradeInfo.gradeName;
                            }
                        };
                    }else {
                        [LoadingView showBottom:weakSelf.view messages:@[@"获取失败或未找到该学校年级信息"]];
                    }
                }];
            }else {
                [LoadingView showBottom:self.view messages:@[@"学校不能为空"]];
            }
        }break;
        case 2:
        {//class
//            if (_gradeInfo.classNum) {
//                [_listPicker.dataList addObjectsFromArray:_gradeInfo.classList];
//                [_listPicker show];
//                _listPicker.SureCallBack = ^(id model) {
//                    ClassModel *classInfo = model;
//                    weakSelf.classTextField.text = classInfo.classesName;
//                };
//            }else {
//                [LoadingView showBottom:self.view messages:@[@"该年级没有班级"]];
//            }
            if (_gradeInfo) {
                [_listPicker.dataList addObjectsFromArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"]];
                [_listPicker show];
                _listPicker.SureCallBack = ^(id model) {
                    NSString *className = model;
                    weakSelf.classTextField.text = className;
                };
            }else {
                [LoadingView showBottom:self.view messages:@[@"先选择年级"]];
            }
        }break;
        case 3:
        {//relation
            [service getRelationListCallBack:^(BOOL isSuccess, NSArray *relationList) {
                if (isSuccess) {
                    [weakSelf.listPicker.dataList addObjectsFromArray:relationList];
                    [weakSelf.listPicker show];
                    weakSelf.listPicker.SureCallBack = ^(id model) {
                        RelationModel *relationModel = model;
                        weakSelf.relationshipTextField.text = relationModel.typeName;
                        weakSelf.relationId = relationModel.relationId;
                    };
                }
            }];
            
        }break;
            
        default:
            break;
    }
}


#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.cityTextField || textField == self.nameTextField || textField == self.phoneTextField) {
        return YES;
    }else {
        [self.view endEditing:YES];
        if (textField == _schoolTextField) {
            [self showPicker:0];
        }else if (textField == _gradeTextField) {
            [self showPicker:1];
        }else if (textField == _classTextField) {
            [self showPicker:2];
        }else {
            [self showPicker:3];
        }
        return NO;
    }
}


@end
