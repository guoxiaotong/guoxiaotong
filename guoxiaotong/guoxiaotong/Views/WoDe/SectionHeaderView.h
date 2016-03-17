//
//  SectionHeaderView.h
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SectionHeaderView, GroupModel;

@protocol SectionHeaderViewDelegate <NSObject>

-(void)headerViewDidClickHeaderView:(SectionHeaderView *)headerView;

@end

@interface SectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong)GroupModel *group;
@property (nonatomic, weak)id<SectionHeaderViewDelegate> delegate;

+ (instancetype)headerWithTableView:(UITableView *)tableView;


@end
