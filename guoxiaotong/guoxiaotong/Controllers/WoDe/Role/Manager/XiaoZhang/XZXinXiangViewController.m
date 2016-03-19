//
//  XZXinXiangViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZXinXiangViewController.h"
#import "ManagerService.h"
#import "XZEmailListTableViewCell.h"
#import "XZXinXiangDetailViewController.h"

@interface XZXinXiangViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation XZXinXiangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"校长信箱";
    [self setUI];
    [self loadData];
}

- (void)setUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"XZEmailListTableViewCell" bundle:nil] forCellReuseIdentifier:@"EmailCell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    self.dataSource = [NSMutableArray array];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    [service getEmailListWithUserId:shareInfo.userId page:1 callBack:^(BOOL isSuccess, NSArray *emailList) {
        if (isSuccess) {
            [weakSelf.dataSource addObjectsFromArray:emailList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XZEmailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmailCell"];
    XZEmailModel *emailModel = self.dataSource[indexPath.row];
    [cell setUIWithModel:emailModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XZXinXiangDetailViewController *detailVC = [[XZXinXiangDetailViewController alloc] init];
    detailVC.emailModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:true];
}

@end
