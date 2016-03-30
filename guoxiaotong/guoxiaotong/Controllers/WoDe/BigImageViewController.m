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
    
    _imageView = [[UIImageView alloc] initWithFrame:_scroll.bounds];
    _imageView.image = _image;
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
    if (_imageView.frame.size.width == _scroll.frame.size.width) {
        CGRect frame = _imageView.frame;
        
        frame.origin.x -= frame.size.width/2;
        frame.origin.y -= frame.size.height/2;
        frame.size.width *= 2;
        frame.size.height *= 2;
        _imageView.frame = frame;
    }else {
        _imageView.frame = _scroll.bounds;
    }
}

- (void)pich:(UIPinchGestureRecognizer *)pich {
    _imageView.transform = CGAffineTransformScale(_imageView.transform, pich.scale, pich.scale) ;
    pich.scale = 1.0 ;
}

@end
