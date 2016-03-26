//
//  AddXiaoZhangViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "AddXiaoZhangViewController.h"
#import "UploadView.h"
#import "BasicService.h"
#import "CustomView.h"
#import "ListPickerView.h"
#import "SchoolModel.h"

@interface AddXiaoZhangViewController ()<UITextFieldDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UITextField *cityTextField;
@property (strong, nonatomic) UITextField *schoolTextField;
@property (strong, nonatomic) UITextField *contactTextField;
@property (strong, nonatomic) UITextField *jobTextField;
@property (strong, nonatomic) UITextField *phoneTextField;
@property (strong, nonatomic) UIView *datasListView;
@property (strong, nonatomic) UIButton *addButton;

@property (strong, nonatomic) UILabel *desBottomLabel;
@property (strong, nonatomic) UIButton *submitButton;

@property (assign, nonatomic) CGFloat height;
@property (nonatomic, assign) NSInteger num_x;
@property (nonatomic, assign) NSInteger num_y;
@property (nonatomic, assign) CGFloat wid;
@property (nonatomic, assign) CGFloat step;
@property (nonatomic, assign) NSInteger imageSum;
@property (strong, nonatomic) NSMutableArray *imagesArray;
@property (strong, nonatomic) NSMutableArray *picPathArray;

@property (nonatomic, strong) UIImagePickerController *imagePicker ;
@property (nonatomic, strong) UIActionSheet *sheet;
@property (nonatomic, copy) NSString *picPath;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) NSString *schoolId;
@property (nonatomic, strong) ListPickerView *listPicker;

@end

@implementation AddXiaoZhangViewController

- (ListPickerView *)listPicker {
    if (!_listPicker) {
        _listPicker = [[ListPickerView alloc] init];
    }
    return _listPicker;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加角色-校长";
    [self setUI];
}

- (void)setUI {
    [self setUpTopView];
    [self setUpBottomView];

}

- (void)setUpTopView {
    UIFont *desFont = [UIFont systemFontOfSize:13.0];

    UIColor *desColor = [UIColor lightGrayColor];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 400)];
    
    UILabel *desTopLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    desTopLabel.textAlignment = NSTextAlignmentCenter;
    desTopLabel.text = @"注：校长需要提交资料国校通后台审核";
    desTopLabel.font = desFont;
    desTopLabel.textColor = desColor;
    [self.scrollView addSubview:desTopLabel];
    [self viewWithTitle:@"城市" placeHolder:nil index:0];
    [self viewWithTitle:@"学校" placeHolder:@"请选择学校" index:1];
    [self viewWithTitle:@"联系人" placeHolder:@"请输入联系人" index:2];
    [self viewWithTitle:@"联系人职位" placeHolder:@"请输入联系人职位" index:3];
    [self viewWithTitle:@"联系电话" placeHolder:@"请输入联系电话" index:4];

    UILabel *desCenterLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 6*_height, WIDTH-40, _height)];
    desCenterLabel.textAlignment = NSTextAlignmentRight;
    desCenterLabel.textColor = desColor;
    desCenterLabel.text = @"留有联系人电话方便我们尽快和您联系";
    desCenterLabel.font = desFont;
    [self.scrollView addSubview:desCenterLabel];
    
//    [self.scrollView addSubview:view];
}

- (void)viewWithTitle:(NSString *)title placeHolder:(NSString *)placeholder index:(NSInteger)index {
    UIFont *titleFont = [UIFont boldSystemFontOfSize:16.0];
    UIFont *textFont = [UIFont systemFontOfSize:14.0];
    _height = 45;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _height*(index+1), WIDTH, _height)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, _height-10)];
    titleLabel.text = title;
    titleLabel.font = titleFont;
    [view addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(120, 5, WIDTH-140, _height-10)];
    textField.delegate = self;
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleNone;
    textField.layer.borderWidth = 0.5;
    textField.layer.cornerRadius = 5;
    textField.layer.borderColor = SEAECH_VIEW_BACK_COLOR.CGColor;
    textField.clipsToBounds = YES;
    textField.placeholder = placeholder;
    textField.font = textFont;
    [view addSubview:textField];
    switch (index) {
        case 0:
//            [textField setTextFieldRightPadding:@"search_icon" forWidth:30];
            _cityTextField = textField;
            break;
        case 1:
            [textField setTextFieldRightPaddingList];
            _schoolTextField = textField;
            break;
        case 2:
//            [textField setTextFieldRightPaddingList];
            _contactTextField = textField;
            break;
        case 3:
//            [textField setTextFieldRightPaddingList];
            _jobTextField = textField;
            break;
        case 4:
//            [textField setTextFieldRightPaddingList];
            _phoneTextField = textField;
            break;
            
        default:
            break;
    }
    [self.scrollView addSubview:view];
}

