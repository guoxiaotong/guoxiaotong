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
#import "BZRAddJianhurenViewController.h"
#import "BZRStudentTableViewCell.h"

@interface BZRStudentManageViewController ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger index;
@end

@implementation BZRStudentManageViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"学生管理";
    _dataSource = [NSMutableArray array];

    [self setUI];
}

- (void)setUI {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.tableView addGestureRecognizer:longPress];
    [self.tableView registerClass:[BZRStudentTableViewCell class] forCellReuseIdentifier:@"StudentCell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadData {
    BZRManagerService *service = [[BZRManagerService alloc] initWithView:self.view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"classId": _roleInfo.classId, @"userId": shareInfo.userId};
    __weak typeof (*&self)weakSelf = self;
    [service getStudentList:params callBack:^(BOOL isSuccess, NSArray *studentList) {
        if (isSuccess) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf.dataSource addObjectsFromArray:studentList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BZRStudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StudentCell"];
    BZRJianhurenModel *jianhurenModel = self.dataSource[indexPath.row];
    [cell setUIWith:jianhurenModel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#warning 判断有没有监护人
    BZRJianhurenModel *jianhuren = self.dataSource[indexPath.row];
    if (jianhuren.parentName) {
        [self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
    }else {
        BZRAddJianhurenViewController *addJHR = [[BZRAddJianhurenViewController alloc] init];
        addJHR.jianhurenInfo = jianhuren;
        [self.navigationController pushViewController:addJHR animated:YES];
    }

}

- (void)longPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        if(indexPath) {
            BZRJianhurenModel *jianhurenModel = self.dataSource[indexPath.row];
            if (jianhurenModel.parentName) {
                _index = indexPath.row;
#warning 判断有没有监护人
                //            有
                [self showAlert:jianhurenModel.parentName];
            }
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

- (void)deselect {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
