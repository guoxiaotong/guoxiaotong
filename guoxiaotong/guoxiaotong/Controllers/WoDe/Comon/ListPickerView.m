//
//  ListPickerView.m
//  guoxiaotong
//
//  Created by zxc on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ListPickerView.h"
#import "SchoolModel.h"
#import "GradeModel.h"
#import "RelationModel.h"

@interface ListPickerView()<UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) id model;
@end

@implementation ListPickerView

- (instancetype)init {
    if (self = [super init]) {
        _dataList = [NSMutableArray array];
        _font = [UIFont systemFontOfSize:15.0];
        self.frame = [UIScreen mainScreen].bounds;
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-316)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelClick)];
        [topView addGestureRecognizer:tap];
        [self addSubview:topView];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-316, WIDTH, 316)];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
        backView.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(20, 5, 80, 30);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = _font;
        [cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:cancelButton];
        
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(WIDTH-100, 5, 80, 30);
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sureButton.titleLabel.font = _font;
        [sureButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:sureButton];
        
        [bottomView addSubview:backView];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, 276) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [bottomView addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
        [self addSubview:bottomView];
    }
    return self;
}

- (void)show {
    _model = nil;
    [_tableView reloadData];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hide {
    _model = nil;
    [_dataList removeAllObjects];
    [_tableView reloadData];
    [self removeFromSuperview];
}

- (void)cancelClick {
    [self hide];
}

- (void)sureClick {
    if (_SureCallBack) {
        _SureCallBack(_model);
    }
    [self hide];
}

#pragma tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    id model = _dataList[indexPath.row];
    if ([model isKindOfClass:[SchoolModel class]]) {
        SchoolModel *schoolModel = model;
        cell.textLabel.text = schoolModel.name;
    }else if ([model isKindOfClass:[GradeModel class]]) {
        GradeModel *gradeModel = model;
        cell.textLabel.text = gradeModel.gradeName;
    }else if ([model isKindOfClass:[NSString class]]) {
        NSString *classModel = model;
        cell.textLabel.text = [NSString stringWithFormat:@"%@班", classModel];
    }else if ([model isKindOfClass:[RelationModel class]]) {
        RelationModel *relationModel = model;
        cell.textLabel.text = relationModel.typeName;
    }else {
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _model = _dataList[indexPath.row];
}

@end
