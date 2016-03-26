//
//  XZEditClassViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZEditClassViewController.h"
#import "ManagerService.h"

@interface XZEditClassViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *textFieldArray;
@property (nonatomic, strong) NSMutableDictionary *changedIndexDictionary;
@property (nonatomic, assign) BOOL isChanged;

@end

@implementation XZEditClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isChanged = NO;
    _changedIndexDictionary = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"修改班级";
    [self setUI];
}

- (void)setUI {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    
    UILabel *gradeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 30)];
    gradeLabel.text = @"年级列表";
    [view addSubview:gradeLabel];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-120, 5, 80, 30)];
    numLabel.text = @"班级数量";
    [view addSubview:numLabel];
    
    UILabel *border = [[UILabel alloc] initWithFrame:CGRectMake(0, 39.5, WIDTH, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:border];
    
    [self.scrollView addSubview:view];
    
    [self setGradeList];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake((WIDTH-150)/2, 100+50*_gradeList.count, 150, 30);
    [sureButton setTitle:@"确认修改" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    sureButton.backgroundColor = [UIColor greenColor];
    [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:sureButton];
    if (sureButton.frame.origin.y+100<HEIGHT) {
        self.scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    }
}

- (void)setGradeList {
    _textFieldArray = [NSMutableArray array];
    for (NSInteger index = 0; index<_gradeList.count; index++) {
        
        GradeModel *gradeInfo = _gradeList[index];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 40+50*index, WIDTH, 50)];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        titleLabel.text = gradeInfo.gradeName;
        [view addSubview:titleLabel];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(WIDTH-120, 5, 80, 30)];
        textField.borderStyle = UITextBorderStyleNone;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 0.5;
        textField.layer.cornerRadius = 5;
        textField.delegate = self;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.text = [NSString stringWithFormat:@"%ld", gradeInfo.classNum];
        textField.keyboardType = UIKeyboardTypeNumberPad;
//        if (index == _gradeList.count-1) {
//            textField.returnKeyType = UIReturnKeyDone;
//        }else {
//            textField.returnKeyType = UIReturnKeyNext;
//        }
        [view addSubview:textField];
        [_textFieldArray addObject:textField];
        
        UILabel *border = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH, 0.5)];
        border.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:border];
        [self.scrollView addSubview:view];
    }
}

- (void)sureClick {
    if (_isChanged) {
        //
        NSMutableString *numString = [NSMutableString string];
        NSMutableString *gradeString = [NSMutableString string];
        NSMutableString *nameString = [NSMutableString string];
        for (NSNumber *key in _changedIndexDictionary) {
            NSInteger index = [key integerValue];
            UITextField *textf = _textFieldArray[index];
            GradeModel *gradeInfo = _gradeList[index];
            [numString appendFormat:@"%@,", textf.text];
            [gradeString appendFormat:@"%@,", gradeInfo.gradeId];
            [nameString appendFormat:@"%@,", gradeInfo.gradeName];
        }
        [numString deleteCharactersInRange:NSMakeRange(numString.length-1, 1)];
        [gradeString deleteCharactersInRange:NSMakeRange(gradeString.length-1, 1)];
        [nameString deleteCharactersInRange:NSMakeRange(nameString.length-1, 1)];
        __weak typeof (*&self)weakSelf = self;
        SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
        ManagerService *service = [[ManagerService alloc] initWithView:self.view];
        NSDictionary *params = @{@"grade": gradeString, @"num": numString, @"schoolId": [NSNumber numberWithInteger: _roleInfo.schoolId], @"userId": shareInfo.userId, @"name": nameString};
        [service editClass:params callBack:^(BOOL isSuccess) {
            if (isSuccess) {
                [LoadingView showBottom:weakSelf.view messages:@[@"修改成功"]];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    }else {
        [LoadingView showBottom:self.view messages:@[@"请输入班级数量"]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger index = 0;
    for (UITextField *tf in _textFieldArray) {
        if (textField == tf) {
            _isChanged = YES;
            [_changedIndexDictionary setObject:@"value" forKey:[NSNumber numberWithInteger:index]];
        }
        index ++;
    }
    return YES;
}


//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    NSInteger index = 0;
//    for (UITextField *tf in _textFieldArray) {
//        if (textField == tf) {
//            if (index< _gradeList.count-1) {
//                UITextField *text = _textFieldArray[index+1];
//                [textField resignFirstResponder];
//                [text becomeFirstResponder];
//            }
//        }
//        index ++;
//    }
//    return YES;
//}


@end
