//
//  BZRStudentTableViewCell.m
//  guoxiaotong
//
//  Created by zxc on 16/3/26.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "BZRStudentTableViewCell.h"
#import "BZRJianhurenModel.h"

@interface BZRStudentTableViewCell()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *studentLabel;
@property (nonatomic, strong) UILabel *jianhurenLabel;

@end

@implementation BZRStudentTableViewCell

-  (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGRect frame = self.frame;
        CGFloat icon_wid = 50;
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, icon_wid, icon_wid)];
        [self.contentView addSubview:_imageV];
        
        _studentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, 5, frame.size.width-CGRectGetMaxX(_imageV.frame)-30, 21)];
        _studentLabel.font = [UIFont systemFontOfSize:16.0];
        [self.contentView addSubview:_studentLabel];
        
        _jianhurenLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+10, CGRectGetMaxY(_studentLabel.frame)+5, frame.size.width-CGRectGetMaxX(_imageV.frame)-30, 18)];
        _jianhurenLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_jianhurenLabel];
        
    }
    return self;
}

- (void)setUIWith:(id)model {
    BZRJianhurenModel *jianhurenInfo = model;
    _imageV.image = [UIImage imageNamed:@"manager_role_student_pic"];
    _studentLabel.text = jianhurenInfo.studentName;
    if (jianhurenInfo.parentName) {
        _jianhurenLabel.text = [NSString stringWithFormat:@"监护人：%@(%@)", jianhurenInfo.parentName, jianhurenInfo.relationName];
    }else {
        _jianhurenLabel.text = @"监护人：暂无";
    }
}

@end
