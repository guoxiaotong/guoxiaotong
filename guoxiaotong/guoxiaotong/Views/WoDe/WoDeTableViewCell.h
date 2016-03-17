//
//  WoDeTableViewCell.h
//  guoxiaotong
//
//  Created by zxc on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WoDeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setImage:(NSString *)imageName text:(NSString *)text;

@end
