//
//  ContactTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "ContectMemberModel.h"

@interface ContactTableViewCell()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation ContactTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGRect frame = self.frame;
        CGFloat icon_wid = 50;
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, icon_wid, icon_wid)];
        _imageV.layer.cornerRadius = icon_wid/2;
        _imageV.clipsToBounds = YES;
        [self.contentView addSubview:_imageV];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, 5, frame.size.width - CGRectGetMaxX(_imageV.frame) - 30, 21)];
        _nameLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_nameLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, CGRectGetMaxY(_nameLabel.frame)+5, frame.size.width - CGRectGetMaxX(_imageV.frame) - 30, 21)];
        _detailLabel.font = [UIFont systemFontOfSize:14.0];
        _detailLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_detailLabel];
        
    }
    return self;
}

- (void)setUIWithModel:(id)model {
    ContectMemberModel *contectInfo = model;
    [_imageV sd_setImageWithURL:[self imageUrl:contectInfo.picPath] placeholderImage:[UIImage imageNamed:@"default_user_icon"]];
    _nameLabel.text = contectInfo.userName;
    _detailLabel.text = contectInfo.desc;
}

- (NSURL *)imageUrl:(NSString *)picPath {
    NSString *urlString = [NSString stringWithFormat:@"%@%@", API_ROOT_IMAGE_URL, picPath];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

@end
