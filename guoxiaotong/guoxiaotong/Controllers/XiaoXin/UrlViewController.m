//
//  UrlViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "UrlViewController.h"

@interface UrlViewController ()

@end

@implementation UrlViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//    self.navigationItem.title=@"agfgvdf";
//    
//    self.tabBarController.tabBar.hidden=YES;
//
//}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.navigationItem.title=self.titelStr;
    
    self.tabBarController.tabBar.hidden=YES;

}

- (void)viewDidLoad {
    
    UIBarButtonItem *liftBut=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(leftButClick)];
    
    self.navigationItem.leftBarButtonItem=liftBut;
    
    [super viewDidLoad];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height+tabBar_Height)];
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.httpStr]]];
    

    [self.view addSubview:webview];
}

-(void)leftButClick{

    [self.navigationController popToRootViewControllerAnimated:YES];


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
