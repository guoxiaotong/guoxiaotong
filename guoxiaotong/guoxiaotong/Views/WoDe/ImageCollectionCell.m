//
//  ImageCollectionCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ImageCollectionCell.h"
#import "ImageModel.h"

@interface ImageCollectionCell()

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation ImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
        [_imageV addGestureRecognizer:tap];
        
        [self addSubview:_imageV];
    }
    return self;
}

- (void)setUIWithModel:(id)model {
    ImageModel *imageInfo = model;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_ROOT_IMAGE_URL, imageInfo.imageUrl]];
    [_imageV sd_setImageWithURL:url placeholderImage:nil];

}

- (void)imageTap {
    if (_imageTapCallBack) {
        _imageTapCallBack(_imageV.image);
    }
}

@end
