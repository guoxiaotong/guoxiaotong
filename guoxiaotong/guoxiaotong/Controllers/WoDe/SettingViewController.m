//
//  SettingViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "GXTNavigationController.h"
#import "SingleUserInfo.h"

#import "SettingViewController.h"
#import "VersionTableViewCell.h"
#import "SwitchTableViewCell.h"

#import "EditPassWordViewController.h"
#import "AboutUsViewController.h"
#import "ScanCodeViewController.h"
#import "AdviceViewController.h"

#import "LoginViewController.h"
#import "CustomView.h"

@interface SettingViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isOpenNoti;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isOpenNoti = YES;
    self.navigationItem.title = @"设置";
    [self setData];
    [self setUI];
}

- (void)setData {
    NSArray *arr;
    if (self.isOpenNoti) {
         arr = @[@"修改密码", @"关于我们", @"二维码扫描", @"你提我改", @"版本更新", @"接受新消息通知", @"声音", @"震动", @"清除缓存"];
    }else {
        arr = @[@"修改密码", @"关于我们", @"二维码扫描", @"你提我改", @"版本更新", @"接受新消息通知", @"清除缓存"];
    }
    self.dataSource = [NSMutableArray arrayWithArray:arr];
}

- (void)switchNotifitionState:(BOOL)open {
    if (open) {
        [self.dataSource insertObject:@"声音" atIndex:6];
        [self.dataSource insertObject:@"震动" atIndex:7];
    }else {
        [self.dataSource removeObjectAtIndex:6];
        [self.dataSource removeObjectAtIndex:6];
    }
    self.isOpenNoti = open;
    [self.tableView reloadData];
}

- (void)switchVoice:(BOOL)open {
    if (open) {
        NSLog(@"打开声音");
    }else {
        NSLog(@"关闭声音");
    }
}

- (void)switchZhenDong:(BOOL)open {
    if (open) {
        NSLog(@"打开震动");
    }else {
        NSLog(@"关闭震动");
    }
}

- (void)setUI {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"VersionTableViewCell" bundle:nil] forCellReuseIdentifier:@"VersionCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
    
    CGFloat width = 100;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    UIButton *exitButton = [CustomView buttonWithTitle:@"退出登录" width:width orginY:50];
    [exitButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:exitButton];
    self.tableView.tableFooterView = footer;
}

- (void)logout {
    SingleUserInfo *userInfo = [SingleUserInfo shareUserInfo];
    userInfo = nil;
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error && info) {
            NSLog(@"退出成功");
        }
    } onQueue:nil];
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    GXTNavigationController *navi = [[GXTNavigationController alloc] initWithRootViewController:loginVC];
    self.view.window.rootViewController = navi;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        VersionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VersionCell"];
        cell.titleLabel.text = self.dataSource[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.versionLabel.text = @"当前版本1.0";
        cell.titleLabel.font = [UIFont systemFontOfSize:14.0];
        return cell;
    }else if (indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7) {
        if (self.isOpenNoti) {
            SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
            __weak typeof (*&self)weakSelf = self;
            [cell setState:@"1" index:indexPath.row];
            cell.SwitchBlock = ^(NSInteger index, BOOL open) {
                if (index == 5) {
                    [weakSelf switchNotifitionState:open];
                }else if (index == 6) {
                    [weakSelf switchVoice:open];
                }else {
                    [weakSelf switchZhenDong:open];
                }
            };
            cell.titleLabel.text = self.dataSource[indexPath.row];
            return cell;
        }else {
            if (indexPath.row == 5) {
                SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
                __weak typeof (*&self)weakSelf = self;
                [cell setState:@"0" index:indexPath.row];
                cell.SwitchBlock = ^(NSInteger index, BOOL open){
                    [weakSelf switchNotifitionState:open];
                };
                cell.titleLabel.text = self.dataSource[indexPath.row];
                return cell;
            }else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
                cell.textLabel.text = self.dataSource[indexPath.row];
                cell.textLabel.font = [UIFont systemFontOfSize:14.0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
        }
        
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.textLabel.text = self.dataSource[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
    UIViewController *nextVC;
    switch (indexPath.row) {
        case 0:
        {
            nextVC = [[EditPassWordViewController alloc] init];
        }break;
        case 1:
        {
            nextVC = [[AboutUsViewController alloc] init];
        }break;
        case 2:
        {
            nextVC = [[ScanCodeViewController alloc] init];
        }break;
        case 3:
        {
            nextVC = [[AdviceViewController alloc] init];
        }break;
        case 4:
        {
            //版本更新
        }break;
        case 5:
        {
            //不操作
        }break;
        case 6:
        {
            //判断
            if (_isOpenNoti) {
                //不操作
            }else {
                //清缓存
            }
        }break;
        case 7:
        {
            //不操作
        }break;
        case 8:
        {
            //清缓存
        }break;
            
        default:
            break;
    }
    if (nextVC) {
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)deselect {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
