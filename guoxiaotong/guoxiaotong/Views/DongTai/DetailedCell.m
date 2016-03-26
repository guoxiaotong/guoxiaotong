//
//  DetailedCell.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "DetailedCell.h"

@implementation DetailedCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setModel:(DongTaiList *)model{
    
    _model=model;
    
    //    _label.text=_model.content;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ketangzhiwai.com/%@",_model.picPath]]];
    _nameLabel.text=_model.userName;
    _timeLebel.text=_model.sendTime;
    
    [_fengLeiLabel removeFromSuperview];
    _fengLeiLabel=nil;
    
}


-(void)setIntroductionText:(NSString*)text andphonnum:(NSInteger)num{
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.wenZhi.text = text;
//    self.wenZhi.numberOfLines = 10;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.wenZhi.text sizeWithFont:self.wenZhi.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    self.wenZhi.frame = CGRectMake(self.wenZhi.frame.origin.x, self.wenZhi.frame.origin.y, labelSize.width, labelSize.height);
    //计算出自适应的高度
    frame.size.height = labelSize.height+95*num+115;
    self.frame = frame;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
