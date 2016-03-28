//
//  TrendsTableViewCell.h
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrendsTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) void (^replyCallBack)(id model);
@property (nonatomic, copy) void (^likeCallBack)(id model);

- (void)setUIWithModel:(id)model;

@end
