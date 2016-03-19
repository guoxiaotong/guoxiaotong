//
//  JZStudentInfoViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "JZStudentInfoViewController.h"
#import "ImageHeaderView.h"

@interface JZStudentInfoViewController ()

@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

@end

@implementation JZStudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"学生信息";
    [self setUI];
    [self loadData];
}

#pragma mark - 设置导航栏下分割线在本页面不显示
- (void)viewWillAppear:(BOOL)animated {
    self.navBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navBarHairlineImageView.hidden = NO;
}

- (UIImageView *)findHairlineImageViewUnder: (UIView *)view {
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return (UIImageView *)view;
    }
    for(UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setUI {
    ImageHeaderView *header = [[ImageHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 150)];
    header.imageView.image = [UIImage imageNamed:@"manager_role_student_pic"];
    header.detailLabel.text = _roleInfo.schoolName;
    [self.view addSubview:header];
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
