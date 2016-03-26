//
//  AppDelegate.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "AppDelegate.h"
#import "GXTTabBarController.h"
#import "GXTNavigationController.h"
#import "LoginViewController.h"
//#import <EaseMobSDKFull/EaseMob.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    [self.window makeKeyAndVisible];
    
//    //registerSDKWithAppKey:注册的appKey，详细见下面注释。
//    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
//    [[EaseMob sharedInstance] registerSDKWithAppKey:@"douser#istore" apnsCertName:@"istore_dev"];
//    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self enterNextViewController];
    return YES;
}

- (void)enterNextViewController {
    BOOL isLogin = NO;
    if (!isLogin) {
        [self enterLoginViewController];
    }else {
        [self login];
    }
}

- (void)login {
    GXTTabBarController *tabBarController = [[GXTTabBarController alloc] init];
    self.window.rootViewController = tabBarController;
}

- (void)enterLoginViewController {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    GXTNavigationController *navi = [[GXTNavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = navi;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//     [[EaseMob sharedInstance] applicationWillTerminate:application];
}

@end
