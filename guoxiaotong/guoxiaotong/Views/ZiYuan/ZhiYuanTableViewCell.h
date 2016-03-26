//
//  ZhiYuanTableViewCell.h
//  CountryAndSchool
//
//  Created by 刘晓娜 on 16/3/9.
//  Copyright © 2016年 刘晓娜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhiYuanModel.h"

@interface ZhiYuanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imag;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiangQingLabel;

//@property(nonatomic,strong)UIImageView *imag;
//@property(nonatomic,strong)UILabel *titleLabel;
//@property(nonatomic,strong)UILabel *xiangQingLabel;

@property(nonatomic,strong)ZhiYuanModel *ziYuanModel;

@end
