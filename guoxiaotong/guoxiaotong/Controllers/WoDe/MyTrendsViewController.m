//
//  MyTrendsViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "MyTrendsViewController.h"
#import "TrendsTableViewCell.h"
#import "TrendModel.h"
#import "BasicService.h"

@interface MyTrendsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, assign) NSInteger numsOfButton;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MyTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的动态";
    _dataSource = [NSMutableArray array];
    [self setUI];
    [self clickOn:(UIButton *)[_headerView viewWithTag:180]];
}

- (void)setUI {
    _numsOfButton = 3;
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    _headerView.backgroundColor = SEAECH_VIEW_BACK_COLOR;
    [self.view addSubview:_headerView];
    
    [self addButton:@"分享" index:0];
    [self addButton:@"通知" index:1];
    [self addButton:@"直通车" index:2];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-104) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[TrendsTableViewCell class] forCellReuseIdentifier:@"TrendCell"];
}

- (void)addButton:(NSString *)title index:(NSInteger)index {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = (WIDTH - (_numsOfButton+1)*5)/_numsOfButton;
    button.frame = CGRectMake(5+(width+5)*index, 5, width,30);
    button.layer.cornerRadius = 5;
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.tag = 180+index;
    [button addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchDown];
    [_headerView addSubview:button];
}

- (void)loadData:(NSString *)type {
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    __weak typeof (*&self)weakSelf = self;
    BasicService *service = [[BasicService alloc] initWithView:self.view];
    NSDictionary *params = @{@"userId": shareInfo.userId, @"userRoleId": [NSNumber numberWithInteger:538], @"mine": @"mySend",@"sendType": @"2", @"type": type, @"page": @"1"};

    [service getCollectTrendList:params callBack:^(BOOL isSuccess, NSArray *trendList) {
        [weakSelf.dataSource removeAllObjects];
        [weakSelf.tableView reloadData];
        [weakSelf.dataSource addObjectsFromArray:trendList];
        [weakSelf.tableView reloadData];
    }];
}

- (void)clickOn:(UIButton *)btn {
    for (UIView *view in _headerView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    btn.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSInteger index = btn.tag - 180;
    switch (index) {
        case 0:
            [self loadData:@"1"];
            break;
        case 1:
            [self loadData:@"0"];
            break;
        case 2:
            [self loadData:@"2"];
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TrendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrendCell"];
    TrendModel *model = self.dataSource[indexPath.section];
    [cell setUIWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count) {
        TrendsTableViewCell *cell = (TrendsTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHeight;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else {
        return 0.001;
    }
}

@end
