//
//  MyAddressListViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "MyAddressListViewController.h"
#import "ContactTableViewCell.h"
#import "SectionHeaderView.h"
#import "BasicService.h"
#import "ContectRoleModel.h"
#import "ContectMemberModel.h"
#import "TextFieldWithButton.h"
//#import "ChatViewController.h"


@interface MyAddressListViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)TextFieldWithButton *searchTextField;
@property (nonatomic, assign)CGFloat bottomHeight;
@property (nonatomic, assign)CGFloat searchHeight;
@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation MyAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:200/225.0 green:200/225.0 blue:200/225.0 alpha:1.0];
    self.navigationItem.title = @"我的通讯录";
    _dataSource = [NSMutableArray array];
    [self setUI];
    [self loadData];
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    BasicService *service = [[BasicService alloc] initWithView:self.view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"userId": shareInfo.userId, @"roleId": [NSNumber numberWithInteger: shareInfo.roleId]};
    [service getContect:params callBack:^(BOOL isSuccess, NSArray *roleList) {
        if (isSuccess) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf.dataSource addObjectsFromArray:roleList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)setUI {
    _bottomHeight = 64;
    _searchHeight = 40;

    _searchTextField = [[TextFieldWithButton alloc] initSerachButtonWithFrame:CGRectMake(20, 5, WIDTH-40, 30)];
    _searchTextField.buttonCallBack = ^() {
        //点击搜索
    };
    _searchTextField.delegate = self;
    [self.view addSubview:_searchTextField];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchHeight, WIDTH, HEIGHT-64-self.bottomHeight-self.searchHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithRed:200/225.0 green:200/225.0 blue:200/225.0 alpha:1.0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[ContactTableViewCell class] forCellReuseIdentifier:@"ContactCell"];
    [self.view addSubview:self.tableView];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.frame = CGRectMake(10, HEIGHT - _bottomHeight-64 + 10, WIDTH - 20, _bottomHeight - 20);
    bottomButton.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
    [bottomButton setTitle:@"联系客服" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bottomButton.layer.cornerRadius = 5;
    [bottomButton addTarget:self action:@selector(serverClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomButton];
}

- (void)serverClick {
    NSLog(@"联系客服");
//    EaseMessageViewController *easeMessageVC = [[EaseMessageViewController alloc] init];
//    easeMessageVC.title = @"国校通客服";
//    [self.navigationController pushViewController:easeMessageVC animated:YES];
}


#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ContectRoleModel *roleModel = self.dataSource[section];
    if (roleModel.open) {
        return roleModel.memberList.count;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    ContectRoleModel *roleModel = self.dataSource[indexPath.section];
    ContectMemberModel *memberModel = roleModel.memberList[indexPath.row];
    [cell setUIWithModel:memberModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __weak typeof (*&self)weakSelf = self;
    ContectRoleModel *roleModel = self.dataSource[section];
    SectionHeaderView *headerview = [[SectionHeaderView alloc] initWithTitle: roleModel.roleName isOpen: roleModel.open];
    headerview.SectionBlock = ^(NSInteger index, BOOL isOpen) {
        roleModel.open = isOpen;
        [weakSelf.tableView reloadData];
    };
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ContectRoleModel *roleModel = self.dataSource[indexPath.section];
    ContectMemberModel *memberModel = roleModel.memberList[indexPath.row];
    
//    EMBuddy *buddy = [EMBuddy buddyWithUsername:memberModel.userName];
//    EaseUserModel *model = [[EaseUserModel alloc] initWithBuddy:buddy];
//    model.nickname = memberModel.userName;
//    model.avatarURLPath = [NSString stringWithFormat:@"%@%@", API_ROOT_IMAGE_URL, memberModel.picPath];
//    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
//    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
//    if (loginUsername && loginUsername.length > 0) {
//        if ([loginUsername isEqualToString:memberModel.loginName]) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"friend.notChatSelf", @"can't talk to yourself") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
//            [alertView show];
//            
//            return;
//        }
//    }
//    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:model.buddy.username conversationType:eConversationTypeChat];
//    chatController.title = model.nickname.length > 0 ? model.nickname : model.buddy.username;
//    [self.navigationController pushViewController:chatController animated:YES];
}

@end
