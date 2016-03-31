//
//  BZRClassInfoViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BZRClassInfoViewController.h"
#import "BZRCourseModel.h"
#import "BZRManagerService.h"

@interface BZRClassInfoViewController ()

@end

@implementation BZRClassInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"班级信息";
    [self setUI];
}

- (void)setUI {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 30)];
    titleLabel.text = @"班级";
    [self.view addSubview:titleLabel];
    
    UILabel *classLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, WIDTH-140, 30)];
    classLabel.textAlignment = NSTextAlignmentCenter;
    classLabel.text = _roleInfo.className;
    [self.view addSubview:classLabel];
    
    UILabel *border = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:border];
}

@end