- (void)setUpBottomView {
    CGFloat Y = 8*_height;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, Y, WIDTH-40, _height)];
    titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
    titleLabel.text = @"上传资料";
    [self.scrollView addSubview:titleLabel];
    
    _wid = 45;
    _imageSum = 0;
    _imagesArray = [NSMutableArray array];
    _picPathArray = [NSMutableArray array];
    
    _datasListView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame), WIDTH-40, _wid+50)];
    _datasListView.clipsToBounds = YES;
    _datasListView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _datasListView.layer.cornerRadius = 5;
    _datasListView.layer.borderWidth = 0.5;
    
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(10, 10, _wid, _wid);
    [_addButton setImage:[UIImage imageNamed:@"add_data"] forState:UIControlStateNormal];
    _addButton.clipsToBounds = YES;
    _addButton.layer.cornerRadius = 5;
    _addButton.layer.borderWidth = 0.5;
    _addButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [_datasListView addSubview:_addButton];
    
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _datasListView.frame.size.height-30, _datasListView.frame.size.width-40, 30)];
    addLabel.text = @"添加附件";
    addLabel.font = [UIFont systemFontOfSize:14.0];
    [_datasListView addSubview:addLabel];
    
    [self.scrollView addSubview:_datasListView];
    
    _desBottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_datasListView.frame)+5, WIDTH-40, 30)];
    _desBottomLabel.font = [UIFont systemFontOfSize:13.0];
    _desBottomLabel.textColor = [UIColor lightGrayColor];
    _desBottomLabel.text = @"上传营业执照的副本/教师资格证书/身份证";
    [self.scrollView addSubview:_desBottomLabel];
    
    _submitButton = [CustomView buttonWithTitle:@"提交" width:100 orginY:CGRectGetMaxY(_desBottomLabel.frame)+40];
    [_submitButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_submitButton];
    
    if (CGRectGetMaxY(_submitButton.frame) < HEIGHT) {
        self.scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    }else {
        self.scrollView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(_submitButton.frame)+50);
    }
}

