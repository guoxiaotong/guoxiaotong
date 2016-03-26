//
//  MyIntergrationViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/21.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "MyIntergrationViewController.h"
#import "ImageHeaderView.h"
#import "TaskDoneModel.h"
#import "BasicService.h"
#import "TaskDidTableViewCell.h"

@interface MyIntergrationViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UILabel *jifenLabel;
//@property (nonatomic, strong) UILabel *goldLabel;
@property (nonatomic, assign) CGFloat table_y;
@property (nonatomic, assign) BOOL signIn;

@end

@implementation MyIntergrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的积分";
    _dataSource = [NSMutableArray array];
    [self setUI];
    [self loadData];
}


- (void)setUI {
    _font = [UIFont systemFontOfSize:14.0];
    [self setHeader];
    [self setLabel];
    [self setTableView];
}

- (void)setHeader {
//    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
//    self.header.detailLabel.text = shareInfo.userName;
//    NSString *picUrl = [NSString stringWithFormat:@"%@%@", API_ROOT_IMAGE_URL, shareInfo.picPath];
//    [self.header.imageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"wode_image_placeHolder"]];
    
    self.header.imageView.image = [UIImage imageNamed:@"sign_icon"];
    self.header.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singInClick)];
    [self.header.imageView addGestureRecognizer:tap];
    
}

- (void)setLabel {
    _jifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, WIDTH, 50)];
    _jifenLabel.font = _font;
    _jifenLabel.textAlignment = NSTextAlignmentCenter;
    _jifenLabel.text = @"当前积分         分";
    [self.view addSubview:_jifenLabel];
    
//    UILabel *border = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_jifenLabel.frame), CGRectGetMinY(_jifenLabel.frame)+10, 1, _jifenLabel.frame.size.height-20)];
//    border.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:border];
    
//    _goldLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_jifenLabel.frame)+1, 150, (WIDTH-1)/2, 50)];
//    _goldLabel.font = _font;
//    _goldLabel.textAlignment = NSTextAlignmentCenter;
//    _goldLabel.text = @"当前金币         金币";
//    [self.view addSubview:_goldLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_jifenLabel.frame), WIDTH, 5)];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineLabel];
    
    UILabel *listLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineLabel.frame), WIDTH, 40)];
    listLabel.text = @"  任务列表";
    listLabel.font = [UIFont systemFontOfSize:16.0];
    [self.view addSubview:listLabel];
    
    UILabel *lineBorder = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(listLabel.frame), WIDTH, 0.5)];
    lineBorder.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineBorder];
    _table_y = CGRectGetMaxY(lineBorder.frame);
}

- (void)setTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _table_y, WIDTH, HEIGHT-64-_table_y) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    [self.tableView registerClass:[TaskDidTableViewCell class] forCellReuseIdentifier:@"TaskCell"];
}

- (void)loadData {
    BasicService *service = [[BasicService alloc] initWithView:self.view];
    __weak typeof (*&self)weakSelf = self;
    [service doTask:@"point" callBack:^(NSInteger code, NSString *msg, NSString *reward, NSString *totalPoint, NSString *lastday) {
        if (code == 0) {
            weakSelf.jifenLabel.text = [NSString stringWithFormat:@"当前积分      %@分", totalPoint];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyy-MM-dd";
            if ([lastday isEqualToString:[formatter stringFromDate:[NSDate date]]]) {
                weakSelf.signIn = YES;
                weakSelf.header.imageView.image = [UIImage imageNamed:@"sign_no"];
            }else {
                weakSelf.signIn = NO;
                weakSelf.header.imageView.image = [UIImage imageNamed:@"sign_ok"];
            }
        }
    }];
    [service getTaskDidListCallBack:^(NSInteger code, NSArray *taskList) {
        if (code == 0) {
            [weakSelf.dataSource removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf.dataSource addObjectsFromArray:taskList];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)singInClick {
    if (_signIn) {
        [LoadingView showBottom:self.view messages:@[@"今天已经签过到啦！"]];
    }else {
        BasicService *service = [[BasicService alloc] initWithView:self.view];
        __weak typeof (*&self)weakSelf = self;
        [service doTask:@"sign" callBack:^(NSInteger code, NSString *msg, NSString *reward, NSString *totalPoint, NSString *lastday) {
            if (code == 0) {
                weakSelf.jifenLabel.text = [NSString stringWithFormat:@"当前积分      %@分", totalPoint];
                [weakSelf loadData];
            }
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskDidTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    TaskDoneModel *model = self.dataSource[indexPath.row];
    [cell setUIWith:model];
    return cell;
}

@end
