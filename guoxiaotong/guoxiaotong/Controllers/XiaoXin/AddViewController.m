//
//  AddViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "AddViewController.h"
#import "addTableViewCell.h"
#import "addNameTableViewCell.h"
#import "qunTouXiangTableViewCell.h"
#import "ChooseMemberViewController.h"

#define BTN_Width ([UIScreen mainScreen].bounds.size.width-50)/5-5


@interface AddViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UITableView *_basiscTabView;
    
    int num;

}
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    num=7;

    self.navigationItem.title=@"添加群聊";
    
    //添加导航栏右边的确定按钮
    [self creatRightBtn];
    
    //创建tableview
    [self creatTableview];
    
    
}

//添加导航栏右边的确定按钮
-(void)creatRightBtn{
    
    UIButton *ritBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    ritBtn.frame=CGRectMake(screen_Width-25, 0, 50, 50);
    
    [ritBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [ritBtn addTarget:self action:@selector(ritBtnClik) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ritBarBtn=[[UIBarButtonItem alloc]initWithCustomView:ritBtn];
    
    self.navigationItem.rightBarButtonItem=ritBarBtn;


}
//点击确定按钮后响应
-(void)ritBtnClik{



}

-(void)creatTableview{
    
    _basiscTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];
    
    _basiscTabView.dataSource=self;
    
    _basiscTabView.delegate=self;
    
//    _basiscTabView.backgroundColor=RGBA(220, 220, 220, 1);
    
    _basiscTabView.bounces=NO;
    
    [self.view addSubview:_basiscTabView];

}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==1) {
        return 2;
    }else{
        return 1;
    
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *cellID=@"cellName";
    
    if (indexPath.section==0) {
        addTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"addTableViewCell" owner:self options:nil]firstObject];
        }
        
        cell.selectionStyle=NO;
        
        cell.backImageView.userInteractionEnabled=YES;
        
        //设置layer
        CALayer *layer=[cell.backImageView layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框圆角的弧度
        [layer setCornerRadius:5];
        //设置边框线的宽
        //
        [layer setBorderWidth:2];
        //设置边框线的颜色
        [layer setBorderColor:[RGBA(220, 220, 220, 0.5) CGColor]];
        
            for (int i=0; i<num+1; i++) {
                
                UIButton *but=[UIButton buttonWithType:UIButtonTypeRoundedRect];

                but.frame=CGRectMake(5+(BTN_Width+10)*(i%5), 5+(BTN_Width+30)*(i/5), BTN_Width, BTN_Width+20);
                
                UIImageView *UserImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BTN_Width, BTN_Width)];
                
                UILabel *userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, BTN_Width, BTN_Width, 20)];
                
                
                [but addSubview:UserImageView];
                
                [but addSubview:userNameLabel];
                
                
                if (i==num) {
                    
                    UserImageView.image=[UIImage imageNamed:@"news.png"];
                    
                    [but addTarget:self action:@selector(tianJiaClick) forControlEvents:UIControlEventTouchUpInside];
                    
                }else{
                
                    
                    UserImageView.image=[UIImage imageNamed:@"res_art"];
                    
                    userNameLabel.text=@"UserName";
                    
                    userNameLabel.font=[UIFont systemFontOfSize:12];
                    
                    userNameLabel.textAlignment=NSTextAlignmentCenter;
                    
                    UIButton *deleteBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
                    
                    deleteBtn.frame=CGRectMake(0, 0, 10, 10);
                    
                    [deleteBtn setImage:[UIImage imageNamed:@"res_manage"] forState:UIControlStateNormal];
                    
                    //点击删除角标
                    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
                    

                    
                    [but addSubview:deleteBtn];
                    
                }
                
                
                
                [cell.backImageView addSubview:but];
            }
        
        
        return cell;
        
    }else if (indexPath.section==1){
        
        addNameTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"addNameTableViewCell" owner:self options:nil]firstObject];
        }
        
        //设置layer
        CALayer *layer=[cell.contentView layer];
        //是否设置边框以及是否可见
        [layer setMasksToBounds:YES];
        //设置边框圆角的弧度
//        [layer setCornerRadius:5];
        //设置边框线的宽
        //
        [layer setBorderWidth:2];
        //设置边框线的颜色
        [layer setBorderColor:[RGBA(220, 220, 220, 0.5) CGColor]];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
            return cell;
    
    }else{
        
        qunTouXiangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"qunTouXiangTableViewCell" owner:self options:nil]firstObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        [cell.pictureBtn addTarget:self action:@selector(pictureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    
    }
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        return 25+(BTN_Width+30)*(1+num/5);
    }else{
    
        return 60;
    
    }}
//点击删除角标
-(void)deleteBtnClick{
    num--;

    [_basiscTabView reloadData];

}

//点击添加按钮
-(void)tianJiaClick{

    ChooseMemberViewController *chooseMen=[[ChooseMemberViewController alloc]init];
    
    [self.navigationController pushViewController:chooseMen animated:YES];
}

//点击上传照片
-(void)pictureBtnClick{

    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    backImageView.backgroundColor=RGBA(41, 36, 33, 0.9);
    
    [self.tabBarController.view addSubview:backImageView];
    
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btn1.backgroundColor=[UIColor whiteColor];
    
    btn1.frame=CGRectMake(40, screen_Height/2-40, screen_Width-80, 40);
    
    [btn1 setTitle:@"相机" forState:UIControlStateNormal];
    
    btn1.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    
     btn1.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btn2.backgroundColor=[UIColor whiteColor];
    
    btn2.frame=CGRectMake(40, screen_Height/2, screen_Width-80, 40);
    
    [btn2 setTitle:@"相册" forState:UIControlStateNormal];
    
    btn2.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    
    btn2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    [backImageView addSubview:btn1];
    
    [backImageView addSubview:btn2];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    
    backImageView.userInteractionEnabled=YES;
    
    [backImageView addGestureRecognizer:tap];
    
    [btn1 addTarget:self action:@selector(xianJi) forControlEvents:UIControlEventTouchUpInside];
    
    [btn2 addTarget:self action:@selector(xianChe) forControlEvents:UIControlEventTouchUpInside];
    
    

}
-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    UIImageView *imageView=(UIImageView *)tap.view;
    
//    [UIView animateWithDuration:0.5 animations:^{
//        [imageView removeFromSuperview];
//    }];
    
    [imageView removeFromSuperview];

}
-(void)xianJi{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;

        [self presentModalViewController:picker animated:YES];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }

}

-(void)xianChe{
    
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = NO;
    [self presentModalViewController:pickerImage animated:YES];


}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 5)];
    
    footView.backgroundColor=RGBA(220, 220, 220, 0.8);
    
    return footView;

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
