//
//  MyCollectionViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ImageCollectionCell.h"
#import "BasicService.h"
#import "TrendsTableViewCell.h"

@interface MyCollectionViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIButton *trendsButton;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *trendsDataSource;
@property (nonatomic, strong) NSMutableArray *imageDataSource;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat buttonHeight;

@end

@implementation MyCollectionViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的收藏";
    _imageDataSource = [NSMutableArray array];
    _trendsDataSource = [NSMutableArray array];
    [self setUI];
}

- (void)setUI {
    self.selectedIndex = 0;
    [self setChangeButtons];
    [self setTableView];
    [self setCollectionView];
}

- (void)loadData {
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    __weak typeof (*&self)weakSelf = self;
    if (_selectedIndex == 0) {
        //加载动态
        BasicService *service = [[BasicService alloc] initWithView:self.view];
        NSDictionary *params = @{@"userId": shareInfo.userId, @"userRoleId": [NSNumber numberWithInteger:538], @"mine": @"myCollection",@"sendType": @"2", @"type": @"1", @"page": @"1"};
        [service getCollectTrendList:params callBack:^(BOOL isSuccess, NSArray *trendList) {
            [weakSelf.trendsDataSource removeAllObjects];
            [weakSelf.tableView reloadData];
            [weakSelf.trendsDataSource addObjectsFromArray:trendList];
            [weakSelf.tableView reloadData];
        }];
    }else {
        //加载图片
        BasicService *service = [[BasicService alloc] initWithView:self.view];
        NSDictionary *params = @{@"userId": shareInfo.userId};
        [service getCollectImageList:params callBack:^(BOOL isSuccess, NSArray *imageList) {
            [weakSelf.imageDataSource removeAllObjects];
            [weakSelf.collectionView reloadData];
            [weakSelf.imageDataSource addObjectsFromArray:imageList];
            [weakSelf.collectionView reloadData];
        }];
    }
}

- (void)setChangeButtons {
    _buttonHeight = 40;
    CGFloat height = self.buttonHeight;
    CGFloat width = (WIDTH - 12)/2;
    UIView *headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, height)];
    headerBackView.backgroundColor = SEAECH_VIEW_BACK_COLOR;
    
    _trendsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _trendsButton.frame = CGRectMake(5, 5, width, height - 10);
    _trendsButton.layer.cornerRadius = 5;
    [_trendsButton setTitle:@"动态收藏" forState:UIControlStateNormal];
    [_trendsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _trendsButton.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
    [_trendsButton addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchDown];
    [headerBackView addSubview:_trendsButton];
    
    _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageButton.frame = CGRectMake(WIDTH-5-width, 5, width, height - 10);
    _imageButton.layer.cornerRadius = 5;
    [_imageButton setTitle:@"图片收藏" forState:UIControlStateNormal];
    [_imageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _imageButton.backgroundColor = [UIColor whiteColor];
    [_imageButton addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchDown];
    [headerBackView addSubview:_imageButton];
    [self.view addSubview:headerBackView];
}

- (void)setTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.buttonHeight, WIDTH, HEIGHT-self.buttonHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TrendsTableViewCell class] forCellReuseIdentifier:@"TrendsCell"];
}

- (void)setCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(WIDTH, self.buttonHeight, WIDTH, HEIGHT-64-self.buttonHeight) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[ImageCollectionCell class] forCellWithReuseIdentifier:@"ImageCell"];
}

- (void)clickOn:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"动态收藏"]) {
        self.selectedIndex = 0;
    }else {
        self.selectedIndex = 1;
    }
    [self loadData];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        [self switchUI];
    }
}

- (void)switchUI {
    if (_selectedIndex == 0) {
        self.trendsButton.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
        [self.trendsButton setTitleColor:DEFAULT_BACKGROUND_COLOR forState:UIControlStateNormal];
        self.tableView.frame = CGRectMake(0, self.buttonHeight, WIDTH, self.tableView.frame.size.height);
        self.imageButton.backgroundColor = [UIColor whiteColor];
        [self.imageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.collectionView.frame = CGRectMake(WIDTH, self.buttonHeight, WIDTH, self.collectionView.frame.size.height);
    }else {
        self.trendsButton.backgroundColor = [UIColor whiteColor];
        [self.trendsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.tableView.frame = CGRectMake(-WIDTH, self.buttonHeight, WIDTH, self.tableView.frame.size.height);
        self.imageButton.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
        [self.imageButton setTitleColor:DEFAULT_BACKGROUND_COLOR forState:UIControlStateNormal];
        self.collectionView.frame = CGRectMake(0, self.buttonHeight, WIDTH, self.collectionView.frame.size.height);
    }
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trendsDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TrendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrendsCell"];
    ///////////////
    return cell;
}


#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    ////////
    return cell;
}

@end
