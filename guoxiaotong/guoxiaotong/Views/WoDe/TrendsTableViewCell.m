//
//  TrendsTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "TrendsTableViewCell.h"
#import "TrendModel.h"
#import "ImageModel.h"

@interface TrendsTableViewCell()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) NSMutableArray *imageVs;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *replyButton;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) id model;

@end


@implementation TrendsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imageVs = [NSMutableArray array];
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 50, 50)];
        _icon.userInteractionEnabled = YES;
        _icon.layer.cornerRadius = 25;
        _icon.clipsToBounds = YES;
        //图像处理，点击事件
        [self.contentView addSubview:_icon];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_icon.frame)+20, 10, WIDTH-CGRectGetMaxX(_icon.frame)-40, 25)];
        _nameLabel.font = [UIFont systemFontOfSize:15.0];
        [self.contentView addSubview:_nameLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_nameLabel.frame)+5, _nameLabel.frame.size.width, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:14.0];
        _timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_timeLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_icon.frame)+10, WIDTH-40, 25)];
        _contentLabel.font = [UIFont systemFontOfSize:14.0];
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        
        for (NSInteger index = 0; index < 9; index++) {
            //创建9个image
            UIImageView *imageV = [[UIImageView alloc] init];
            imageV.userInteractionEnabled = YES;
            //添加单击
            [self.contentView addSubview:imageV];
            [self.imageVs addObject:imageV];
        }
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_contentLabel.frame)+20, WIDTH, 40)];
        UILabel *border = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
        border.backgroundColor = [UIColor lightGrayColor];
        [_backView addSubview:border];
        
        CGFloat wid = (WIDTH-2)/3;
        CGFloat hig = 30;
        UIFont *font = [UIFont systemFontOfSize:14.0];
        _replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _replyButton.frame = CGRectMake(0, 5, wid, hig);
        _replyButton.backgroundColor = [UIColor whiteColor];
        _replyButton.titleLabel.font = font;
        [_replyButton setImage:[UIImage imageNamed:@"trend_reply"] forState:UIControlStateNormal];
        [_replyButton setTitle:@"回复" forState:UIControlStateNormal];
        [_replyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_replyButton addTarget:self action:@selector(replyClick) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_replyButton];
        
        UILabel *border1 = [[UILabel alloc] initWithFrame:CGRectMake(wid, 5, 0.5, 30)];
        border1.backgroundColor = [UIColor lightGrayColor];
        [_backView addSubview:border1];
        
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _likeButton.frame = CGRectMake(wid+1, 5, wid, hig);
        _likeButton.backgroundColor = [UIColor whiteColor];
        _likeButton.titleLabel.font = font;
        [_likeButton setImage:[UIImage imageNamed:@"trend_like"] forState:UIControlStateNormal];
        [_likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(likeClick) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_likeButton];
        
        UILabel *border2 = [[UILabel alloc] initWithFrame:CGRectMake(wid*2+1, 5, 0.5, 30)];
        border2.backgroundColor = [UIColor lightGrayColor];
        [_backView addSubview:border2];
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.frame = CGRectMake((wid+1)*2, 5, wid, hig);
        _moreButton.backgroundColor = [UIColor whiteColor];
        _moreButton.titleLabel.font = font;
        [_moreButton setImage:[UIImage imageNamed:@"trend_more"] forState:UIControlStateNormal];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:_moreButton];
        
        [self.contentView addSubview:_backView];
        _cellHeight = CGRectGetMaxY(_contentLabel.frame)+40;
    }
    return self;
}


- (void)replyClick {
    if (_replyCallBack) {
        _replyCallBack(_model);
    }
}

- (void)likeClick {
    if (_likeCallBack) {
        _likeCallBack(_model);
    }
}

- (void)moreClick {
    
}

- (void)setUIWithModel:(id)model {
    TrendModel *trendInfo = model;
    
    [_icon sd_setImageWithURL:[self imageUrl:trendInfo.userInfo.picPath] placeholderImage:[UIImage imageNamed:@"default_user_icon"]];
    _nameLabel.text = trendInfo.userInfo.userName;
    _timeLabel.text = trendInfo.sendTime;
    
    _contentLabel.text = trendInfo.content;
    CGFloat contentHeight = [self getHight:trendInfo.content andFont:[UIFont systemFontOfSize:14.0] andWidth:_contentLabel.frame.size.width];
    CGRect contentFrame = _contentLabel.frame;
    contentFrame.size.height = contentHeight;
    _contentLabel.frame = contentFrame;
    
    CGFloat wid = (WIDTH-100)/3;
    CGFloat hig = wid;
    
    NSInteger num_y;
    if (!trendInfo.imageList.count % 3) {
        num_y = trendInfo.imageList.count / 3;
    }else {
        num_y = trendInfo.imageList.count / 3 + 1;
    }
    
    CGRect backFrame = _backView.frame;
    backFrame.origin.y = CGRectGetMaxY(_contentLabel.frame) + 20 + (hig + 20) * num_y;
    _backView.frame = backFrame;
    
    for (NSInteger index = 0; index < _imageVs.count; index++) {
        UIImageView *imageV = _imageVs[index];
        if (index < trendInfo.imageList.count) {
            ImageModel *imageInfo = trendInfo.imageList[index];
            imageV.frame = CGRectMake(20+(wid+20)*(index%3), CGRectGetMaxY(_contentLabel.frame)+20+(hig+20)*(index/3), wid, hig);
            [imageV sd_setImageWithURL:[self imageUrl:imageInfo.imageUrl]];
        }else {
            imageV.frame = CGRectMake(0, 0, 0, 0);
        }
    }
    _cellHeight = CGRectGetMaxY(_contentLabel.frame)+ 20 + (hig+20)*num_y + 40;
}

- (NSURL *)imageUrl:(NSString *)picPath {
    NSString *urlString = [NSString stringWithFormat:@"%@%@", API_ROOT_IMAGE_URL, picPath];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

- (CGFloat)getHight:(NSString *)text andFont:(UIFont *)font andWidth:(CGFloat)width
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil] ;
    CGFloat hight = rect.size.height ;
    
    return hight ;
}



@end
