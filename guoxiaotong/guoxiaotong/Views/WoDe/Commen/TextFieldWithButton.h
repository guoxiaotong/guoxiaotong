//
//  TextFieldWithButton.h
//  guoxiaotong
//
//  Created by zxc on 16/3/25.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldWithButton : UITextField

@property (nonatomic, copy) void (^buttonCallBack)();

- (instancetype)initEyeButtonWithFrame:(CGRect)frame;
- (instancetype)initSerachButtonWithFrame:(CGRect)frame;



@end
