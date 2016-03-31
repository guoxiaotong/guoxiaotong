//
//  ShouGroupCell.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/29.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ShouGroupCell.h"

@implementation ShouGroupCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(ShousuoMOdel *)model{
    _model=model;
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ketangzhiwai.com/%@",_model.picPath]]];
   
    _nameLabel.text=[NSString stringWithFormat:@"%@ (%@人)",_model.groupName,_model.num];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
