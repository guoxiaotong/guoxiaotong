//
//  TableViewCell.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/14.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "TableViewCell.h"
/**添加*/
#import "TrendModel.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setModel:(DongTaiList *)model{

    _model=model;
    
//    _label.text=_model.content;
    
    [_PhotoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ketangzhiwai.com/%@",_model.picPath]]];
    _nameLabel.text=_model.userName;
    _timeLebel.text=_model.sendTime;
    
    //去掉之前每个cell右上方的信息内别提示
    [_newsLabel removeFromSuperview];
    _newsLabel=nil;
    
    if (_model.commentBean.count) {
        _xiaoXiLabel.text=[NSString stringWithFormat:@"%ld",_model.commentBean.count];
        
    }else{
        
        _xiaoXiLabel.text=@"回复";
        
    }if ([_model.praise isEqualToString:@""]) {
        
        _dianzhangLabel.text=@"0";
        
    }else{
        NSArray *arry=[_model.praise componentsSeparatedByString:@","];
        _dianzhangLabel.text=[NSString stringWithFormat:@"%ld",arry.count];
    
    }
   
    

}

//赋值 and 自动换行,计算出cell的高度

-(void)setIntroductionText:(NSString*)text andphonnum:(NSInteger)num{
    
    //获得当前cell高度
    
    CGRect frame = [self frame];
    
    //文本赋值
    
    self.label.text = text;
    
    //设置label的最大行数
    
    self.label.numberOfLines = 10;
    
    CGSize size = CGSizeMake(300, 1000);
    
    CGSize labelSize = [self.label.text sizeWithFont:self.label.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    
  
    self.label.frame = CGRectMake(self.label.frame.origin.x, self.label.frame.origin.y, labelSize.width, labelSize.height);
    
    //计算出自适应的高度
    
    frame.size.height = labelSize.height+95*num+135;
    
    self.frame = frame;
    
}

- (void)setUIWith:(id)model {
    TrendModel *trendInfo = model;
    UIImage *placeholderImage = [UIImage imageNamed:@""];
    [_PhotoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_ROOT_IMAGE_URL, trendInfo.userInfo.picPath]] placeholderImage:placeholderImage];
    
}

@end
