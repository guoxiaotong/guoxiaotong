//
//  PhotoCollectionViewCell.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.phonImagView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width/4-5, [UIScreen mainScreen].bounds.size.width/4-5)];
        self.phonImagView.center=self.contentView.center;
        self.phonImagView.userInteractionEnabled=YES;
        [self.contentView addSubview:self.phonImagView];
        
//        self.isChoose=[[UIImageView alloc]initWithFrame:CGRectMake(self.phonImagView.frame.size.width/4*3-10,0,self.phonImagView.frame.size.width/4+10,self.phonImagView.frame.size.width/4+10)];
//        self.isChoose.image=[UIImage imageNamed:@"FriendsSendsPicturesSelectBigNIcon"];
//        [self.contentView addSubview:self.isChoose];
        
        self.isChooseBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        self.isChooseBtn.frame=CGRectMake(self.phonImagView.frame.size.width/4*3-10,0,self.phonImagView.frame.size.width/4+10,self.phonImagView.frame.size.width/4+10);
        [self.isChooseBtn setImage:[UIImage imageNamed:@"FriendsSendsPicturesSelectBigNIcon"] forState:UIControlStateNormal];
        [self.isChooseBtn setImage:[UIImage imageNamed:@"FriendsSendsPicturesSelectBigYIcon"]forState:UIControlStateSelected];

        [self.contentView addSubview:self.isChooseBtn];
        
    
    }
    return self;
}


@end
