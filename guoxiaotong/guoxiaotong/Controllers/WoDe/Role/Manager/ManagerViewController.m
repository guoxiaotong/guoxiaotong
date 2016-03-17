//
//  ManagerViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ManagerViewController.h"
#import "ImageHeaderView.h"

@interface ManagerViewController ()

@property (nonatomic, assign)CGFloat headerHeight;
@property (nonatomic, strong)UIImageView *navBarHairlineImageView;
@property (nonatomic, strong)NSArray *managersImage;
@property (nonatomic, strong)NSArray *managersTitle;
@property (nonatomic, strong)NSArray *managersViewController;
@property (nonatomic, strong)UIScrollView *backScroll;
@end

@implementation ManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self setUI];
}

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
    self.managersViewController = @[@"XZSchoolInfoViewController",
                                    @"XZCourseManageViewController",
                                    @"XZClassManageViewController",
                                    @"XZBZRManageViewController",
                                    @"XZTeacherManageViewController",
                                    @"XZXinXiangViewController",
                                    @"XZSchoolQuanXianViewController"];
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
    self.managersViewController = @[@"BZRClassInfoViewController",
                                    @"BZRCourseManageViewController",
                                    @"BZRStudentManageViewController",
                                    @"BZRAddStudentViewController",
                                    @"BZRQuanXianViewController"];

}

- (void)jianhurenSet {
    self.managersImage = @[@"manager_student_jz",
                           @"manager_member_jz",
                           @"manager_quanxian_jz"];
    self.managersTitle = @[@"学生信息",
                           @"成员管理",
                           @"成员权限设置"];
    self.managersViewController = @[@"JZStudentInfoViewController",
                                    @"JZMemberManageViewController",
                                    @"JZQuanXianViewController"];
}

- (void)loadData {
    self.navigationItem.title = [NSString stringWithFormat:@"%@管理", self.roleName];
    //判断角色
    switch (_roleId) {
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
    _headerHeight = 150;
    ImageHeaderView *header = [[ImageHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, _headerHeight)];
    [self.view addSubview:header];
}

- (void)setManagerList {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH+2)];
    CGFloat width = (WIDTH - 2)/3;
    backView.backgroundColor = [UIColor lightGrayColor];
    for (NSInteger index = 0; index < 9; index++) {
        UIButton *managerButton;
        CGRect frame = CGRectMake((index%3)*(width+1), index/3 * (width + 1)+1, width, width);
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
    Class nextVCClass = NSClassFromString(self.managersViewController[index]);
    UIViewController *nextVC = [[nextVCClass alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

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
    [button addSubview:label];
    
    return button;
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
