//
//  SwitchTableViewCell.h
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *switchButton;
@property (assign, nonatomic, getter=isOpen) BOOL open;
@property (assign, nonatomic) NSInteger index;
@property (copy, nonatomic) void (^SwitchBlock) (NSInteger index, BOOL open);

- (void)switchNotifictionState;

@end
