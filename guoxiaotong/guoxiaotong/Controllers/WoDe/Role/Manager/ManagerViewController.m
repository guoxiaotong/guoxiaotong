//
//  ManagerViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ManagerViewController.h"
//xiaozhang
#import "XZSchoolInfoViewController.h"
#import "XZCourseManageViewController.h"
#import "XZClassManageViewController.h"
#import "XZBZRManageViewController.h"
#import "XZTeacherManageViewController.h"
#import "XZXinXiangViewController.h"
#import "XZSchoolQuanXianViewController.h"
//banzhuren
#import "BZRClassInfoViewController.h"
#import "BZRCourseManageViewController.h"
#import "BZRStudentManageViewController.h"
#import "BZRAddStudentViewController.h"
#import "BZRQuanXianViewController.h"
//jiazhang
#import "JZStudentInfoViewController.h"
#import "JZMemberManageViewController.h"
#import "JZQuanXianViewController.h"


@interface ManagerViewController ()
@property (nonatomic, strong)NSArray *managersImage;
@property (nonatomic, strong)NSArray *managersTitle;
@property (nonatomic, strong)NSArray *managersViewController;
@property (nonatomic, strong)UIScrollView *backScroll;
@end

@implementation ManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setUI];
}

- (void)xiaozhangSet {
    self.managersImage = @[@"manager_school_xiaozhang",
                           @"manager_courses_xiaozhang",
                           @"manager_classes_xiaozhang",
                           @"manager_banzhuren_xiaozhang",
                           @"manager_techer_xiaozhang",
                           @"manager_xinxiang_xiaozhang",
                           @"manager_quanxian_xiaozhang"];
    self.managersTitle = @[@"学校信息",
                           @"课程管理",
                           @"班级管理",
                           @"班主任管理",
                           @"教师管理",
                           @"校长信箱",
                           @"学校权限设置"];
}

- (void)banzhurenSet {
    self.managersImage = @[@"manager_class_bzr",
                           @"manager_courses_bzr",
                           @"manager_students_bzr",
                           @"manager_addStudent_bzr",
                           @"manager_quanxian_bzr"];
    self.managersTitle = @[@"班级信息",
                           @"课程管理",
                           @"学生管理",
                           @"添加学生",
                           @"老师权限设置"];

}

- (void)jianhurenSet {
    self.managersImage = @[@"manager_student_jz",
                           @"manager_member_jz",
                           @"manager_quanxian_jz"];
    self.managersTitle = @[@"学生信息",
                           @"成员管理",
                           @"成员权限设置"];
}

- (void)loadData {
    self.navigationItem.title = [NSString stringWithFormat:@"%@管理", _roleInfo.roleName];
    //判断角色
    switch (_roleInfo.roleId) {
        case 1://校长
            [self xiaozhangSet];
            break;
        case 2://班主任
            [self banzhurenSet];
            break;
        case 3://教师

            break;
        case 4://监护人
            [self jianhurenSet];
            break;
        case 5://家长
        case 6://学生
        default:
            break;
    }
}

- (void)setUI {
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    [self setHeaderView];
    self.backScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.headerHeight, WIDTH, HEIGHT-64-self.headerHeight)];
    self.backScroll.contentOffset = CGPointMake(0, 0);
    self.backScroll.contentSize = CGSizeMake(WIDTH, HEIGHT);
    [self.view addSubview:self.backScroll];
    [self setManagerList];
}

- (void)setHeaderView {
    switch (_roleInfo.roleId) {
        case 1://校长
        {
            self.header.imageView.image = [UIImage imageNamed:@"manager_role_xiaozhang_pic"];
            self.header.detailLabel.text = _roleInfo.schoolName;
        }break;
        case 2://班主任
        {
            self.header.imageView.image = [UIImage imageNamed:@"manager_role_banzhuren_pic"];
            self.header.detailLabel.text = _roleInfo.className;
        }break;
        case 3://教师
            break;
        case 4://监护人
        {
            self.header.imageView.image = [UIImage imageNamed:@"manager_role_teacher_pic"];
            self.header.detailLabel.text = _roleInfo.schoolName;
        }break;
        case 5://家长
        case 6://学生
        default:
            break;
    }
}

