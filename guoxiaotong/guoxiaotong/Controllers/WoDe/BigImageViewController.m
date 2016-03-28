//
//  BigImageViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/28.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BigImageViewController.h"
#import "Tools.h"

@interface BigImageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    _scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scroll.backgroundColor = [UIColor blackColor];
    _scroll.bounces = NO;
    [self.view addSubview:_scroll];
    
    _imageView = [[UIImageView alloc] initWithImage:_image];
    _imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap)];
    doubleTap.numberOfTapsRequired = 2;
    [_imageView addGestureRecognizer:doubleTap];
    
    UIPinchGestureRecognizer *pich = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pich:)];
    [_imageView addGestureRecognizer:pich];
    
    [_scroll addSubview:_imageView];
    _scroll.maximumZoomScale = 2;
    _scroll.minimumZoomScale = 0.5;
    _scroll.delegate = self;
}

- (void)doubleTap {
    if (_imageView.frame.size.width == _image.size.width) {

    }else {
        
    }
}

- (void)pich:(UIPinchGestureRecognizer *)pich {
    _imageView.transform = CGAffineTransformScale(_imageView.transform, pich.scale, pich.scale) ;
    pich.scale = 1.0 ;
}

@end
