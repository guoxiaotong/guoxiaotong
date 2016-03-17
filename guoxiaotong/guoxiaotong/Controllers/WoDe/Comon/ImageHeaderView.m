//
//  ImageHeaderView.m
//  guoxiaotong
//
//  Created by zxc on 16/3/16.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ImageHeaderView.h"

@implementation ImageHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat imageWidth = (frame.size.height - 40);
        UIColor *borderColor = [UIColor orangeColor];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.center.x-imageWidth/2, self.center.y-imageWidth/2-20, imageWidth, imageWidth)];
        _imageView.layer.borderColor = borderColor.CGColor;
        _imageView.layer.borderWidth = 5;
        _imageView.layer.cornerRadius = imageWidth/2;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-30, WIDTH, 30)];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.textColor = [UIColor whiteColor];
        [self addSubview:_detailLabel];
        self.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
    }
    return self;
}

@end
