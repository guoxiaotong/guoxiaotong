//
//  DatePicker.m
//  guoxiaotong
//
//  Created by zxc on 16/3/15.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "DatePicker.h"

@interface DatePicker()
@property (nonatomic, strong) UIDatePicker *picker;
@property (nonatomic, strong) UIView *topBackView;
@property (nonatomic, strong) UIView *backView;

@property (assign, nonatomic) NSLayoutConstraint * contentViewHegithConstraint;

@end


@implementation DatePicker

- (instancetype)initDate:(NSString *)dateString {
    if (self = [super initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)]) {
        _topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _topBackView.backgroundColor = [UIColor blackColor];
        _topBackView.alpha = 0.3;
        [self addSubview:_topBackView];
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-276, WIDTH, 276)];
        _backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backView];
        
        UIView *buttonBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
        buttonBackView.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
        [_backView addSubview:buttonBackView];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(20, 10, 100, 40);
        [backButton setTitle:@"取消" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [backButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:backButton];
        
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(WIDTH-120, 10, 100, 40);
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:sureButton];
        
        _picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 60, WIDTH, 216)];
        _picker.datePickerMode = UIDatePickerModeDate;
        if (!dateString || [dateString isEqualToString:@""]) {
            _picker.date = [NSDate date];
        }else {
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
            //设置格式
            dateformatter.dateFormat = @"yyyy-MM-dd";
            _picker.date = [dateformatter dateFromString:dateString];
        }
        [_backView addSubview:_picker];
        [self show];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)cancelClick {
    [self hide];
}

- (void)sureClick {
    if (_dateCallBack) {
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        //设置格式
        dateformatter.dateFormat = @"yyyy-MM-dd";
        _dateCallBack([dateformatter stringFromDate:_picker.date]);
    }
    [self hide];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow.subviews.firstObject addSubview:self];
    __weak typeof (*&self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.contentViewHegithConstraint.constant = 276;
        [weakSelf layoutIfNeeded];
    }];
}

- (void)hide {
    __weak typeof (*&self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alpha = 0;
        weakSelf.contentViewHegithConstraint = 0;
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (IBAction)dateChanged:(id)sender {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //设置格式
    df.dateFormat = @"yyyy-MM-dd";
    
    //获取当前系统时间
    NSDate *date = _picker.date;
    //把时间对象转换成字符串
    NSString *dateString = [df  stringFromDate:date];
    NSLog(@"dateString = %@",dateString);
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];  //转化为UNIX时间戳
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
}

@end
