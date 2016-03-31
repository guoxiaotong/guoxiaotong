//
//  XZEmailListTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XZEmailListTableViewCell.h"
#import "XZEmailModel.h"

@interface XZEmailListTableViewCell()

@property (strong, nonatomic) UIImageView *imageV;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation XZEmailListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGRect frame = self.frame;
        CGFloat icon_wid = 50;
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, icon_wid, icon_wid)];
        _imageV.layer.cornerRadius = icon_wid/2;
        _imageV.clipsToBounds = YES;
        [self.contentView addSubview:_imageV];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, 5, 100, 21)];
        _nameLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame)+10, 5, frame.size.width - CGRectGetMaxX(_nameLabel.frame) - 30, 21)];
        _timeLabel.font = [UIFont systemFontOfSize:13.0];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timeLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, CGRectGetMaxY(_nameLabel.frame)+5, frame.size.width - CGRectGetMaxX(_imageV.frame) - 30, 21)];
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
        _contentLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_contentLabel];
    }
    return self;
}

- (void)setUIWithModel:(id)model {
    XZEmailModel *email = model;
    
    [_imageV sd_setImageWithURL:[self imageUrl:email.userInfo.picPath] placeholderImage:[UIImage imageNamed:@"default_user_icon"]];
    _nameLabel.text = email.userInfo.userName;
    _contentLabel.text = email.content;
    _timeLabel.text = email.sendTime;
}

- (NSURL *)imageUrl:(NSString *)picPath {
    NSString *urlString = [NSString stringWithFormat:@"%@%@", API_ROOT_IMAGE_URL, picPath];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

@end
