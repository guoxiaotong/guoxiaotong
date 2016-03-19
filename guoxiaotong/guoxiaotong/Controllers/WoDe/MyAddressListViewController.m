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

@interface MyAddressListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UITextField *searchTextField;
@property (nonatomic, assign)CGFloat bottomHeight;
@property (nonatomic, assign)CGFloat searchHeight;
@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation MyAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:200/225.0 green:200/225.0 blue:200/225.0 alpha:1.0];
    self.navigationItem.title = @"我的通讯录";
    [self setUI];
    [self loadData];
}

- (void)loadData {
    self.dataSource = [NSMutableArray array];
}

- (void)setUI {
    self.bottomHeight = 64;
    self.searchHeight = 40;

    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 5, WIDTH-40, 30)];
    self.searchTextField.backgroundColor = [UIColor whiteColor];
    self.searchTextField.placeholder = @"sosuo";
    [self.view addSubview:self.searchTextField];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchHeight, WIDTH, HEIGHT-64-self.bottomHeight-self.searchHeight) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithRed:200/225.0 green:200/225.0 blue:200/225.0 alpha:1.0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"ContactTableViewCell" bundle:nil] forCellReuseIdentifier:@"ContactCell"];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    GroupModel *group = self.dataSource[section];
//    //在这里进行判断，如果该组收拢，那就返回0行，如果该组打开，就返回实际的行数
//    if (group.isOpen) {
//    // 代表要展开
//    return group.members.count;
//    }else {
//    // 代表要合拢
//    return 0;
//    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SectionHeaderView *headerview=[[SectionHeaderView alloc] initWithTitle:@"fenzu" isOpen:NO];
    //设置头部视图的数据
    headerview.SectionBlock = ^(NSInteger index, BOOL isOpen) {
        //点击操作
    };
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    return cell;
}

#pragma mark - headerDelegate
- (void)headerViewDidClickHeaderView:(SectionHeaderView *)headerView {
    [self.tableView reloadData];
}


@end
