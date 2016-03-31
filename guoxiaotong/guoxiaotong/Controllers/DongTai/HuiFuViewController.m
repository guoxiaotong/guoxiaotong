//
//  HuiFuViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "HuiFuViewController.h"
#import "FangWeiViewController.h"
#import "PhotoViewController.h"
#import "XuanZhePhonData.h"
#import "ChooseMenSingle.h"

#import "LoadAlassetData.h"
#import "DataManager.h"
#import "TongXunmodel.h"

@interface HuiFuViewController ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITextView *_textView;
    
    int _height;//键盘高
    
    UIView *_butnView;
    
    UIButton *_button;//发送范围按钮
    
    NSMutableArray *_mImageArry;
    
    UIView *_imView;//用于展示选中图片的UIview
    
    UILabel * _tisileabel;//用于提示只能选中9张
    
    NSMutableArray *_fanweiArry;//发送范围

}

@end

@implementation HuiFuViewController
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=YES;
    _mImageArry=[[NSMutableArray alloc]init];
    
    XuanZhePhonData *data=[XuanZhePhonData shareImage];
    
    _mImageArry=data.imarry;
    
    [_imView removeFromSuperview];
    
    _imView=nil;
    [self creatImageView];
    
    _fanweiArry=[[NSMutableArray alloc]init];
    ChooseMenSingle *chooSingle=[ChooseMenSingle shareChooseMen];
    _fanweiArry=chooSingle.huiFuRangArry;
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.navigationItem.title=self.naTitle;
    
  
    //增加监听，当键盘出现或改变时收消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
    [self creatText:0];
    
//    [self creatImageView];

    [self creatBarButt];
    
    [self loadData];
    
   
}
-(void)loadData{
    LoadAlassetData*Alasset=[LoadAlassetData   shareManager];
    Alasset.getImage=^(ALAsset*result){
 
    };
    
}


-(void)creatImageView{

    if (_mImageArry.count) {
       
        NSInteger a=_mImageArry.count/4+1;
        _imView=[[UIView alloc]initWithFrame:CGRectMake(0, 200, screen_Width, ((screen_Width-50)/4+5)*a)];
        
        for (int i=0; i<_mImageArry.count+1; i++) {
            
            UIButton *imgbtn=[UIButton buttonWithType:UIButtonTypeCustom];
            imgbtn.frame=CGRectMake(10+(screen_Width)/4*(i%4), (screen_Width)/4*(i/4), (screen_Width-50)/4, (screen_Width-50)/4);
            
            if (i<_mImageArry.count) {
                
                [imgbtn setImage:_mImageArry[i] forState:UIControlStateNormal];
            }else{
                [imgbtn setImage:[UIImage imageNamed:@"hx_roominfo_add_btn_pressed"] forState:UIControlStateNormal];
                }
            [_imView addSubview:imgbtn];
            
            imgbtn.tag=1550+i;
            
            [imgbtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        [_textView removeFromSuperview];
        _textView=nil;
        [self creatText:2];
        [self.view addSubview:_imView];
    }
   
}
//点击有图片的按钮
-(void)imgBtnClick:(UIButton *)bbtt{
    
    //点击+图片后
    NSLog(@"%ld",bbtt.tag-1550);

    if (bbtt.tag==_mImageArry.count+1550) {
//        PhotoViewController *photoVc=[[PhotoViewController alloc]init];
//        [self.navigationController pushViewController:photoVc animated:YES];
        
        [self tupiBtnClick];

    }
   

}

-(void)creatText:(int)gao{

    _textView.backgroundColor=[UIColor redColor];
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0,0, screen_Width, screen_Height-290)];
    [_textView becomeFirstResponder];
    _textView.delegate=self;
//    _textView.scrollEnabled=YES;
    _textView.showsVerticalScrollIndicator=YES;
    _textView.showsHorizontalScrollIndicator=YES;
    _textView.userInteractionEnabled=YES;
    _textView.editable=YES;
    if (gao==1) {
        
        _textView.frame=CGRectMake(0, 0, screen_Width, screen_Height-100);
    }if (gao==2) {
        
        _textView.frame=CGRectMake(0, 0, screen_Width, 192);
    }
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [_textView addGestureRecognizer:pan];

    [self.view addSubview:_textView];
    
    

}


-(void)pan:(UIPanGestureRecognizer *)pan{

    [_textView resignFirstResponder];
   

}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _height = keyboardRect.size.height;
    
//    [_textView removeFromSuperview];
//    
//    [self creatText:1];
   
    [self creatView:0];
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [_butnView removeFromSuperview];
    [_button removeFromSuperview];
    _butnView=nil;
    _button=nil;
    
   [self creatView:1];
    
