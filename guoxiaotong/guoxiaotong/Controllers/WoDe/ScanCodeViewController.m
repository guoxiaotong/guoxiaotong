//
//  ScanCodeViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ScanCodeViewController.h"

@interface ScanCodeViewController ()

@end

@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"二维码扫描";
    [self setUI];
}

- (void)setUI {
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://main.ketangzhiwai.com/gxt/index.php/Home/App/app_qr_details"]]];
    [self.view addSubview:web];
}


@end
