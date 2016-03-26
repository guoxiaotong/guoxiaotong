//
//  HeaderViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "HeaderViewController.h"

@interface HeaderViewController ()

@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

@end

@implementation HeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //不显示分割线
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    _headerHeight = 150;
    _header = [[ImageHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, _headerHeight)];
    [self.view addSubview:_header];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
