//
//  MyCollectionViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ImageCollectionCell.h"

@interface MyCollectionViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIButton * trendsButton;
@property (nonatomic, strong) UIButton * imageButton;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *trendsDataSource;
@property (nonatomic, strong) NSMutableArray *imageDataSource;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat buttonHeight;

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    [self setUI];
}

- (void)setUI {
    self.selectedIndex = 0;
    [self setChangeButtons];
    [self setTableView];
    [self setCollectionView];
}

- (void)setChangeButtons {
    self.buttonHeight = 50;
    CGFloat height = self.buttonHeight;
    CGFloat width = (WIDTH - 12)/2;
    UIView *headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, height)];
    headerBackView.backgroundColor = [UIColor lightGrayColor];
    
    self.trendsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.trendsButton.frame = CGRectMake(5, 5, width, height - 10);
    [self.trendsButton setTitle:@"动态收藏" forState:UIControlStateNormal];
    [self.trendsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.trendsButton.backgroundColor = DEFAULT_NAVIGATIONBAR_COLOR;
    [self.trendsButton addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchDown];
    [headerBackView addSubview:self.trendsButton];
    
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageButton.frame = CGRectMake(WIDTH-5-width, 5, width, height - 10);
    [self.imageButton setTitle:@"图片收藏" forState:UIControlStateNormal];
    [self.imageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.imageButton.backgroundColor = [UIColor whiteColor];
    [self.imageButton addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchDown];
    [headerBackView addSubview:self.imageButton];
    [self.view addSubview:headerBackView];
}

- (void)setTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.buttonHeight, WIDTH, HEIGHT-self.buttonHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TrendsTableViewCell" bundle:nil] forCellReuseIdentifier:@"TrendsCell"];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrendsCell"];
    
    return cell;
}


#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
