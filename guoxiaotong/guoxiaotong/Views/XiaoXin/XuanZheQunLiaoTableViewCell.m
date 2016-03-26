//
//  XuanZheQunLiaoTableViewCell.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XuanZheQunLiaoTableViewCell.h"

@implementation XuanZheQunLiaoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTongXunModel:(TongXunmodel *)tongXunModel{
    _tongXunModel=tongXunModel;
    
    _nameLanel.text=_tongXunModel.userName;
    
    _jieShaoLabel.text=_tongXunModel.desc;
    
    [_chooesBtn removeFromSuperview];

}
@end
