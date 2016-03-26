//
//  UITextField+CustomStyle.h
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CustomStyle)

- (void)setTextFieldLeftPaddingforWidth:(CGFloat)leftWidth;

/**设置左视图（登录界面）*/
- (void)setTextFieldLeftPadding:(NSString *)imageName;

/**设置带右下拉图标的textfield*/
- (void)setTextFieldRightPaddingList;

/**设置带右搜索图标的textfield*/
- (void)setTextFieldRightPaddingSearch;

- (BOOL)isEmpty;

@end
