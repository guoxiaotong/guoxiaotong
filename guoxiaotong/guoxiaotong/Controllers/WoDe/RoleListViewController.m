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

@interface RoleListViewController ()

@property (nonatomic, strong)NSMutableArray *dataSourse;

@end

@implementation RoleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationItems];
    self.dataSourse = [NSMutableArray array];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"RoleListTableViewCell" bundle:nil] forCellReuseIdentifier:@"roleListCell"];
    [self loadData];
}

- (void)setNavigationItems {
    self.navigationItem.title = @"角色列表";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRoleClick)];
}

- (void)addRoleClick {
    UIStoryboard *wode = [UIStoryboard storyboardWithName:@"AddRole" bundle:nil];
    UIViewController *addVC = [wode instantiateViewControllerWithIdentifier:@"ADDROLE"];
    [self.navigationController pushViewController:addVC animated:true];
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    UserService *userService = [[UserService alloc] initWithView:self.view];
    [userService getRoleListWithUserId:shareInfo.userId callBack:^(BOOL isSuccessed, NSArray *roleList) {
        if (isSuccessed) {
            [weakSelf.dataSourse addObjectsFromArray:roleList];
            [weakSelf.tableView reloadData];
        }
    }];
}


#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourse.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof (*&self)weakSelf = self;
    RoleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"roleListCell"];
    cell.ManagerButtonCallBack = ^(NSInteger roleId, NSString *roleName) {
        ManagerViewController *managerVC = [[ManagerViewController alloc] init];
        managerVC.roleId = roleId;
        managerVC.roleName = roleName;
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
    //修改昵称
}


@end
