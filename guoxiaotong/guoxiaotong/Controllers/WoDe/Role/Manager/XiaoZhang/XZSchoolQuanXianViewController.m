//
//  XZSchoolQuanXianViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZSchoolQuanXianViewController.h"
#import "SwitchTableViewCell.h"
#import "ManagerService.h"

@interface XZSchoolQuanXianViewController ()

@property (nonatomic, strong) SchoolPermissionModel *permissionModel;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation XZSchoolQuanXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"学校权限设置";
    [self setUI];
    [self loadData];
}

- (void)setUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.titles = @[@"是否允许班主任/教师发公告",
                    @"是否允许班主任/教师建群",
                    @"是否允许班主任/教师私聊",
                    @"是否允许监护人/家长私聊",
                    @"是否允许监护人/家长发分享",
                    @"开启校长直通车"];
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    self.permissionModel = nil;
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    [service getSchoolPermission:_roleInfo.schoolId callBack:^(BOOL isSuccess, SchoolPermissionModel *schollPermission) {
        if (isSuccess) {
            weakSelf.permissionModel = schollPermission;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)setSettings:(NSInteger)index state:(BOOL)isOn {
    __weak typeof (*&self)weakSelf = self;
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSMutableDictionary *permissions = [NSMutableDictionary dictionary];
    switch (index) {
        case 0:
        {
            if (isOn) {
                self.permissionModel.tutorInfo = @"1";
            }else {
                self.permissionModel.tutorInfo = @"0";
            }
            [permissions setObject:self.permissionModel.tutorInfo forKey:@"tutorInfo"];
        }break;
        case 1:
        {
            if (isOn) {
                self.permissionModel.teacherGroup = @"1";
            }else {
                self.permissionModel.teacherGroup = @"0";
            }
            [permissions setObject:self.permissionModel.teacherGroup forKey:@"teacherGroup"];
        } break;
        case 2:
        {
            if (isOn) {
                self.permissionModel.teacherChat = @"1";
            }else {
                self.permissionModel.teacherChat = @"0";
            }
            [permissions setObject:self.permissionModel.teacherChat forKey:@"teacherChat"];
        }break;
        case 3:
        {
            if (isOn) {
                self.permissionModel.familyChat = @"1";
            }else {
                self.permissionModel.familyChat = @"0";
            }
            [permissions setObject:self.permissionModel.familyChat forKey:@"familyChat"];
        }break;
        case 4:
        {
            if (isOn) {
                self.permissionModel.familyShare = @"1";
            }else {
                self.permissionModel.familyShare = @"0";
            }
            [permissions setObject:self.permissionModel.familyShare forKey:@"familyShare"];
        }break;
        case 5:
        {
            if (isOn) {
                self.permissionModel.principalMail = @"1";
            }else {
                self.permissionModel.principalMail = @"0";
            }
            [permissions setObject:self.permissionModel.principalMail forKey:@"principalMail"];
        }break;
        default:
            break;
    }
    
    [service setSchoolPermission:shareInfo.userId permissions:permissions callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            //
            [weakSelf loadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    cell.titleLabel.text = self.titles[indexPath.row];
    switch (indexPath.row) {
        case 0:
            [cell setState:self.permissionModel.tutorInfo index:indexPath.row];
            break;
        case 1:
            [cell setState:self.permissionModel.teacherGroup index:indexPath.row];
            break;
        case 2:
            [cell setState:self.permissionModel.teacherChat index:indexPath.row];
            break;
        case 3:
            [cell setState:self.permissionModel.familyChat index:indexPath.row];
            break;
        case 4:
            [cell setState:self.permissionModel.familyShare index:indexPath.row];
            break;
        case 5:
            [cell setState:self.permissionModel.principalMail index:indexPath.row];
            break;
        default:
            break;
    }
    __weak typeof (*&self)weakSelf = self;
    cell.SwitchBlock = ^(NSInteger index, BOOL isOn) {
        [weakSelf setSettings:index state:isOn];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
}

- (void)deselect {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}



@end