- (void)setManagerList {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH+1)];
    CGFloat width = (WIDTH - 1)/3;
    backView.backgroundColor = [UIColor lightGrayColor];
    for (NSInteger index = 0; index < 9; index++) {
        UIButton *managerButton;
        CGRect frame = CGRectMake((index%3)*(width+0.5), index/3 * (width + 0.5)+0.5, width, width);
        if (self.managersImage.count > index) {
            managerButton = [self buttonWithImage:self.managersImage[index] title:self.managersTitle[index] frame:frame];
            managerButton.tag = 1001+index;
            [managerButton addTarget:self action:@selector(selectedManager:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            managerButton = [UIButton buttonWithType:UIButtonTypeCustom];
            managerButton.frame = frame;
        }
        managerButton.backgroundColor = [UIColor whiteColor];
        [backView addSubview:managerButton];
    }
    [self.backScroll addSubview:backView];
}

- (void)selectedManager:(UIButton *)btn {
    NSInteger index = btn.tag - 1001;
    //判断角色
    switch (_roleInfo.roleId) {
        case 1://校长
            [self xiaozhangManager:index];
            break;
        case 2://班主任
            [self banzhurenManager:index];
            break;
        case 3://教师
            
            break;
        case 4://监护人
            [self jianhurenManager:index];
            break;
        case 5://家长
        case 6://学生
        default:
            break;
    }
}

#pragma mark - 管理界面的跳转
- (void)xiaozhangManager:(NSInteger)index {
    switch (index) {
        case 0:
        {
            XZSchoolInfoViewController *infoVC = [[XZSchoolInfoViewController alloc] init];
            infoVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:infoVC animated:YES];
        }
            break;
        case 1:
        {
            XZCourseManageViewController *courseVC = [[XZCourseManageViewController alloc] init];
            courseVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:courseVC animated:YES];
        }
            break;
        case 2:
        {
            XZClassManageViewController *classVC = [[XZClassManageViewController alloc] init];
            classVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:classVC animated:YES];
        }
            break;
        case 3:
        {
            XZBZRManageViewController *bzrVC = [[XZBZRManageViewController alloc] init];
            bzrVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:bzrVC animated:YES];
        }
            break;
        case 4:
        {
            XZTeacherManageViewController *teacherVC = [[XZTeacherManageViewController alloc] init];
            teacherVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:teacherVC animated:YES];
        }
            break;
        case 5:
        {
            XZXinXiangViewController *xinxiangVC = [[XZXinXiangViewController alloc] init];
            xinxiangVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:xinxiangVC animated:YES];
        }
            break;
        case 6:
        {
            XZSchoolQuanXianViewController *quanxianVC = [[XZSchoolQuanXianViewController alloc] init];
            quanxianVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:quanxianVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)banzhurenManager:(NSInteger)index {
    switch (index) {
        case 0:
        {
            BZRClassInfoViewController *classInfoVC = [[BZRClassInfoViewController alloc] init];
            classInfoVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:classInfoVC animated:YES];
        }
            break;
        case 1:
        {
            BZRCourseManageViewController *courseManageVC = [[BZRCourseManageViewController alloc] init];
            courseManageVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:courseManageVC animated:YES];
        }
            break;
        case 2:
        {
            BZRStudentManageViewController *studentManageVC = [[BZRStudentManageViewController alloc] init];
            studentManageVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:studentManageVC animated:YES];
        }
            break;
        case 3:
        {
            BZRAddStudentViewController *addStudentVC = [[BZRAddStudentViewController alloc] init];
            addStudentVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:addStudentVC animated:YES];
        }
            break;
        case 4:
        {
            BZRQuanXianViewController *bzrQuanxianVC = [[BZRQuanXianViewController alloc] init];
            bzrQuanxianVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:bzrQuanxianVC animated:YES];
        }
            break;
            
        default:
            break;
    }

}

- (void)jianhurenManager:(NSInteger)index {
    switch (index) {
        case 0:
        {
            JZStudentInfoViewController *studentInfoVC = [[JZStudentInfoViewController alloc] init];
            studentInfoVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:studentInfoVC animated:YES];
        }
            break;
        case 1:
        {
            JZMemberManageViewController *memberVC = [[JZMemberManageViewController alloc] init];
            memberVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:memberVC animated:YES];
        }
            break;
        case 2:
        {
            JZQuanXianViewController *quanxianVC = [[JZQuanXianViewController alloc] init];
            quanxianVC.roleInfo = self.roleInfo;
            [self.navigationController pushViewController:quanxianVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 设置管理button
- (UIButton *)buttonWithImage:(NSString *)imageName title:(NSString *)title frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    CGFloat image_width = frame.size.width/2, image_left = image_width/2, image_top = 20;
    CGFloat title_top = 10, title_bottom = 10;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = CGRectMake(image_left, image_top, image_width, image_width);
    imageV.layer.cornerRadius = image_width/2;
    imageV.image = [UIImage imageNamed:imageName];
    [button addSubview:imageV];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, CGRectGetMaxY(imageV.frame)+title_top, frame.size.width, frame.size.height-image_width-image_top-title_bottom);
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.font = [UIFont systemFontOfSize:15.0];
    [button addSubview:label];
    
    return button;
}


@end
