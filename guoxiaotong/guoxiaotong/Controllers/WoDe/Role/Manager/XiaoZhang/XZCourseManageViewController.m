//
//  XZCourseManageViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZCourseManageViewController.h"
#import "XZEditCourseViewController.h"
#import "ManagerService.h"
#import "CourseModel.h"
#import "XZAddCourseViewController.h"

@interface XZCourseManageViewController ()

@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation XZCourseManageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"课程管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCourse)];
    _dataSource = [NSMutableArray array];
    [self setUI];
}

- (void)setUI {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    [service getCourseList:_roleInfo.schoolId page:1 callBack:^(BOOL isSuccess, NSArray *courseList) {
        if (isSuccess) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf.dataSource addObjectsFromArray:courseList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)addCourse {
    XZAddCourseViewController *addCourse = [[XZAddCourseViewController alloc] init];
    addCourse.roleInfo = self.roleInfo;
    [self.navigationController pushViewController:addCourse animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    CourseModel *courseInfo = self.dataSource[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_course_%@",courseInfo.memo]];
    cell.textLabel.text = courseInfo.courseName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XZEditCourseViewController *edit = [[XZEditCourseViewController alloc] init];
    edit.courseModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:edit animated:YES];
}


@end
