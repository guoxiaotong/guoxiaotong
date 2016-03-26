//
//  XZEmailListTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZEmailListTableViewCell.h"
#import "XZEmailModel.h"

@implementation XZEmailListTableViewCell

- (void)setUIWithModel:(id)model {
    XZEmailModel *email = model;
    self.nameLabel.text = email.userInfo.userName;
    self.contentLabel.text = email.content;
    self.timeLabel.text = email.sendTime;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
