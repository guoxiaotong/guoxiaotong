//
//  AddRoleViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "AddRoleViewController.h"
#import "AddChildViewController.h"
#import "AddXiaoZhangViewController.h"

@interface AddRoleViewController ()

@end

@implementation AddRoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加角色";
    [self setUI];
}

- (void)setUI {
    
    [self viewWithButtonTitle:@"添加子女" text:@"我是家长" index:0];
    [self viewWithButtonTitle:@"申请校长" text:@"添加我为校长" index:1];

}

- (void)viewWithButtonTitle:(NSString *)title text:(NSString *)text index:(NSInteger)index {
    UIFont *font = [UIFont systemFontOfSize:15.0];
    CGRect frame = CGRectMake(0, 40+100*index, WIDTH, 100);
    CGFloat width = 200;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((WIDTH-width)/2, 0, width, 40);
    button.layer.borderColor = [UIColor blackColor].CGColor;
    button.layer.borderWidth = 0.5;
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    button.tag = 300+index;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH-width)/2, 40, width, 40)];
    textLabel.font = font;
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.text = text;
    [view addSubview:textLabel];
    
    [self.view addSubview:view];
    
    
}

//  颜色转换为背景图片
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)addButtonClick:(UIButton *)btn {
    NSInteger index = btn.tag - 300;
    if (index == 0) {
        //添加子女
        AddChildViewController *addChild = [[AddChildViewController alloc] init];
        [self.navigationController pushViewController:addChild animated:YES];
    }else {
        AddXiaoZhangViewController *addXZ = [[AddXiaoZhangViewController alloc] init];
        [self.navigationController pushViewController:addXZ animated:YES];
    }
}

@end
