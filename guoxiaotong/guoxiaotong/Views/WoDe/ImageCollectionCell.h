//
//  ImageCollectionCell.h
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionCell : UICollectionViewCell

@property (nonatomic, copy) void (^imageTapCallBack)(UIImage *image);

- (void)setUIWithModel:(id)model;

@end
