//
//  XZTeacherManageViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZTeacherManageViewController.h"
#import "ManagerService.h"
#import "XZAddTeacherViewController.h"

@interface XZTeacherManageViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIAlertView *alert;

@end

@implementation XZTeacherManageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"教师管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTeacher)];
    _dataSource = [NSMutableArray array];

    [self setUI];
}

- (void)addTeacher {
    XZAddTeacherViewController *addTeacherVC = [[XZAddTeacherViewController alloc] init];
    [self.navigationController pushViewController:addTeacherVC animated:true];
}

- (void)setUI {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.tableView addGestureRecognizer:longPress];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    [service getTeacherList:_roleInfo.schoolId callBack:^(BOOL isSuccess, NSArray *teacherList) {
        if (isSuccess) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.tableView reloadData];
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

- (void)longPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        if(indexPath) {
            TeacherModel *teacher = self.dataSource[indexPath.row];
            _index = indexPath.row;
            [self showAlert:teacher.teacherName];
        }
    }
}

- (void)showAlert:(NSString *)name {
    _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"删除教师 %@?", name] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [_alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self deleteTeacher];
            break;
        default:
            break;
    }
}

- (void)deleteTeacher {
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    __weak typeof (*&self)weakSelf = self;
    TeacherModel *teacher = self.dataSource[_index];
    NSDictionary *params = @{@"teacherId": teacher.teacherId, @"schoolId": [NSNumber numberWithInteger: _roleInfo.schoolId]};
    [service deleteTeacher:params callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf loadData];
        }
    }];
}

@end