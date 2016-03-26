//
//  DetailedCell.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DongTaiList.h"

@interface DetailedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;//用于展示发送者的头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//发送者的名字
@property (weak, nonatomic) IBOutlet UILabel *timeLebel;//发送者的姓名
@property (weak, nonatomic) IBOutlet UILabel *fengLeiLabel;//分类，通知，分享
@property (weak, nonatomic) IBOutlet UITextView *wenZhi;
@property (weak, nonatomic) IBOutlet UIView *tuPian;


@property(nonatomic,strong)DongTaiList *model;

-(void)setIntroductionText:(NSString*)text andphonnum:(NSInteger)num;
@end
