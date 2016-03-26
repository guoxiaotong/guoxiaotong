//
//  JZQuanXianViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "JZQuanXianViewController.h"
#import "SwitchTableViewCell.h"
#import "JZPermissionModel.h"
#import "JZManagerService.h"

@interface JZQuanXianViewController ()

@property (nonatomic, strong) JZPermissionModel *permissionModel;

@end

@implementation JZQuanXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"成员权限管理";
    [self setUI];
    [self loadData];
}

- (void)setUI {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
}

- (void)loadData {
    
    JZManagerService *service = [[JZManagerService alloc] initWithView:self.view];
    __weak typeof (*&self)weakSelf = self;
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"classId": _roleInfo.classId, @"userId": shareInfo.userId};
    [service getPermission:params callBack:^(BOOL isSuccess, JZPermissionModel *permissions) {
        if (isSuccess) {
            weakSelf.permissionModel = permissions;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.permissionModel) {
        return 2;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    __weak typeof (*&self)weakSelf = self;
    cell.SwitchBlock = ^(NSInteger index, BOOL isOpen){
        [weakSelf setSettings:index state:isOpen];
    };
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"是否允许家长发分享";
            [cell setState:_permissionModel.familyChat index:indexPath.row];
            break;
        case 1:
            cell.titleLabel.text = @"是否允许家长查看动态";
            [cell setState:_permissionModel.familySeeShare index:indexPath.row];
            break;
        default:
            break;
    }
    return cell;
}

- (void)setSettings:(NSInteger)index state:(BOOL)isOn {
    __weak typeof (*&self)weakSelf = self;
    JZManagerService *service = [[JZManagerService alloc] initWithView:self.view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSMutableDictionary *permissions = [NSMutableDictionary dictionary];
    [permissions setObject:_roleInfo.classId forKey:@"classId"];
    [permissions setObject:shareInfo.userId forKey:@"userId"];
    switch (index) {
        case 0:
        {
            if (isOn) {
                self.permissionModel.familyChat = @"1";
            }else {
                self.permissionModel.familyChat = @"0";
            }
            [permissions setObject:self.permissionModel.familyChat forKey:@"familyChat"];
        }break;
        case 1:
        {
            if (isOn) {
                self.permissionModel.familySeeShare = @"1";
            }else {
                self.permissionModel.familySeeShare = @"0";
            }
            [permissions setObject:self.permissionModel.familySeeShare forKey:@"familySeeShare"];
        } break;
        default:
            break;
    }
    
    [service setPermission:permissions callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf loadData];
        }
    }];
}


@end
