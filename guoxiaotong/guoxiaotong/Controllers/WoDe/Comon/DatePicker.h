//
//  DatePicker.h
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePicker : UIView

@property (nonatomic, copy) void (^dateCallBack)(NSString *dateString);
- (instancetype)initDate:(NSString *)dateString;

@end
