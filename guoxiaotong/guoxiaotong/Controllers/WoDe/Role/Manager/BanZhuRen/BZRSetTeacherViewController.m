//
//  BZRSetTeacherViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BZRSetTeacherViewController.h"
#import "BZRManagerService.h"
#import "TeacherModel.h"
#import "ManagerService.h"
#import "TextFieldWithButton.h"

@interface BZRSetTeacherViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TextFieldWithButton *searchTextField;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation BZRSetTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SEAECH_VIEW_BACK_COLOR;
    self.navigationItem.title = @"设置课程老师";
    [self setUI];
    [self loadData];
}
- (void)setUI {
    _searchTextField = [[TextFieldWithButton alloc] initSerachButtonWithFrame:CGRectMake(20, 5, WIDTH-40, 30)];
    _searchTextField.buttonCallBack = ^() {
        //点击搜索
    };
    _searchTextField.delegate = self;
    [self.view addSubview:_searchTextField];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-104) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)loadData {
    _dataSource = [NSMutableArray array];
    __weak typeof (*&self)weakSelf = self;
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    [service getTeacherList:_roleInfo.schoolId callBack:^(BOOL isSuccess, NSArray *teacherList) {
        if (isSuccess) {
            [weakSelf.dataSource addObjectsFromArray:teacherList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)loadDataWithKeyWord:(NSString *)keyWord {
    _dataSource = [NSMutableArray array];
    __weak typeof (*&self)weakSelf = self;
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    [service getTeacherList:_roleInfo.schoolId keyWord:keyWord callBack:^(BOOL isSuccess, NSArray *teacherList) {
        if (isSuccess) {
            [weakSelf.dataSource addObjectsFromArray:teacherList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    TeacherModel *teacher = self.dataSource[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"manager_role_teacher_pic"];
    cell.textLabel.text = teacher.teacherName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TeacherModel *teacherInfo = self.dataSource[indexPath.row];
    [self setTeacher:teacherInfo.teacherId];
}

#pragma mark - 设置课程老师
- (void)setTeacher:(NSString *)teacherId {
    
    __weak typeof (*&self)weakSelf = self;
    BZRManagerService *service = [[BZRManagerService alloc] initWithView:self.view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"classId": _roleInfo.classId, @"teacherId": teacherId, @"courseId": _courseInfo.courseId, @"userId": shareInfo.userId};
    [service setTeacher:params callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:true];
        }
    }];
    
}

#pragma mark - searchTextfieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
#warning 此处搜索需要修改
    NSLog(@"range:loc:%ld,---len:%ld", range.location, range.length);
    NSLog(@"text:%@", textField.text);
    NSLog(@"string: %@",string);
    
    [self loadDataWithKeyWord:[NSString stringWithFormat:@"%@%@", textField.text, string]];
    return YES;
}



@end
