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
    
    UIColor *buttonColor = [UIColor colorWithRed:143/225.0 green:233/225.0 blue:63/225.0 alpha:1.0];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.frame = CGRectMake((WIDTH-width)/2, 50, width, 30);
    exitButton.layer.borderWidth = 0.25;
    exitButton.layer.cornerRadius = 5;
    exitButton.layer.borderColor = buttonColor.CGColor;
    exitButton.backgroundColor = buttonColor;
    [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
    [footer addSubview:exitButton];
    self.tableView.tableFooterView = footer;
}

- (void)logout {
    SingleUserInfo *userInfo = [SingleUserInfo shareUserInfo];
    userInfo = nil;
    UIStoryboard *loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UIViewController *loginVC = [loginStoryBoard instantiateViewControllerWithIdentifier:@"LOGIN"];
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
        return cell;
    }else if (indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7) {
        if (self.isOpenNoti) {
            SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
            __weak typeof (*&self)weakSelf = self;
            cell.index = indexPath.row;
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
                cell.index = indexPath.row;
                cell.SwitchBlock = ^(NSInteger index, BOOL open){
                    [weakSelf switchNotifitionState:open];
                };
                cell.titleLabel.text = self.dataSource[indexPath.row];
                return cell;
            }else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
                cell.textLabel.text = self.dataSource[indexPath.row];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                return cell;
            }
        }
        
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.textLabel.text = self.dataSource[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
    UIStoryboard *setting = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
    UIViewController *nextVC;
    if (indexPath.row == 0) {
        nextVC = [setting instantiateViewControllerWithIdentifier:@"EDITPWD"];
    }else if (indexPath.row == 1) {
        nextVC = [[AboutUsViewController alloc] init];
    }else if (indexPath.row == 2) {
        nextVC = [[ScanCodeViewController alloc] init];
    }else if (indexPath.row == 3) {
        nextVC = [setting instantiateViewControllerWithIdentifier:@"ADVICE"];
    }else if (indexPath.row == 4) {
        //版本更新
    }else if (indexPath.row == 5) {
        
    }else if (indexPath.row == 6) {
        if (self.isOpenNoti) {
            //
        }else {
            //清除缓存
        }
    }else if (indexPath.row == 7) {
        
    }else if (indexPath.row == 8) {
        //清除缓存
    }else {
        
    }
    if (nextVC) {
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)deselect {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
