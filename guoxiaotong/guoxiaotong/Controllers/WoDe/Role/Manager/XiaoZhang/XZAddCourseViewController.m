//
//  XZAddCourseViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZAddCourseViewController.h"
#import "ManagerService.h"

@interface XZAddCourseViewController ()

@property (nonatomic, strong) UIView *iconsBackView;
@property (nonatomic, strong) UIButton *courseIconButton;
@property (nonatomic, strong) UIView *bottomBackView;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) NSInteger num_x;
@property (nonatomic, assign) NSInteger num_y;
@property (nonatomic, assign) CGFloat wid;
@property (nonatomic, assign) CGFloat step;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, assign) NSInteger iconId;

@end

@implementation XZAddCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加课程";
    [self setUI];
}

- (void)setUI {
    _show = YES;
    UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 40)];
    iconLabel.text = @"课程图标：";
    [self.scrollView addSubview:iconLabel];
    
    _courseIconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _courseIconButton.frame = CGRectMake(CGRectGetMaxX(iconLabel.frame), 10, 35, 35);
    [_courseIconButton setImage:[UIImage imageNamed:@"icon_course_1"] forState:UIControlStateNormal];
    _iconId = 1;
    [_courseIconButton addTarget:self action:@selector(switchIconBackView) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_courseIconButton];
    
    UILabel *border = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconLabel.frame)-0.5, WIDTH, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:border];
    
    _wid = 45;
    _num_x = (WIDTH-20)/(_wid+20);
    if (16%_num_x == 0) {
        _num_y = 16/_num_x;
    }else {
        _num_y = 16/_num_x + 1 ;
    }
    _step = (WIDTH-40-_num_x*_wid)/(_num_x-1);
    _iconsBackView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(iconLabel.frame)+20, WIDTH-20, 40+_num_y*_wid+_step*(_num_y-1))];
    _iconsBackView.layer.cornerRadius = 5;
    _iconsBackView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _iconsBackView.layer.borderWidth = 0.5;
    if (_show) {
        [self setButtons];
    }
    [self.scrollView addSubview:_iconsBackView];
    
    [self setBottom];
}

- (void)setButtons {
    for (NSInteger index = 0; index < 16; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+(_step+_wid)*(index%_num_x), 10+(_step+_wid)*(index/_num_x), _wid, _wid);
        button.tag = 101+index;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_course_%ld", index+1]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_iconsBackView addSubview:button];
    }
}

- (void)setBottom {
    if (_show) {
        _bottomBackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconsBackView.frame)+5, WIDTH, 200)];
    }else {
        _bottomBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, WIDTH, 200)];
    }
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
    nameLabel.text = @"课程名称：";
    [_bottomBackView addSubview:nameLabel];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(120, 20, WIDTH-140, 30)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.placeholder = @"请输入课程名称";
    [_bottomBackView addSubview:_nameTextField];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake((WIDTH-120)/2, 100, 120, 30);
    sureButton.backgroundColor = [UIColor greenColor];
    [sureButton setTitle:@"确认添加" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureAdd) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBackView addSubview:sureButton];
    [self.scrollView addSubview:_bottomBackView];
}

- (void)switchIconBackView {
    NSLog(@"switch");
    _show = !self.show;
    if (self.show) {
        self.iconsBackView.hidden = NO;
        self.bottomBackView.frame = CGRectMake(0, CGRectGetMaxY(_iconsBackView.frame)+5, WIDTH, 200);
    }else {
        self.iconsBackView.hidden = YES;
        self.bottomBackView.frame = CGRectMake(0, 45, WIDTH, 200);
    }
}

- (void)buttonClick:(UIButton *)btn {
    NSInteger index = btn.tag - 100;
    [_courseIconButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_course_%ld", index]] forState:UIControlStateNormal];
    _iconId = index;
    [self switchIconBackView];
}

- (void)sureAdd {
    ManagerService *service = [[ManagerService alloc] initWithView:self.view];
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSDictionary *params = @{@"schoolId": [NSNumber numberWithInteger: _roleInfo.schoolId], @"courseName": self.nameTextField.text, @"icon": [NSNumber numberWithInteger: self.iconId], @"userId": shareInfo.userId};
    __weak typeof (*&self)weakSelf = self;
    [service addCourseWith:params callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.navigationController popViewControllerAnimated:true];
        }
    }];
}

@end
