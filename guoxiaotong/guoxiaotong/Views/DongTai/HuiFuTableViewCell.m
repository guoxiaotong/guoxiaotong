//
//  HuiFuTableViewCell.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "HuiFuTableViewCell.h"

@implementation HuiFuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(commenListData *)model{

    _model=model;
    
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ketangzhiwai.com/%@",_model.picPath]]];
    _nameLebel.text=_model.userName;
//    _neRonLebel.text=_model.content;
    _timeLebel.text=_model.commentTime;
    
    

}

-(void)setIntroductionText:(NSString*)text andphonnum:(int)num{
    
    //获得当前cell高度
    
    CGRect frame = [self frame];
    
    //文本赋值
    
    self.neRonLebel.text = text;
    
    //设置label的最大行数
    
    self.neRonLebel.numberOfLines = 10;
    
    CGSize size = CGSizeMake(300, 1000);
    
    CGSize labelSize = [self.neRonLebel.text sizeWithFont:self.neRonLebel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    
    
    self.neRonLebel.frame = CGRectMake(self.neRonLebel.frame.origin.x, self.neRonLebel.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    
    frame.size.height = labelSize.height+95*num+90;
    
    self.frame = frame;
    
}


@end
