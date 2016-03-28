//
//  JZMemberManageViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "JZMemberManageViewController.h"
#import "JZMemberModel.h"
#import "JZManagerService.h"
#import "JZAddMemberViewController.h"
#import "RoleListViewController.h"

@interface JZMemberManageViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIAlertView *alert;
@property (nonatomic, assign) BOOL isDel;
@property (nonatomic, assign) NSInteger index;

@end

@implementation JZMemberManageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"家长管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMember)];
    _dataSource = [NSMutableArray array];

    [self setUI];
}

- (void)addMember {
    JZAddMemberViewController *addMember = [[JZAddMemberViewController alloc] init];
    addMember.roleInfo = self.roleInfo;
    [self.navigationController pushViewController:addMember animated:YES];
}

- (void)setUI {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.tableView addGestureRecognizer:longPress];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    JZManagerService *service = [[JZManagerService alloc] initWithView:self.view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"userId": shareInfo.userId, @"studentId": _roleInfo.studentId};
    [service getMemberList:params callBack:^(BOOL isSuccess, NSArray *memberList) {
        if (isSuccess) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf.dataSource addObjectsFromArray:memberList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    JZMemberModel *memberModel = self.dataSource[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"manager_role_jiazhang_pic"];
    cell.textLabel.text = memberModel.parentName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置监护人
    _isDel = NO;
    _index = indexPath.row;
    JZMemberModel *memberModel = self.dataSource[indexPath.row];
    [self showAlert:[NSString stringWithFormat:@"将 %@ 设为监护人？", memberModel.parentName]];
}

- (void)longPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        if(indexPath) {
            _isDel = YES;
            _index = indexPath.row;
            JZMemberModel *memberModel = self.dataSource[indexPath.row];
            [self showAlert:[NSString stringWithFormat:@"删除家长 %@ ?", memberModel.parentName]];
        }
    }
}

- (void)showAlert:(NSString *)message {
    _alert = nil;
    _alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [_alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self doSomeThing];
            break;
        default:
            break;
    }
}
//
- (void)doSomeThing {
    __weak typeof (*&self)weakSelf = self;
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    JZMemberModel *memberModel = self.dataSource[_index];
    JZManagerService *service = [[JZManagerService alloc] initWithView:self.view];
    if (_isDel) {
        //删除
        NSDictionary *params = @{@"managerId": memberModel.parentId, @"studentId": memberModel.studentId};
        [service deleteJZ:params callBack:^(NSInteger code, NSString *msg) {
            [LoadingView showBottom:weakSelf.view messages:@[msg]];
            if (code == 0) {
                [weakSelf loadData];
            }
        }];
    }else {
        //设置监护人
        NSDictionary *params = @{@"newId": memberModel.parentId, @"userId": shareInfo.userId, @"studentId": memberModel.studentId};
        [service changeJHR:params callBack:^(NSInteger code, NSString *msg) {
            [LoadingView showBottom:weakSelf.view messages:@[msg]];
            if (code == 0) {
                for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[RoleListViewController class]]) {
                        [weakSelf.navigationController popToViewController:vc animated:YES];
                    }
                }
            }
        }];
    }
}

@end
