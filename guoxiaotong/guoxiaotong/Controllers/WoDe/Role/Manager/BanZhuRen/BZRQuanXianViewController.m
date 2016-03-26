//
//  BZRQuanXianViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BZRQuanXianViewController.h"
#import "SwitchTableViewCell.h"
#import "BZRQuanXianModel.h"
#import "BZRManagerService.h"


@interface BZRQuanXianViewController ()

@property (nonatomic, strong) BZRQuanXianModel *quanxianModel;

@end

@implementation BZRQuanXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"班级权限设置";
    [self setUI];
    [self loadData];
}

- (void)setUI {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"SwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
}

- (void)loadData {
    BZRManagerService *service = [[BZRManagerService alloc] initWithView:self.view];
    __weak typeof (*&self)weakSelf = self;
    [service getSettings:_roleInfo.classId callBack:^(BOOL isSuccess, BZRQuanXianModel *quanxianModel) {
        if (isSuccess) {
            weakSelf.quanxianModel = quanxianModel;
            [weakSelf.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.quanxianModel) {
        return 3;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    __weak typeof (*&self)weakSelf = self;
    cell.SwitchBlock = ^(NSInteger index, BOOL isOpen){
        [weakSelf setSettings:index state:isOpen];
    };
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"是否允许监护人/家长建群";
            [cell setState:_quanxianModel.teacherGroup index:indexPath.row];
            break;
        case 1:
            cell.titleLabel.text = @"是否允许监护人/家长私聊";
            [cell setState:_quanxianModel.familyChat index:indexPath.row];
            break;
        case 2:
            cell.titleLabel.text = @"是否允许监护人/家长发分享";
            [cell setState:_quanxianModel.familyShare index:indexPath.row];
            break;
        default:
            break;
    }
    return cell;
}

- (void)setSettings:(NSInteger)index state:(BOOL)isOn {
    __weak typeof (*&self)weakSelf = self;
    BZRManagerService *service = [[BZRManagerService alloc] initWithView:self.view];
    NSMutableDictionary *permissions = [NSMutableDictionary dictionary];
    [permissions setObject:_roleInfo.classId forKey:@"classId"];
    switch (index) {
        case 0:
        {
            if (isOn) {
                self.quanxianModel.teacherGroup = @"1";
            }else {
                self.quanxianModel.teacherGroup = @"0";
            }
            [permissions setObject:self.quanxianModel.teacherGroup forKey:@"teacherGroup"];
        }break;
        case 1:
        {
            if (isOn) {
                self.quanxianModel.familyChat = @"1";
            }else {
                self.quanxianModel.familyChat = @"0";
            }
            [permissions setObject:self.quanxianModel.familyChat forKey:@"familyChat"];
        } break;
        case 2:
        {
            if (isOn) {
                self.quanxianModel.familyShare = @"1";
            }else {
                self.quanxianModel.familyShare = @"0";
            }
            [permissions setObject:self.quanxianModel.familyShare forKey:@"familyShare"];
        }break;
        default:
            break;
    }
    
    [service setSettings:permissions callBack:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf loadData];
        }
    }];
}


@end
