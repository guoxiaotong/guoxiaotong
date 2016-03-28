//
//  UploadView.h
//  guoxiaotong
//
//  Created by zxc on 16/3/25.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadView : UIView

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *picPath;
@property (nonatomic, copy) void (^delCallBack)(NSInteger index, NSString *picPath);

@end
