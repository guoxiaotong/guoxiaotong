//
//  JZStudentInfoViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "JZStudentInfoViewController.h"

@interface JZStudentInfoViewController ()

@end

@implementation JZStudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"学生信息";
    [self setUI];
    [self loadData];
}


- (void)setUI {
    self.header.imageView.image = [UIImage imageNamed:@"manager_role_student_pic"];
    self.header.detailLabel.text = _roleInfo.schoolName;
    [self cellWithTitle:@"姓名：" detail:_roleInfo.studentName index:0];
    [self cellWithTitle:@"班级：" detail:_roleInfo.className index:1];
    
}

- (void)cellWithTitle:(NSString *)title detail:(NSString *)detail index:(NSInteger)index {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 150+50*index, WIDTH, 50)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
    titleLabel.text = title;
    [view addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, WIDTH-140, 30)];
    detailLabel.text = detail;
    [view addSubview:detailLabel];
    
    UILabel *border = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, WIDTH, 1)];
    border.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:border];
    
    [self.view addSubview:view];
}

- (void)loadData {
    
}

@end
