//
//  BZRCourseManageViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BZRCourseManageViewController.h"
#import "BZRCourseModel.h"
#import "BZRManagerService.h"

@interface BZRCourseManageViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation BZRCourseManageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"课程管理";
    [self setUI];
}

- (void)setUI {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WIDTH-20, 30)];
    textLabel.text = [NSString stringWithFormat:@"%@课程管理", _roleInfo.className];
    [header addSubview:textLabel];
    
    self.tableView.tableHeaderView = header;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)loadData {
    _dataSource = [NSMutableArray array];
    __weak typeof (*&self)weakSelf = self;
    BZRManagerService *service = [[BZRManagerService alloc] initWithView:self.view];
    [service getCourseList:_roleInfo.classId page:1 callBack:^(BOOL isSuccess, NSArray *courseList) {
        if (isSuccess) {
            [weakSelf.dataSource addObjectsFromArray:courseList];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    BZRCourseModel *coursrModel = self.dataSource[indexPath.row];
    cell.textLabel.text = coursrModel.courseName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置老师
    
}

@end
