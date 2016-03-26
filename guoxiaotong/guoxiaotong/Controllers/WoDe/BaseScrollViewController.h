//
//  BaseScrollViewController.h
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseScrollViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIColor *scrollViewColor;
@property (assign, nonatomic) CGRect scrollViewFrame;

- (void)setScrollView;

@end
