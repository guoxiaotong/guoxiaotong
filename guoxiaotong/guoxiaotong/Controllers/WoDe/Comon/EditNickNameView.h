//
//  EditNickNameView.h
//  guoxiaotong
//
//  Created by zxc on 16/3/24.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditNickNameView : UIView

/**确定回调*/
@property (nonatomic, copy) void (^sureCallBack)(NSString *name);

/**关闭弹窗*/
- (void)hide;

@end
