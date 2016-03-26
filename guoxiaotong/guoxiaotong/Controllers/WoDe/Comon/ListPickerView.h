//
//  ListPickerView.h
//  guoxiaotong
//
//  Created by zxc on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListPickerView : UIView

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, copy) void (^SureCallBack)(id model);

- (void)show;

- (void)hide;

@end
