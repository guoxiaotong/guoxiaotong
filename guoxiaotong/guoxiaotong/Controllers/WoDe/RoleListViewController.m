//
//  RoleListViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "RoleListViewController.h"
#import "RoleListTableViewCell.h"
#import "ManagerViewController.h"
#import "AddRoleViewController.h"
#import "UserService.h"
#import "UserModel.h"
#import "UserRoleInfoModel.h"
#import "EditNickNameView.h"

@interface RoleListViewController ()

@property (nonatomic, strong)NSMutableArray *dataSourse;

@end

@implementation RoleListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationItems];
    _dataSourse = [NSMutableArray array];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"RoleListTableViewCell" bundle:nil] forCellReuseIdentifier:@"roleListCell"];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.tableView addGestureRecognizer:longPress];
}

- (void)setNavigationItems {
    self.navigationItem.title = @"角色列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRoleClick)];
}

- (void)addRoleClick {
    AddRoleViewController *addRoleVC = [[AddRoleViewController alloc] init];
    [self.navigationController pushViewController: addRoleVC animated:true];
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    UserService *userService = [[UserService alloc] initWithView:self.view];
    [userService getRoleListWithUserId:shareInfo.userId callBack:^(BOOL isSuccessed, NSArray *roleList) {
        if (isSuccessed) {
            [weakSelf.dataSourse removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf.dataSourse addObjectsFromArray:roleList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)longPress:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
        if(indexPath) {
            //弹出添加昵称（4个字）
            EditNickNameView *edit = [[EditNickNameView alloc] init];
            __weak typeof (*&self)weakSelf = self;
            edit.sureCallBack = ^(NSString *name) {
                if (name.length) {
                    ////////
                    UserRoleInfoModel *roleInfo = weakSelf.dataSourse[indexPath.row];
                    NSDictionary *params = @{@"nickName": name, @"roleId":[NSNumber numberWithInteger: roleInfo.roleId], @"typeId": roleInfo.typeId};
                    UserService *service = [[UserService alloc] initWithView:weakSelf.view];
                    [service editRoleName:params callBack:^(NSInteger code, NSString *msg) {
                        [LoadingView showBottom:weakSelf.view messages:@[msg]];
                        if (code == 0) {
                            [weakSelf loadData];
                        }
                    }];
                }
            };
        }
    }
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof (*&self)weakSelf = self;
    RoleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"roleListCell"];
    cell.ManagerButtonCallBack = ^(UserRoleInfoModel *roleInfo) {
        ManagerViewController *managerVC = [[ManagerViewController alloc] init];
        managerVC.roleInfo = roleInfo;
        [weakSelf.navigationController pushViewController:managerVC animated:YES];
    };
    UserRoleInfoModel *roleInfo = self.dataSourse[indexPath.row];
    [cell setUIWith:roleInfo];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
}

- (void)deselect {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


@end
