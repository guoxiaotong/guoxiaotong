//
//  GXTTabBarController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "GXTTabBarController.h"
#import "GXTTabBar.h"
#import "GXTNavigationController.h"

@interface GXTTabBarController ()

@end

@implementation GXTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor redColor];
    [self setUpUI];
}

- (void)setUpUI {
  
    NSArray *itemsTitles = @[@"校信", @"动态", @"学库", @"课外", @"我的"];
    NSArray *itemsImagesNomal = @[@"tab_xiaoxin_nomal",
                                  @"tab_dongtai_nomal",
                                  @"tab_ziyuan_nomal",
                                  @"tab_zhoubian_nomal",
                                  @"tab_wode_nomal"];
    NSArray *itemsImagesSelected = @[@"tab_xiaoxin_selected",
                                     @"tab_dongtai_selected",
                                     @"tab_ziyuan_selected",
                                     @"tab_zhoubian_selected",
                                     @"tab_wode_selected"];
    NSArray *viewControllersName = @[@"XiaoXinViewController",
                                   @"DongTaiViewController",
                                   @"ZiYuanViewController",
                                   @"ZhouBianViewController",
                                   @"WoDeViewController"];
  
    for (NSInteger index = 0; index < 5; index++) {
        Class viewControllerClass = NSClassFromString(viewControllersName[index]);
        UIViewController *viewController = [[viewControllerClass alloc] init];
        viewController.tabBarItem = [[UITabBarItem alloc]
                                 initWithTitle: itemsTitles[index]
                                 image: [UIImage imageNamed: itemsImagesNomal[index]]selectedImage: [self orginalImage:itemsImagesSelected[index]]];
        GXTNavigationController *navi = [[GXTNavigationController alloc] initWithRootViewController:viewController];
        viewController.navigationItem.title = itemsTitles[index];
        [self addChildViewController:navi];
    }
}

- (UIImage *)orginalImage:(NSString *)imageName {
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
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
