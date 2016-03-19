//
//  WoDeViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "WoDeViewController.h"
#import "WoDeTableViewCell.h"
#import "SettingViewController.h"
#import "SingleUserInfo.h"
#import "Config.h"
#import <UIImageView+WebCache.h>
#import "LoadingView.h"
#import "ImageHeaderView.h"

@interface WoDeViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *myList;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, strong) UIImageView *navBarHairlineImageView;
@property (nonatomic, strong) UIActionSheet *sheet;
@property (nonatomic, strong) UIImagePickerController *imagePicker ;

@end

@implementation WoDeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self setUpUI];
    [self setUpDataSourse];
}

#pragma mark - 设置导航栏下分割线在本页面不显示
- (void)viewWillAppear:(BOOL)animated {
    self.navBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navBarHairlineImageView.hidden = NO;
}

- (UIImageView *)findHairlineImageViewUnder: (UIView *)view {
    if([view isKindOfClass:UIImageView.class] && view.bounds.size.height<=1.0) {
        return (UIImageView *)view;
    }
    for(UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if(imageView) {
            return imageView;
        }
    }
    return nil;
}

- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

#pragma mark - UI及固定数据设置
- (void)setUpUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[[UIImage imageNamed:@"manager_quanxian_bzr"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [self setUpHeaderView];
    [self setUpTableView];
}

- (void)setUpHeaderView {
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    _headerHeight = 150;
    ImageHeaderView *header = [[ImageHeaderView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, _headerHeight)];
    header.detailLabel.text = shareInfo.userName;
    NSString *picUrl = [NSString stringWithFormat:@"%@%@", API_ROOT_IMAGE_URL, shareInfo.picPath];
    [header.imageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"wode_image_placeHolder"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
    [header addGestureRecognizer:tap];
    self.imageView = header.imageView;
    [self.view addSubview:header];

    
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerHeight, self.view.frame.size.width, self.view.frame.size.height - 128 - self.headerHeight) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"WoDeTableViewCell" bundle:nil] forCellReuseIdentifier:@"wodeCell"];
}

- (void)setUpDataSourse {
    
    NSArray *icons = @[@"myList_ziliao",
                       @"myList_jiaose",
                       @"myList_tongxunlu",
                       @"myList_shoucang",
                       @"myList_renwu",
//                       @"myList_jifen",
//                       @"myList_jinbi",
                       @"myList_dongtai"];
    NSArray *titles = @[@"我的资料",
                        @"我的角色",
                        @"我的通讯录",
                        @"我的收藏",
                        @"我的任务",
//                        @"我的积分",
//                        @"我的金币",
                        @"我的动态",];
    NSArray *viewControllersName = @[@"MyProfileViewController",
                                     @"RoleListViewController",
                                     @"MyAddressListViewController",
                                     @"MyCollectionViewController",
                                     @"Nil",
//                                     @"Nil",
//                                     @"Nil",
                                     @"MyTrendsViewController"];
    
    self.myList = @{@"icons": icons, @"titles": titles, @"vcsName": viewControllersName};
}

- (void)imageClick {
    if (!self.imagePicker) {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
    }
    self.sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
    [self.sheet showInView:self.view];
}

- (void)setting {
    SettingViewController *set = [[SettingViewController alloc] init];
    set.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:set animated:true];
}

#pragma mark - 从相机或相册获取图片
- (void)getPhotoFromCamera {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:^{
        
    }];
}

- (void)getPhotoFromAlbum {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:^{
        
    }];
}

#pragma mark - imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * image = info[@"UIImagePickerControllerOriginalImage"];
    self.imageView.image = image ;
    [self.imagePicker dismissViewControllerAnimated:YES completion:^{
        //上传图片
    }];
}

#pragma mark - SheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0://相机
            [self getPhotoFromCamera];
            break;
        case 1:
            [self getPhotoFromAlbum];
            break;
        default:
            break;
    }
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *icons = self.myList[@"icons"];
    return  icons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *icons = self.myList[@"icons"];
    NSArray *titles = self.myList[@"titles"];

    WoDeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(@"wodeCell")];
    [cell setImage: icons[indexPath.row] text: titles[indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *viewControllersName = self.myList[@"vcsName"];
    NSString *vcName = viewControllersName[indexPath.row];
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
    if (![vcName isEqualToString:@"Nil"]) {
        //跳转到相应页面
        UIViewController *nextVC;
        UIStoryboard *profile = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
        if ([vcName isEqualToString:@"MyProfileViewController"]) {
            nextVC = [profile instantiateViewControllerWithIdentifier:@"MYPROFILE"];
        }else if ([vcName isEqualToString:@"MyTrendsViewController"]) {
            nextVC = [profile instantiateViewControllerWithIdentifier:@"MYTRENDS"];
        }else {
            Class vcClass = NSClassFromString(vcName);
            nextVC = [[vcClass alloc] init];
        }
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:true];
    }else {
        [LoadingView showDownCenter:self.view messages:@[@"敬请期待！"]];
        NSLog(@"敬请期待！");
    }
}

- (void)deselect {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
