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

@interface JZMemberManageViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation JZMemberManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"家长管理";
    [self setUI];
    [self loadData];
}

- (void)setUI {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadData {
    _dataSource = [NSMutableArray array];
    __weak typeof (*&self)weakSelf = self;
    JZManagerService *service = [[JZManagerService alloc] initWithView:self.view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"userId": shareInfo.userId, @"studentId": _roleInfo.studentId};
    [service getMemberList:params callBack:^(BOOL isSuccess, NSArray *memberList) {
        if (isSuccess) {
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
    cell.textLabel.text = memberModel.parentName;
    return cell;
}

@end
