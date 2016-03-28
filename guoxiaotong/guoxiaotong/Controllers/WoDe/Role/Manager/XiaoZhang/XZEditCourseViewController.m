//
//  XZEditCourseViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZEditCourseViewController.h"
#import "ManagerService.h"

@interface XZEditCourseViewController ()

@end

@implementation XZEditCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改课程";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(delete)];
}

- (void)setUI {
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_course_%@", _courseModel.memo]];
    [self.view addSubview:imageV];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 120, 30)];
    nameLabel.text = _courseModel.courseName;
    [self.view addSubview:nameLabel];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, WIDTH-20, 21)];
    detailLabel.text = @"科目详细信息";
    [self.view addSubview:detailLabel];
    
}

- (void)delete {
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    __weak typeof (*&self)weakSelf = self;
    [service deleteCourseWithCourseId:[NSString stringWithFormat:@"%ld", _courseModel.courseId] callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:true];
        }
    }];
}

@end