//    [_textView removeFromSuperview];
//    
//    [self creatText:0];

}

//输入框下的按钮
-(void)creatView:(int)height{
    [_button removeFromSuperview];
    [_butnView removeFromSuperview];
    _button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _button.frame=CGRectMake(10, screen_Height-_height-64-70, 60, 20);
    
    
    _butnView=[[UIView alloc]initWithFrame:CGRectMake(0, screen_Height-_height-64-40, screen_Width, 40)];
    if (height==1) {
        [UIView animateWithDuration:0.1 animations:^{
            _butnView.center=CGPointMake(screen_Width/2, screen_Height-20-64);
            _button.center=CGPointMake(40, screen_Height-60-64);
            
        }];
    }
    
    
    _button.titleLabel.font=[UIFont systemFontOfSize:12];
    [_button setTitle:@"发送范围" forState:UIControlStateNormal];
    [_button.layer setCornerRadius:10];
    [_button.layer setBorderWidth:2];
    [_button.layer setBorderColor:[RGBA(65,105, 225, 1) CGColor]];
    [_button addTarget:self action:@selector(_buttonClick) forControlEvents:UIControlEventTouchUpInside];


    _butnView.backgroundColor=RGBA(220, 220, 220, 0.8);
    
    [self.view addSubview:_button];
    [self.view addSubview:_butnView];
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame=CGRectMake(screen_Width/4-15, 5, 30, 20);
    [btn1 setImage:[UIImage imageNamed:@"iconfont-tupian.png"] forState:UIControlStateNormal];
    [_butnView addSubview:btn1];
    [btn1 addTarget:self action:@selector(tupiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame=CGRectMake(screen_Width*3/4-15, 5, 30, 20);
    [btn2 setImage:[UIImage imageNamed:@"iconfont-aite.png"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(aiteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_butnView addSubview:btn2];

}
//点击@图标后
-(void)aiteBtnClick{
    
    FangWeiViewController *fwVc=[[FangWeiViewController alloc]init];
    [self.navigationController pushViewController:fwVc animated:YES];

}
//点击相机图标后
-(void)tupiBtnClick{
   // 创建操作表对象
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"请选择获取方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"照相" ,nil];
    
    [action  showInView:self.view];


    [self.view addSubview:action];
    [_textView resignFirstResponder];

}
#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    switch (buttonIndex)
    {
        case 0:  //打开本地相册
            [self LocalPhoto];
            break;
            
        case 1:  //打开照相机拍照
            [self takePhoto];
            break;
    }

    
    
}
//打开照相机拍照
-(void)takePhoto{

    if (_mImageArry.count<9) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            [[[UIAlertView alloc]initWithTitle:@"逗我呢" message:@"你有摄像头么" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            return;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];    picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];

    }else{
        
        [self tisiLabel:@"最多只能选择9张"];
    }
   
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    __block UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [_mImageArry addObject:image];
    
}


-(void)LocalPhoto{
//    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
//    pick.delegate = self;
//    [self presentViewController:pick animated:YES completion:nil];

    
    PhotoViewController *pcVC=[[PhotoViewController alloc]init];
    pcVC.imageViewArry=_mImageArry;

    [self.navigationController pushViewController:pcVC animated:YES];
    
   
}
#pragma mark - UIImagePickerControllerDelegate
//当选中相册中的某张图片时，调用
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    
//    //取得选中图片的原图
//    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    self.myImageView.image = image;
//    NSData *data;
//    if (UIImagePNGRepresentation(image) == nil)
//    {
//        data = UIImageJPEGRepresentation(image, 1.0);
//    }
//    else
//    {
//        data = UIImagePNGRepresentation(image);
//    }
//    
//  NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    //文件管理器
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
//    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
//    
//    //得到选择后沙盒中图片的完整路径
//   NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
//    
//    //关闭相册界面
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    //创建一个选择后图片的小图标放在下方
//    //类似微薄选择图后的效果
//    UIImageView *smallimage = [[UIImageView alloc] initWithFrame:CGRectMake(50, 120, 40, 40) ];
//    
//    smallimage.image = image;
//    //加在视图中
//    [self.view addSubview:smallimage];
//    
//    
//}
//点击cancel调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//添加导航栏左右边的发布,取消按钮
-(void)creatBarButt{
    
    UIButton *ritBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    ritBtn.frame=CGRectMake(screen_Width-25, 0, 50, 50);
    
    [ritBtn setTitle:@"发布" forState:UIControlStateNormal];
    
    [ritBtn addTarget:self action:@selector(ritBtnClik) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ritBarBtn=[[UIBarButtonItem alloc]initWithCustomView:ritBtn];
    
    self.navigationItem.rightBarButtonItem=ritBarBtn;
    
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    leftBtn.frame=CGRectMake(0, 0, 50, 50);
    
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(leftBtnClik) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarBtn=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem=leftBarBtn;
    
    
}
//点击发布
-(void)ritBtnClik{
    
    SingleUserInfo *sing=[SingleUserInfo shareUserInfo];
    
    if ( _fanweiArry.count==0) {
        NSLog(@"你还没选择发送范围");
        
        [self tisiLabel:@"你还没选择发送范围"];
    }else{
         [LoadingView showCenterActivity:self.view];
        
        NSMutableArray *fanmarry=[[NSMutableArray alloc]init];
        for (int i=0; i<_fanweiArry.count; i++) {
            TongXunmodel *model=_fanweiArry[i];
            [fanmarry addObject:model.userId];
            
        }
        NSString *receStr=[fanmarry componentsJoinedByString:@","];
        
        if (_mImageArry.count) {
            //有图片时
            NSMutableArray *imagDataArry=[[NSMutableArray alloc]init];
            
            for (int i=0; i<_mImageArry.count; i++) {
                NSData *imageData=UIImagePNGRepresentation(_mImageArry[i]);
                [imagDataArry addObject:imageData];
            }
            
            //        NSString *imgStr=[imagDataArry componentsJoinedByString:@","];
            
            NSString *str=@"http://121.42.27.199:8888/csCampus/user/upload.page";
            
            //3创建网络请求对象
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            //系统默认有一个等待加载符
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
            //4发起POST上传文件的请求
            [manager POST:str parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                for (int i=0; i<imagDataArry.count; i++) {
                    
                    [formData  appendPartWithFileData:imagDataArry[i] name:@"file" fileName:@"png" mimeType:@"image/png"];
                    
                }
                
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //请求成功
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                NSLog(@"%@",dict);
                NSString *url=dict[@"url"];
                //上传成功后
                
                NSString *str=@"http://121.42.27.199:8888/csCampus/dynamic/send.page";
                
                NSDictionary *Dict=@{@"receivers":receStr ,@"type":@1,@"content":_textView.text,@"picPath":url,@"userId":sing.userId};
                AFHTTPRequestOperationManager *requst = [AFHTTPRequestOperationManager manager];
                //设置响应格式为NSData
                requst.responseSerializer = [AFHTTPResponseSerializer serializer];
                
                [requst  POST:str parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    NSLog(@"%@",dict);
                    [LoadingView hideCenterActivity:self.view];
                    
                    [self tisiLabel:@"发送成功"];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
                /******************/
                
                XuanZhePhonData *xuanzhe=[XuanZhePhonData shareImage];
                [xuanzhe.imarry removeAllObjects];
                [_imView removeFromSuperview];
                _imView=nil;
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //请求失败
                NSLog(@"%@",error.debugDescription);
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }];
            
            
        }
        
        //只有文字内容
        NSString *str=@"http://121.42.27.199:8888/csCampus/dynamic/send.page";
        
        NSDictionary *Dict=@{@"receivers":receStr ,@"type":@1,@"content":_textView.text,@"userId":sing.userId};
        AFHTTPRequestOperationManager *requst = [AFHTTPRequestOperationManager manager];
        //设置响应格式为NSData
        requst.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [requst  POST:str parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSLog(@"%@",dict);
            [LoadingView hideCenterActivity:self.view];
            [self tisiLabel:@"发送成功"];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    
    }
    
    
}

//点击取消
-(void)leftBtnClik{

    [self.navigationController popViewControllerAnimated:YES];

}

//点击发送范围按钮
-(void)_buttonClick{

    FangWeiViewController *fwVc=[[FangWeiViewController alloc]init];
    [self.navigationController pushViewController:fwVc animated:YES];


}
//弹出的提示框
-(void)tisiLabel:(NSString *)str{

    [_tisileabel removeFromSuperview];
    _tisileabel=[[UILabel alloc]initWithFrame:CGRectMake((screen_Width-180)/2, 300, 180, 50)];
    _tisileabel.backgroundColor=RGBA(41, 36, 33, 1);
    _tisileabel.text=str;
    _tisileabel.textAlignment=NSTextAlignmentCenter;
    CALayer *layer=[_tisileabel layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5];
    
    [self.view addSubview:_tisileabel];
    [UIView animateWithDuration:3 animations:^{
        _tisileabel.alpha=0;
        
    }];





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
