//
//  BZRCourseTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/26.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BZRCourseTableViewCell.h"
#import "BZRCourseModel.h"

@interface BZRCourseTableViewCell()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *courseLabel;
@property (nonatomic, strong) UILabel *teacherLabel;

@end

@implementation BZRCourseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGRect frame = self.frame;
        
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(40, 5, frame.size.height-10, frame.size.height-10)];
        [self.contentView addSubview:_imageV];
        
        _courseLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, 5, 80, frame.size.height-10)];
        _courseLabel.font = [UIFont boldSystemFontOfSize:16.0];
        
        [self.contentView addSubview:_courseLabel];
        
        _teacherLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_courseLabel.frame), 5, frame.size.width-CGRectGetMaxX(_courseLabel.frame)-20, frame.size.height-10)];
        _teacherLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_teacherLabel];
    }
    return self;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setUIWith:(id)model {
    BZRCourseModel *courseInfo = model;
    _imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_course_%@", courseInfo.memo]];
    _courseLabel.text = courseInfo.courseName;
    _teacherLabel.text = courseInfo.courseTeacher;
}

@end
