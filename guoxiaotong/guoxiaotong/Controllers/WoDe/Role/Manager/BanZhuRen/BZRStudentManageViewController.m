//
//  BZRStudentManageViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BZRStudentManageViewController.h"
#import "BZRManagerService.h"
#import "BZRJianhurenModel.h"

@interface BZRStudentManageViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger index;
@end

@implementation BZRStudentManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"学生管理";
    [self setUI];
    [self loadData];
}

- (void)setUI {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.tableView addGestureRecognizer:longPress];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadData {
    _dataSource = [NSMutableArray array];
    BZRManagerService *service = [[BZRManagerService alloc] initWithView:self.view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"classId": _roleInfo.classId, @"userId": shareInfo.userId};
    __weak typeof (*&self)weakSelf = self;
    [service getStudentList:params callBack:^(BOOL isSuccess, NSArray *studentList) {
        if (isSuccess) {
            [weakSelf.dataSource addObjectsFromArray:studentList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    BZRJianhurenModel *jianhurenModel = self.dataSource[indexPath.row];
    cell.textLabel.text = jianhurenModel.studentName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#warning 判断有没有监护人

}

- (void)longPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        if(indexPath) {
            BZRJianhurenModel *jianhurenModel = self.dataSource[indexPath.row];
            _index = indexPath.row;
#warning 判断有没有监护人
//            有
            [self showAlert:jianhurenModel.parentName];
        }
    }
}

- (void)showAlert:(NSString *)name {
    _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"删除监护人 %@?", name] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [_alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self deleteJianhuren];
            break;
        default:
            break;
    }
}

- (void)deleteJianhuren {
    BZRManagerService *service = [[BZRManagerService alloc] initWithView:self.view];
    __weak typeof (*&self)weakSelf = self;
    BZRJianhurenModel *jianhuren = self.dataSource[_index];
    NSDictionary *params = @{@"guardianId": jianhuren.parentId, @"studentId": jianhuren.studentId};
    [service deleteJianhuren:params callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf loadData];
        }
    }];
}



@end
