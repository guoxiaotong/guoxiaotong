//
//  XZCourseManageViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZCourseManageViewController.h"
#import "XZEditCourseViewController.h"

@interface XZCourseManageViewController ()

@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation XZCourseManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"课程管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCourse)];
    [self setUI];
}

- (void)setUI {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


- (void)addCourse {
    UIStoryboard *xiaozhang = [UIStoryboard storyboardWithName:@"XiaoZhangManager" bundle:nil];
    UIViewController *addCourse = [xiaozhang instantiateViewControllerWithIdentifier:@"ADDCOURSE"];
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XZEditCourseViewController *edit = [[XZEditCourseViewController alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
}


@end
