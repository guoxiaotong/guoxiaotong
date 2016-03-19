//
//  XZClassManageViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZClassManageViewController.h"
#import "SectionHeaderView.h"
#import "ManagerService.h"
#import "ClassModel.h"
#import "GradeModel.h"
#import "BZRModel.h"

#import "XZSetBZRViewController.h"

@interface XZClassManageViewController ()

@property (nonatomic, strong)NSMutableArray *dataSource;

@end

@implementation XZClassManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"班级管理";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    [self setUI];
    [self loadData];
}

- (void)edit {
    
}

- (void)setUI {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)loadData {
    __weak typeof (*&self)weakSelf = self;
    self.dataSource = [NSMutableArray array];
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    [service getClassList:_roleInfo.schoolId callBack:^(BOOL isSuccess, NSArray *gradeList) {
        if (isSuccess) {
            [weakSelf.dataSource addObjectsFromArray:gradeList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GradeModel *gradeModel = self.dataSource[section];
    if (gradeModel.isOpen) {
        return gradeModel.classNum;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    GradeModel *gradeModel = self.dataSource[indexPath.section];
    ClassModel *classModel = gradeModel.classList[indexPath.row];
    BZRModel *bzrModel = classModel.bzrInfo;
    cell.textLabel.text = [NSString stringWithFormat:@"%@   %@",classModel.classesName, bzrModel.userName];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __weak typeof (*&self)weakSelf = self;
    GradeModel *gradeModel = self.dataSource[section];
    SectionHeaderView *headerview = [[SectionHeaderView alloc] initWithTitle: gradeModel.gradeName isOpen: gradeModel.isOpen];
    headerview.SectionBlock = ^(NSInteger index, BOOL isOpen) {
        gradeModel.open = isOpen;
        [weakSelf.tableView reloadData];
    };
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XZSetBZRViewController *setBZRVC = [[XZSetBZRViewController alloc] init];
    setBZRVC.roleInfo = self.roleInfo;
    [self.navigationController pushViewController:setBZRVC animated:true];
}

@end
