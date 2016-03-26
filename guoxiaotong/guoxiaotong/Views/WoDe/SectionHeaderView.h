//
//  SectionHeaderView.h
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL open;

@property (nonatomic, copy) void (^SectionBlock)(NSInteger index, BOOL isOpen);

- (instancetype)initWithTitle:(NSString *)title isOpen:(BOOL)isOpen;

@end
