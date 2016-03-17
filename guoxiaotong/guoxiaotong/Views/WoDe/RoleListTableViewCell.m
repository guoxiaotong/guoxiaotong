//
//  RoleListTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "RoleListTableViewCell.h"
/*{
 "issueTime": "2015-12-04 11:15:07.0",
 "memo": " ",
 "roleId": "1",
 "roleName": "校长",
 "roleType": "principal"
 },
 {
 "issueTime": "2015-12-07 16:25:57.0",
 "memo": " ",
 "roleId": "2",
 "roleName": "班主任",
 "roleType": "tutor"
 },
 {
 "issueTime": "2015-12-07 16:26:31.0",
 "memo": " ",
 "roleId": "3",
 "roleName": "教师",
 "roleType": "teacher"
 },
 {
 "issueTime": "2015-12-07 16:26:56.0",
 "memo": " ",
 "roleId": "4",
 "roleName": "监护人",
 "roleType": "guardian"
 },
 {
 "issueTime": "2015-12-07 16:27:16.0",
 "memo": " ",
 "roleId": "5",
 "roleName": "家长",
 "roleType": "parents"
 },
 {
 "issueTime": "2015-12-10 13:38:30.0",
 "memo": " ",
 "roleId": "6",
 "roleName": "学生",
 "roleType": "student"
 }
 */

@implementation RoleListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setUIWith:(UserRoleInfoModel *)model {
    _roleId = model.roleId;
    _roleName = model.roleName;
    switch (_roleId) {
        case 1://校长
            [self.manageButton setTitle:@"校长管理" forState:UIControlStateNormal];
            [self.manageButton addTarget:self action:@selector(clickOn) forControlEvents:UIControlEventTouchUpInside];
            self.imageV.image = [UIImage imageNamed:@"manager_role_xiaozhang_pic"];
            self.roleNameLabel.text = _roleName;
            self.jianjieLabel.text = model.schoolName;
            break;
        case 2://班主任
            [self.manageButton setTitle:@"班级管理" forState:UIControlStateNormal];
            [self.manageButton addTarget:self action:@selector(clickOn) forControlEvents:UIControlEventTouchUpInside];
            self.imageV.image = [UIImage imageNamed:@"manager_role_banzhuren_pic"];
            self.roleNameLabel.text = _roleName;
            self.jianjieLabel.text = model.className;
            break;
        case 3://教师
            [self.manageButton setTitle:@"学生管理" forState:UIControlStateNormal];
            [self.manageButton addTarget:self action:@selector(clickOn) forControlEvents:UIControlEventTouchUpInside];
            self.imageV.image = [UIImage imageNamed:@"manager_role_teacher_pic"];
            self.roleNameLabel.text = _roleName;
            self.jianjieLabel.text = model.className;//教师
            break;
        case 4://监护人
            [self.manageButton setTitle:@"家长管理" forState:UIControlStateNormal];
            [self.manageButton addTarget:self action:@selector(clickOn) forControlEvents:UIControlEventTouchUpInside];
            self.imageV.image = [UIImage imageNamed:@"manager_role_jianhuren_pic"];
            self.roleNameLabel.text = _roleName;
            self.jianjieLabel.text = [NSString stringWithFormat:@"%@-%@", model.className, model.studentName];
            break;
        case 5://家长
        case 6://学生
        default:
            self.roleNameLabel.text = _roleName;
            self.jianjieLabel.text = [NSString stringWithFormat:@"%@-%@", model.className, model.studentName];
            self.manageButton.enabled = NO;
            self.manageButton.hidden = YES;
            break;
    }
}

- (void)clickOn {
    if (_ManagerButtonCallBack) {
        _ManagerButtonCallBack(self.roleId, self.roleName);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
