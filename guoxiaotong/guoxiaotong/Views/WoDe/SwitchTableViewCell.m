//
//  SwitchTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "SwitchTableViewCell.h"

@implementation SwitchTableViewCell

- (void)setState:(NSString *)permission index:(NSInteger)index {
    _index = index;
    if ([permission isEqualToString:@"0"]) {
        _open = NO;
    }else {
        _open = YES;
    }
    [self switchImage];
}

- (void)awakeFromNib {
    [self.switchButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)click {
    self.open = !self.open;
    [self  switchImage];
    [self switchNotifictionState];
}

- (void)switchImage {
    if (_open) {
        [self.switchButton setBackgroundImage:[UIImage imageNamed:@"button_switch_on"] forState:UIControlStateNormal];
    }else {
        [self.switchButton setBackgroundImage:[UIImage imageNamed:@"button_switch_off"] forState:UIControlStateNormal];
    }
}

- (void)switchNotifictionState {
    if (self.SwitchBlock) {
        self.SwitchBlock(self.index, self.open);
    }
}

@end
