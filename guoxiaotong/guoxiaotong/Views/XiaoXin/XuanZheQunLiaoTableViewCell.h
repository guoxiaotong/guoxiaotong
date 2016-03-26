//
//  XuanZheQunLiaoTableViewCell.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TongXunmodel.h"


@interface XuanZheQunLiaoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLanel;
@property (weak, nonatomic) IBOutlet UILabel *jieShaoLabel;
@property (weak, nonatomic) IBOutlet UIButton *chooesBtn;

@property(nonatomic,strong)TongXunmodel *tongXunModel;

@end
