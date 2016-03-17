//
//  RoleListTableViewCell.h
//  guoxiaotong
//
//  Created by zxc on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserRoleInfoModel.h"

@interface RoleListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *roleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jianjieLabel;
@property (weak, nonatomic) IBOutlet UIButton *manageButton;
@property (assign, nonatomic) NSInteger roleId;
@property (copy, nonatomic) NSString *roleName;
@property (copy, nonatomic) void (^ManagerButtonCallBack) (NSInteger roleId, NSString *roleName);

- (void)setUIWith:(UserRoleInfoModel *)model;

@end
