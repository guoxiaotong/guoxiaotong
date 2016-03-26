//
//  AboutUsViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"关于我们";
    [self setUI];
}

- (void)setUI {
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://main.ketangzhiwai.com/gxt/index.php/Home/App/index_details"]]];
    [self.view addSubview:web];
}


@end
