//
//  TableViewCell.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/14.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DongTaiList.h"

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;//发布的内容
@property (weak, nonatomic) IBOutlet UIImageView *PhotoImage;//头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//名字

@property (weak, nonatomic) IBOutlet UILabel *timeLebel;//时间和手机类型

@property (weak, nonatomic) IBOutlet UILabel *newsLabel;//通知

@property (weak, nonatomic) IBOutlet UIView *xiaoxiView;//消息
@property (weak, nonatomic) IBOutlet UIButton *xiaoXiBtn;//遮着回复的btn


@property (weak, nonatomic) IBOutlet UIView *dianZhanView;//点赞
@property (weak, nonatomic) IBOutlet UIButton *dianZhangBtn;//遮着点赞的btn

@property (weak, nonatomic) IBOutlet UIView *gengDuoView;//更多
@property (weak, nonatomic) IBOutlet UIButton *genDuoBtn;//遮着更多的btn

@property (weak, nonatomic) IBOutlet UILabel *xiaoXiLabel;//用于显示消息个数
@property (weak, nonatomic) IBOutlet UILabel *dianzhangLabel;//用于显示点赞个数

@property (weak, nonatomic) IBOutlet UIView *zhanSiView;//用于展示图片的UIview
@property (weak, nonatomic) IBOutlet UIView *gongNenView;//用于展示评论，点赞，更多的图片

@property(nonatomic,strong)DongTaiList *model;

@property(nonatomic,assign)int Phonnum;
-(void)setIntroductionText:(NSString*)text andphonnum:(NSInteger)num;

@end
