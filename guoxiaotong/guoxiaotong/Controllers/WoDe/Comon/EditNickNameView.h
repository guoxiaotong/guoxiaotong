//
//  EditNickNameView.h
//  guoxiaotong
//
//  Created by zxc on 16/3/24.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditNickNameView : UIView

@property (nonatomic, copy) void (^sureCallBack)(NSString *name);

- (void)hide;

@end
