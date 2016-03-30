//
//  WoDeViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "WoDeViewController.h"
#import "WoDeTableViewCell.h"
#import <UIImageView+WebCache.h>

#import "SettingViewController.h"
#import "MyProfileViewController.h"
#import "RoleListViewController.h"
#import "MyAddressListViewController.h"
#import "MyCollectionViewController.h"
#import "MyIntergrationViewController.h"
#import "MyTrendsViewController.h"
#import "MyAppsViewController.h"

#import "BasicService.h"
#import "UserService.h"

@interface WoDeViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActionSheet *sheet;
@property (nonatomic, strong) UIImagePickerController *imagePicker ;
@property (nonatomic, strong) UIFont *font;

@end

@implementation WoDeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.header.detailLabel.text) {
        SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
        self.header.detailLabel.text = shareInfo.userName;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
}

//- (UIImagePickerController *)imagePicker {
//    if (!_imagePicker) {
//        _imagePicker = [[UIImagePickerController alloc] init];
//        _imagePicker.delegate = self;
//    }
//    return _imagePicker;
//}

#pragma mark - UI及固定数据设置
- (void)setUpUI {
//右上角设置按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:[UIImage imageNamed:@"naviBar_setting"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    基础设置
//    _headerHeight = 150;
    _font = [UIFont systemFontOfSize:14.0];
    
    [self setUpHeaderView];
    [self setUpTableView];
}

- (void)setUpHeaderView {
    SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
    NSString *picUrl = [NSString stringWithFormat:@"%@%@", API_ROOT_IMAGE_URL, shareInfo.picPath];
    [self.header.imageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"default_user_icon"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
    self.header.imageView.userInteractionEnabled = YES;
    [self.header.imageView addGestureRecognizer:tap];
    
    UIButton *singInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    singInButton.frame = CGRectMake(CGRectGetMaxX(self.header.detailLabel.frame)-120, self.header.detailLabel.frame.origin.y, 100, 30);
    singInButton.backgroundColor = [UIColor colorWithRed:229/225.0 green:99/225.0 blue:99/225.0 alpha:1.0];
    singInButton.layer.cornerRadius = 5;
    [singInButton setTitle:@"我要签到" forState:UIControlStateNormal];
    singInButton.titleLabel.font = _font;
    [singInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [singInButton addTarget:self action:@selector(singInClick) forControlEvents:UIControlEventTouchUpInside];
    [self.header addSubview:singInButton];
    
}

- (void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerHeight, self.view.frame.size.width, HEIGHT - 112 - self.headerHeight) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"WoDeTableViewCell" bundle:nil] forCellReuseIdentifier:@"wodeCell"];
}

- (void)imageClick {
    if (!self.imagePicker) {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
    }
    self.sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
    [self.sheet showInView:self.view];
}

- (void)singInClick {
    ////
    BasicService *service = [[BasicService alloc] initWithView:self.view];
    __weak typeof (*&self)weakSelf = self;
    [service doTask:@"sign" callBack:^(NSInteger code, NSString *msg, NSString *reward, NSString *totalPoint, NSString *lastDay) {
        if (code == 0) {
            [LoadingView showDownCenter:weakSelf.view messages:@[[NSString stringWithFormat:@"签到成功，积分+%@", reward]]];
        }else {
            [LoadingView showDownCenter:weakSelf.view messages:@[msg]];
        }
    }];
}

- (void)setting {
    SettingViewController *set = [[SettingViewController alloc] init];
    set.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:set animated:true];
}

#pragma mark - 从相机或相册获取图片
- (void)getPhotoFromCamera {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        //设置拍照后的图片可被编辑
        _imagePicker.allowsEditing = YES;
        _imagePicker.sourceType = sourceType;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void)getPhotoFromAlbum {
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

#pragma mark - imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]){
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil){
            data = UIImageJPEGRepresentation(image, 0.3);
        }else{
            data = UIImagePNGRepresentation(image);
        }
        __weak typeof (*&self)weakSelf = self;
        BasicService *service = [[BasicService alloc] initWithView:self.view];
        [service uploadImage:data callBack:^(BOOL isSuccess, NSString *picPath) {
            if (isSuccess) {
                SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
                weakSelf.header.imageView.image = [weakSelf cutImage:image];
                shareInfo.picPath = picPath;
                UserService *manager = [[UserService alloc] initWithView:weakSelf.view];
                NSDictionary *params = @{@"userId": shareInfo.userId, @"picPath": picPath};
                [manager editIconWithParams:params callBack:^(BOOL isSuccess) {
                    //修改成功
                }];
            }
        }];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    if ((image.size.width / image.size.height) < (_imageView.frame.size.width / _imageView.frame.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * _imageView.frame.size.height / _imageView.frame.size.width;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * _imageView.frame.size.width / _imageView.frame.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
    }
    return [UIImage imageWithCGImage:imageRef];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WoDeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:(@"wodeCell")];
    switch (indexPath.row) {
        case 0:
            cell.imageV.image = [UIImage imageNamed:@"myList_ziliao"];
            cell.titleLabel.text = @"我的资料";
            break;
        case 1:
            cell.imageV.image = [UIImage imageNamed:@"myList_jiaose"];
            cell.titleLabel.text = @"我的角色";
            break;
        case 2:
            cell.imageV.image = [UIImage imageNamed:@"myList_tongxunlu"];
            cell.titleLabel.text = @"我的通讯录";
            break;
        case 3:
            cell.imageV.image = [UIImage imageNamed:@"myList_shoucang"];
            cell.titleLabel.text = @"我的收藏";
            break;
        case 4:
            cell.imageV.image = [UIImage imageNamed:@"myList_jifen"];
            cell.titleLabel.text = @"我的积分";
            break;
        case 5:
            cell.imageV.image = [UIImage imageNamed:@"myList_dongtai"];
            cell.titleLabel.text = @"我的动态";
            break;
        case 6:
            cell.imageV.image = [UIImage imageNamed:@"myList_apps"];
            cell.titleLabel.text = @"我的应用";
            break;
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.1f];
    UIViewController *nextVC;
    switch (indexPath.row) {
        case 0:
        {
            nextVC = [[MyProfileViewController alloc] init];
        }break;
        case 1:
        {
            nextVC = [[RoleListViewController alloc] init];
        }break;
        case 2:
        {
            nextVC = [[MyAddressListViewController alloc] init];
        }break;
        case 3:
        {
            nextVC = [[MyCollectionViewController alloc] init];
        }break;
        case 4:
        {
            nextVC = [[MyIntergrationViewController alloc] init];
        }break;
        case 5:
        {
            nextVC = [[MyTrendsViewController alloc] init];
        }break;
        case 6:
        {
            nextVC = [[MyAppsViewController alloc] init];
        }break;
        default:
            break;
    }
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)deselect {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
