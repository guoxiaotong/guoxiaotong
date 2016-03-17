//
//  BaseScrollViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BaseScrollViewController.h"

@interface BaseScrollViewController ()

@end

@implementation BaseScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setScrollView];
}

- (void)setScrollView {
    if (!self.scrollView) {
        if (!_scrollViewColor) {
            _scrollViewColor = [UIColor whiteColor];
        }
        if (_scrollViewFrame.size.width == 0) {
            _scrollViewFrame = CGRectMake(0, 0, WIDTH, HEIGHT - 64);//几乎都有导航栏
        }
        _scrollView = [[UIScrollView alloc] initWithFrame: _scrollViewFrame];
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT * 2);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.backgroundColor = _scrollViewColor;
        [self.view addSubview: _scrollView];
    }
}


@end
