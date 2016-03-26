//
//  WoDeTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "WoDeTableViewCell.h"

@implementation WoDeTableViewCell

- (void)awakeFromNib {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setImage:(NSString *)imageName text:(NSString *)text {
    self.imageV.image = [UIImage imageNamed:imageName];
    self.titleLabel.text = text;
}

@end
