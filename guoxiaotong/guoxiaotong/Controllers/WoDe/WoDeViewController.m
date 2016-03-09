//
//  WoDeViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "WoDeViewController.h"

@interface WoDeViewController ()

@property (nonatomic, strong)NSDictionary *myList;

@end

@implementation WoDeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self setTableHeaderView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setUpDataSourse];
    
    [self.tableView reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)setTableHeaderView {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    header.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = header;
}

- (void)setUpDataSourse {
    NSArray *icons = @[@"myList_ziliao",
                       @"myList_jiaose",
                       @"myList_tongxunlu",
                       @"myList_shoucang",
                       @"myList_renwu",
                       @"myList_jifen",
                       @"myList_jinbi",
                       @"myList_dongtai"];
    NSArray *titles = @[@"我的资料",
                        @"我的角色",
                        @"我的通讯录",
                        @"我的收藏",
                        @"我的任务",
                        @"我的积分",
                        @"我的金币",
                        @"我的动态",];
    NSArray *viewControllersName = @[@"MyProfileViewController",
                                     @"RoleListViewController",
                                     @"MyAddressListViewController",
                                     @"MyCollectionViewController",
                                     @"Nil",
                                     @"Nil",
                                     @"Nil",
                                     @"MyTrendsViewController"];
    
    self.myList = @{@"icons": icons, @"titles": titles, @"vcsName": viewControllersName};
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *icons = self.myList[@"icons"];
    return  icons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *icons = self.myList[@"icons"];
    NSArray *titles = self.myList[@"titles"];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(@"cell")];
    NSString *path = [[NSBundle mainBundle] pathForResource:icons[indexPath.row] ofType:@"png"];

    cell.imageView.image = [UIImage imageNamed:icons[indexPath.row]];
    cell.textLabel.text = titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
