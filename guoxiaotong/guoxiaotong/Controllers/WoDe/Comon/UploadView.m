
//
//  UploadView.m
//  guoxiaotong
//
//  Created by zxc on 16/3/25.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "UploadView.h"

@implementation UploadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageV];
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(-5, -5, 20, 20);
        _button.clipsToBounds = YES;
        _button.layer.cornerRadius = 10;
//        _button.backgroundColor = [UIColor blackColor];
        [_button setImage:[UIImage imageNamed:@"button_del_icon"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    return self;
}

- (void)buttonClick {
    if (_delCallBack) {
        _delCallBack(_index, _picPath);
    }
}

@end
