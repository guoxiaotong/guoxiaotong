//
//  ZhiYuanTableViewCell.m
//  CountryAndSchool
//
//  Created by 刘晓娜 on 16/3/9.
//  Copyright © 2016年 刘晓娜. All rights reserved.
//

#import "ZhiYuanTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation ZhiYuanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.imag.frame=CGRectMake(5, 5, 50, 50);
//        
//        [self addSubview:self.imag];
//    }
//    return self;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setZiYuanModel:(ZhiYuanModel *)ziYuanModel{
    
    _ziYuanModel=ziYuanModel;

   _titleLabel.text=_ziYuanModel.title;
    
    _xiangQingLabel.text=_ziYuanModel.intro;
    
    
    NSString *str=[NSString stringWithFormat:@"http://www.ketangzhiwai.com/%@",_ziYuanModel.thumb];
    
    [_imag sd_setImageWithURL:[NSURL URLWithString:str]];

}

@end
