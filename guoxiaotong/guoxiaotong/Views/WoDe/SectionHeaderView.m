//
//  SectionHeaderView.m
//  guoxiaotong
//
//  Created by zxc on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "SectionHeaderView.h"

@interface SectionHeaderView()

@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UIButton *sectionButton;

@end

@implementation SectionHeaderView

- (instancetype)initWithTitle:(NSString *)title isOpen:(BOOL)isOpen {
    if (self = [super init]) {
        _open = isOpen;
        
        _sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sectionButton.frame = CGRectMake(0, 0, WIDTH, 40);
        _sectionButton.backgroundColor = [UIColor whiteColor];
        [_sectionButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
        _img = [[UIImageView alloc] initWithFrame:CGRectMake(10, _sectionButton.center.y-10, 20, 20)];
        if (_open) {
            _img.image = [UIImage imageNamed:@"section_opened"];
        }else {
            _img.image = [UIImage imageNamed:@"section_closed"];
        }
        [_sectionButton addSubview:_img];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, _sectionButton.center.y-11, _sectionButton.frame.size.width-60, 22)];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.text = title;
        [_sectionButton addSubview:titleLabel];
        
        UILabel *border = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_sectionButton.frame)-0.5, WIDTH, 0.5)];
        border.backgroundColor = [UIColor lightGrayColor];
        [_sectionButton addSubview:border];
        
        [self addSubview:_sectionButton];
    }
    return self;
}

-(void)click {
     _open = !self.open;
     if (self.SectionBlock) {
         self.SectionBlock(self.index, self.open);
     }
  }

@end
