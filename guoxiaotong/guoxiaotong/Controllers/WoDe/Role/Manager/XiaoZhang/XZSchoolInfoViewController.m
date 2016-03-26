//
//  XZSchoolInfoViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZSchoolInfoViewController.h"
#import "ManagerService.h"

@interface XZSchoolInfoViewController ()

@property (nonatomic, assign)CGFloat headerHeight;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *headerLabel;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation XZSchoolInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"学校信息";
    [self setUI];
    [self loadData];
}

- (void)setUI {
    _headerHeight = 200;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, _headerHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, WIDTH-40, _headerHeight-60)];
    [headerView addSubview: _imageV];
    
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_imageV.frame)+10, WIDTH-40, 30)];
    _headerLabel.textColor = [UIColor blackColor];
    [headerView addSubview: _headerLabel];
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)loadData {
    self.dataSource = [NSMutableArray array];
    __weak typeof (*&self)weakSelf = self;
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    [service getSchoolInfo:_roleInfo.schoolId callBack:^(BOOL isSuccess, SchoolModel *schoolInfo) {
        if (isSuccess) {
            [weakSelf.imageV sd_setImageWithURL:[NSURL URLWithString:schoolInfo.thumb] placeholderImage:[UIImage imageNamed:@"schoolInfo_placeholder"]];
            weakSelf.headerLabel.text = schoolInfo.name;
            [weakSelf.dataSource addObject:[NSString stringWithFormat:@"简称：%@", schoolInfo.subname]];
            [weakSelf.dataSource addObject:[NSString stringWithFormat:@"学校性质：%@", schoolInfo.attribute]];
            [weakSelf.dataSource addObject:[NSString stringWithFormat:@"校长：%@", schoolInfo.attribute]];
            [weakSelf.dataSource addObject:[NSString stringWithFormat:@"联系人：%@", schoolInfo.attribute]];
            [weakSelf.dataSource addObject:[NSString stringWithFormat:@"联系电话：%@", schoolInfo.attribute]];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}


@end
