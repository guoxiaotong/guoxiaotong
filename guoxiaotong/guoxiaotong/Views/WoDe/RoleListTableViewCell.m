//
//  RoleListTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "RoleListTableViewCell.h"

@implementation RoleListTableViewCell

- (void)awakeFromNib {
}

- (void)setUIWith:(UserRoleInfoModel *)model {
    _roleInfo = model;
    switch (_roleInfo.roleId) {
        case 1://校长
            [self.manageButton setTitle:@"校长管理" forState:UIControlStateNormal];
            [self.manageButton addTarget:self action:@selector(clickOn) forControlEvents:UIControlEventTouchUpInside];
            self.imageV.image = [UIImage imageNamed:@"manager_role_xiaozhang_pic"];
            self.roleNameLabel.text = _roleInfo.roleName;
            self.jianjieLabel.text = model.schoolName;
            break;
        case 2://班主任
            [self.manageButton setTitle:@"班级管理" forState:UIControlStateNormal];
            [self.manageButton addTarget:self action:@selector(clickOn) forControlEvents:UIControlEventTouchUpInside];
            self.imageV.image = [UIImage imageNamed:@"manager_role_banzhuren_pic"];
            self.roleNameLabel.text = _roleInfo.roleName;
            self.jianjieLabel.text = model.className;
            break;
        case 3://教师
            self.manageButton.enabled = NO;
            self.manageButton.hidden = YES;
            self.imageV.image = [UIImage imageNamed:@"manager_role_teacher_pic"];
            self.roleNameLabel.text = _roleInfo.roleName;
            self.jianjieLabel.text = model.className;//教师
            break;
        case 4://监护人
            [self.manageButton setTitle:@"家长管理" forState:UIControlStateNormal];
            [self.manageButton addTarget:self action:@selector(clickOn) forControlEvents:UIControlEventTouchUpInside];
            self.imageV.image = [UIImage imageNamed:@"manager_role_jianhuren_pic"];
            self.roleNameLabel.text = _roleInfo.roleName;
            self.jianjieLabel.text = [NSString stringWithFormat:@"%@-%@", model.className, model.studentName];
            break;
        case 5://家长
            self.manageButton.enabled = NO;
            self.manageButton.hidden = YES;
            self.imageV.image = [UIImage imageNamed:@"manager_role_jiazhang_pic"];
            self.roleNameLabel.text = _roleInfo.roleName;
            self.jianjieLabel.text = [NSString stringWithFormat:@"%@-%@", model.className, model.studentName];
            break;
        case 6://学生
            self.manageButton.enabled = NO;
            self.manageButton.hidden = YES;
            self.imageV.image = [UIImage imageNamed:@"manager_role_student_pic"];
            self.roleNameLabel.text = _roleInfo.roleName;
            self.jianjieLabel.text = [NSString stringWithFormat:@"%@-%@", model.className, model.studentName];
            break;
        default:
            break;
    }
}

- (void)clickOn {
    if (_ManagerButtonCallBack) {
        _ManagerButtonCallBack(self.roleInfo);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
