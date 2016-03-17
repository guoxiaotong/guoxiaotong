//
//  XZSchoolInfoViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZSchoolInfoViewController.h"

@interface XZSchoolInfoViewController ()

@property (nonatomic, assign)CGFloat headerHeight;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *headerLabel;

@end

@implementation XZSchoolInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"学校信息";
    [self setUI];
}

- (void)setUI {
    _headerHeight = 200;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, _headerHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, WIDTH-40, _headerHeight-60)];
    _imageV.backgroundColor = [UIColor redColor];
    [headerView addSubview: _imageV];
    
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_imageV.frame)+10, WIDTH-40, 30)];
    _headerLabel.textColor = [UIColor blackColor];
    [headerView addSubview: _headerLabel];
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;
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
