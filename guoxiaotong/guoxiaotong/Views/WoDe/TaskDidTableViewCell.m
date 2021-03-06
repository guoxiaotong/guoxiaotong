//
//  TaskDidTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/24.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "TaskDidTableViewCell.h"
#import "TaskDoneModel.h"

@interface TaskDidTableViewCell()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation TaskDidTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat wid = self.frame.size.width/3;
        CGFloat hight = self.frame.size.height-10;
        UIFont *font = [UIFont systemFontOfSize:14.0];
        
        _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, wid, hight)];
        _typeLabel.font = font;
        [self.contentView addSubview:_typeLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(wid, 5, wid, hight)];
        _timeLabel.font = font;
        [self.contentView addSubview:_timeLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(wid*2, 5, wid, hight)];
        _detailLabel.font = font;
        [self.contentView addSubview:_detailLabel];
        
//        _imageV = [UIImageView alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
    }
    return self;
}

- (void)setUIWith:(id)model {
    TaskDoneModel *taskInfo = model;
    _typeLabel.text = taskInfo.taskName;
    _timeLabel.text = taskInfo.issueTime;
    _detailLabel.text = [NSString stringWithFormat:@"得到积分+%@", taskInfo.reward];
    
}

@end
