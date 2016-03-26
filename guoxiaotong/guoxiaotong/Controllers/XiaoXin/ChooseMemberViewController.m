//
//  ChooseMemberViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ChooseMemberViewController.h"
#import "XuanZheQunLiaoTableViewCell.h"

@interface ChooseMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tabView;
    
    UIImageView *_imageView;
    
    //数组
    int isOpen[10];

}

@end

@implementation ChooseMemberViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title=@"选择群聊成员";
    
    self.view.backgroundColor=RGBA(220, 220, 220, 1);
    
    //添加导航栏右边的确定按钮
    [self creatRightBtn];
    //创建两个按钮
    [self creatBut];
    
    //创建tabView
    [self creatTabView];

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


//创建两个按钮
-(void)creatBut{
    
    UIButton *btnleft=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btnleft.frame=CGRectMake(5, 70, screen_Width/2-10, 40);
    
    btnleft.backgroundColor=[UIColor whiteColor];
    
    btnleft.layer.cornerRadius=5;
    
    [btnleft setTitle:@"全部角色" forState:UIControlStateNormal];
    
    [btnleft setTintColor:[UIColor blackColor]];
    
    [self.view addSubview:btnleft];
    
    UIButton *btnRit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btnRit.frame=CGRectMake(screen_Width/2+5, 70, screen_Width/2-10, 40);
    
    btnRit.backgroundColor=[UIColor whiteColor];
    
    btnRit.layer.cornerRadius=5;
    
    [btnRit setTitle:@"当前角色：" forState:UIControlStateNormal];
    
    [btnRit setTintColor:[UIColor blackColor]];
    
    [self.view addSubview:btnRit];
    
}

//创建tabView
-(void)creatTabView{
    
    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 115, screen_Width, screen_Height-115) style:UITableViewStyleGrouped];
    
    _tabView.backgroundColor=[UIColor clearColor];
    
//    _tabView.separatorStyle=YES;
//    
//    [_tabView setSeparatorColor:[UIColor redColor]];

    
    _tabView.delegate=self;
    
    _tabView.dataSource=self;
    
    _tabView.bounces=NO;
    
    [self.view addSubview:_tabView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return isOpen[section]?2:0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *cellID=@"cellName";
    
    XuanZheQunLiaoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"XuanZheQunLiaoTableViewCell" owner:self options:nil]firstObject];
    }
  
    CALayer *layer=[cell.contentView layer];
  
    [layer setMasksToBounds:YES];

    //        [layer setCornerRadius:5];
  
    [layer setBorderWidth:2];

    [layer setBorderColor:[RGBA(220, 220, 220, 0.5) CGColor]];
    
    cell.backgroundColor=RGBA(245, 245, 245, 1);
    
    [cell.chooesBtn setImage:[UIImage imageNamed:@"FriendsSendsPicturesSelectBigYIcon"] forState:UIControlStateSelected];
    
    [cell.chooesBtn addTarget:self action:@selector(cellButnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;

}
//cell后面用于勾选用的btn的点击事件
-(void)cellButnClick:(UIButton *)butn{

    butn.selected=!butn.selected;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    NSArray *array=@[@"校长",@"班主任",@"教师",@"监护人",@"家长"];

    UIButton *butn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 30)];
    
    butn.backgroundColor=[UIColor whiteColor];
    
    UILabel *qunLabel=[[UILabel alloc]init];
    
           qunLabel.frame=CGRectMake(30, 5, 100, 20); 
        
        qunLabel.text=array[section];
    
    if (isOpen[section]?1:0) {
        
        _imageView=[[UIImageView alloc]init];
        
        _imageView.frame=CGRectMake(5, 5, 20, 20);
        
        _imageView.image=[UIImage imageNamed:@"arrows_up.png"];
        
        [butn addSubview:_imageView];
        
    }else{
        
        _imageView=[[UIImageView alloc]init];
        
        _imageView.frame=CGRectMake(5, 5, 20, 20);
        
        _imageView.image=[UIImage imageNamed:@"arrows_down.png"];
        
        [butn addSubview:_imageView];
        
    }
    
    [butn addSubview:qunLabel];
    
    //用于勾选的按钮
    UIButton *btnChoose=[UIButton buttonWithType:UIButtonTypeCustom];
    
    btnChoose.frame=CGRectMake(screen_Width-50, 5, 20, 20);
    
    [btnChoose setImage:[UIImage imageNamed:@"FriendsSendsPicturesSelectBigNIcon"] forState:UIControlStateNormal];
 
    [btnChoose setImage:[UIImage imageNamed:@"FriendsSendsPicturesSelectBigYIcon"] forState:UIControlStateSelected];
    
    [butn addSubview:btnChoose];
    
    [btnChoose addTarget:self action:@selector(btnChooseClick:) forControlEvents:UIControlEventTouchUpInside];
    
    butn.tag=section+1100;
    
    [butn addTarget:self action:@selector(butnCliuck:) forControlEvents:UIControlEventTouchUpInside];
    
    return butn;

}
-(void)btnChooseClick:(UIButton *)btn{
//点击勾选按钮
    NSLog(@"choose");
    btn.selected=!btn.selected;
   

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 3;

}

-(void)butnCliuck:(UIButton *)btn{
    
    for (int i = 0; i < 10; i++) {
        if (btn.tag - 1100 == i) {
            isOpen[i] = !isOpen[i];
        }
        
    }
    
    [_tabView reloadData];

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