#pragma mark - 数据操作
- (void)submitClick {
    if ([_schoolTextField isEmpty] || [_contactTextField isEmpty] || [_jobTextField isEmpty] || [_phoneTextField isEmpty] || !_picPathArray.count) {
        [LoadingView showBottom:self.view messages:@[@"完善资料"]];
    }else {
        __weak typeof (*&self)weakSelf = self;
        SingleUserInfo *shareInfo = [SingleUserInfo shareUserInfo];
        BasicService *service = [[BasicService alloc] initWithView:self.view];
        NSDictionary *params = @{@"schoolId": _schoolId, @"userId": shareInfo.userId, @"connectMan": _contactTextField.text, @"connectPhone": _phoneTextField.text, @"job": _jobTextField.text, @"picPath": [_picPathArray componentsJoinedByString:@","]};
        [service applyForHeader:params callBack:^(BOOL isSuccess) {
            if (isSuccess) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}

#pragma mark - 界面变化
- (void)addImage {
    _imageSum++;
    _num_x = (WIDTH-40)/(_wid+20);
    if ((_imageSum+1)%_num_x == 0) {
        _num_y = (_imageSum+1)/_num_x;
    }else {
        _num_y = (_imageSum+1)/_num_x + 1 ;
    }
    _step = (WIDTH-60-_num_x*_wid)/(_num_x-1);
    
    _datasListView.frame = CGRectMake(20, _datasListView.frame.origin.y, WIDTH-40, (_wid+20)*_num_y+30);
    
    for (UIView *v in _datasListView.subviews) {
        if ([v isKindOfClass:[UILabel class]]) {
            v.frame = CGRectMake(20, _datasListView.frame.size.height-30, _datasListView.frame.size.width-40, 30);
        }else {
            if (v.frame.origin.x+_wid+10 == _datasListView.frame.size.width) {
                v.frame = CGRectMake(10, v.frame.origin.y+_wid+20, _wid, _wid);
            }else {
                v.frame = CGRectMake(v.frame.origin.x+_step+_wid, v.frame.origin.y, _wid, _wid);
            }
        }
    }
    
    UploadView *view = [[UploadView alloc] initWithFrame:CGRectMake(10, 10, _wid, _wid)];
    view.index = _imageSum-1;
    _index = view.index;
    view.picPath = _picPath;
    [_picPathArray addObject:_picPath];
    __weak typeof (*&self)weakSelf = self;
    view.delCallBack = ^(NSInteger index, NSString *path) {
        NSLog(@"删除的%@", path);
        [weakSelf.imagesArray removeObjectAtIndex:index];
        [weakSelf.picPathArray removeObject:path];
        NSLog(@"%@", weakSelf.picPathArray);
        for (UploadView *uV in weakSelf.imagesArray) {
            if (uV.index>=index) {
                uV.index--;
            }
        }
        [weakSelf deleteImage];
    };
    [_imagesArray addObject:view];
    [_datasListView addSubview:view];
    
    _desBottomLabel.frame = CGRectMake(20, CGRectGetMaxY(_datasListView.frame)+5, WIDTH-40, 30);
    _submitButton.frame = CGRectMake((WIDTH-100)/2, CGRectGetMaxY(_desBottomLabel.frame)+40, 100, 30);
    if (CGRectGetMaxY(_submitButton.frame) < HEIGHT) {
        self.scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    }else {
        self.scrollView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(_submitButton.frame)+50);
    }
}

- (void)deleteImage {
    _imageSum--;
    _num_x = (WIDTH-40)/(_wid+20);
    if ((_imageSum+1)%_num_x == 0) {
        _num_y = (_imageSum+1)/_num_x;
    }else {
        _num_y = (_imageSum+1)/_num_x + 1 ;
    }
    _step = (WIDTH-60-_num_x*_wid)/(_num_x-1);
    
    _datasListView.frame = CGRectMake(20, _datasListView.frame.origin.y, WIDTH-40, (_wid+20)*_num_y+30);
    
    for (UIView *v in _datasListView.subviews) {
        if ([v isKindOfClass:[UILabel class]]) {
            v.frame = CGRectMake(20, _datasListView.frame.size.height-30, _datasListView.frame.size.width-40, 30);
        }else if ([v isKindOfClass:[UploadView class]]){
            [v removeFromSuperview];
        }else {
            if (v.frame.origin.x == 10) {
                if (v.frame.origin.y == 10) {
                    
                }else {
                    v.frame = CGRectMake(_datasListView.frame.size.width-10-_wid, v.frame.origin.y-20-_wid, _wid, _wid);
                }
            }else {
                v.frame = CGRectMake(v.frame.origin.x-_wid-_step, v.frame.origin.y, _wid, _wid);
            }
        }
    }
    for (NSInteger i = 0; i < _imagesArray.count; i++) {
        UploadView *view = _imagesArray[i];
        view.frame = CGRectMake(10+(_wid+_step)*(i%_num_x), 10+(_wid+20)*(i/_num_x), _wid, _wid);
        [_datasListView addSubview:view];
    }
    
    _desBottomLabel.frame = CGRectMake(20, CGRectGetMaxY(_datasListView.frame)+5, WIDTH-40, 30);
    _submitButton.frame = CGRectMake((WIDTH-100)/2, CGRectGetMaxY(_desBottomLabel.frame)+40, 100, 30);
    if (CGRectGetMaxY(_submitButton.frame) < HEIGHT) {
        self.scrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    }else {
        self.scrollView.contentSize = CGSizeMake(WIDTH, CGRectGetMaxY(_submitButton.frame)+50);
    }
}

#pragma mark - 添加图片操作
- (void)addClick {
    if (!self.imagePicker) {
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
    }
    self.sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
    [self.sheet showInView:self.view];
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _schoolTextField) {
        BasicService *service = [[BasicService alloc] initWithView:self.view];
        __weak typeof (*&self)weakSelf = self;
        [self.view endEditing:YES];
        if ([_cityTextField isEmpty]) {
            [LoadingView showBottom:self.view messages:@[@"城市不能为空"]];
        }else {
            _schoolId = nil;
            [service getSchoolListWithCityName:_cityTextField.text callBack:^(BOOL isSuccess, NSArray *schoolList) {
                if (isSuccess && schoolList.count) {
                    [weakSelf.listPicker.dataList addObjectsFromArray:schoolList];
                    [weakSelf.listPicker show];
                    weakSelf.listPicker.SureCallBack = ^(id model) {
                        if (model) {
                            SchoolModel *schoolModel = model;
                            weakSelf.schoolTextField.text = schoolModel.name;
                            weakSelf.schoolId = schoolModel.schoolId;
                        }
                    };
                }else {
                    [LoadingView showBottom:weakSelf.view messages:@[@"获取失败或未找到该城市学校信息"]];
                }
            }];
        }
        return NO;
    }else {
        return YES;
    }
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
                weakSelf.picPath = picPath;
                [weakSelf addImage];
               UploadView *uV = weakSelf.imagesArray[weakSelf.index];
                uV.imageV.image = [weakSelf cutImage:image];
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
    if ((image.size.width / image.size.height) < (_wid / _wid)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height;
        
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

@end
