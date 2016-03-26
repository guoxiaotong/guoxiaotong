//
//  AdviceViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "AdviceViewController.h"
#import "CustomView.h"

@interface AdviceViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *phLabel;

@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"你提我改";
    [self setUI];
}

- (void)setUI {
    UIFont *font = [UIFont systemFontOfSize:14.0];
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, WIDTH-20, 200)];
    _textView.clipsToBounds = YES;
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textView.layer.borderWidth = 0.5;
    _textView.delegate = self;
    _textView.font = font;
    _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_textView];
    
    _phLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, WIDTH-30, 21)];
    _phLabel.font = font;
    _phLabel.text = @"输入您的意见或建议，我们会为您改进";
    _phLabel.textColor = [UIColor lightGrayColor];
    _phLabel.enabled = NO;
    [self.view addSubview:_phLabel];
    
    UIButton *submitButton = [CustomView buttonWithTitle:@"提交" width:100 orginY:300];
    [submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)submitClick {
    if (_textView.text.length) {
        __weak typeof (*&self)weakSelf = self;
        HttpClient *manager = [[HttpClient alloc] init];
        SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
        NSDictionary *params = @{@"user_id": shareInfo.userId, @"content": _textView.text};
        [manager postSingleUrl:@"http://main.ketangzhiwai.com/gxt/index.php/Home/Feedback/feedback" requestParams:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [LoadingView showBottom:weakSelf.view messages:@[@"添加成功"]];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [LoadingView showBottom:weakSelf.view messages:@[@"添加失败"]];
        }];
    }else {
        [LoadingView showBottom:self.view messages:@[@"内容不得为空"]];
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        _phLabel.text = @"输入您的意见或建议，我们会为您改进";
    }else {
        _phLabel.text = @"";
    }
    
}

@end
