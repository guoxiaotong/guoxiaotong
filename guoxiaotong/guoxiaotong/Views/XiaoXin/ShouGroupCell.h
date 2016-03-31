//
//  ShouGroupCell.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/29.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShousuoMOdel.h"

@interface ShouGroupCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property(nonatomic,strong)ShousuoMOdel *model;

@end
