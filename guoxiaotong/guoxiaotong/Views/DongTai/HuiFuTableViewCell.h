//
//  HuiFuTableViewCell.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "commenListData.h"

@interface HuiFuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;//回复者的头像
@property (weak, nonatomic) IBOutlet UILabel *nameLebel;//回复者的名字
@property (weak, nonatomic) IBOutlet UILabel *neRonLebel;//回复的内容
@property (weak, nonatomic) IBOutlet UIView *pichImageView;//用于展示图片
@property (weak, nonatomic) IBOutlet UILabel *timeLebel;//回复的时间

@property(nonatomic,strong)commenListData *model;

-(void)setIntroductionText:(NSString*)text andphonnum:(int)num;

@end
