//
//  FangWeiViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "FangWeiViewController.h"
#import "XuanZheQunLiaoTableViewCell.h"

@interface FangWeiViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tabView;
    
    //数组
    int isOpen[10];
    //展开收缩图标
    UIImageView  *_imageView;
}

@end

@implementation FangWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"选择发送范围";
    
    //创建“取消”按钮
    [self creatLeftBarBtn];
    //创建用于展示角色按钮的scre
    [self creatJuSheview];
    
    //提供选择的列表
    [self creatTabView];

    [self craetBatBtn];
    

}
  //提供选择的列表
-(void)creatTabView{
    
    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 35, screen_Width, screen_Height-100) style:UITableViewStylePlain];
   
    _tabView.dataSource=self;
    _tabView.delegate=self;
    [self.view addSubview:_tabView];

}
-(void)craetBatBtn{
    UIView *barBttonview=[[UIView alloc]initWithFrame:CGRectMake(0, screen_Height-44-64, screen_Width, 44)];
    barBttonview.backgroundColor=RGBA(220, 220, 220, 0.9);
    [self.view addSubview:barBttonview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10,5 , screen_Width-100, 30)];
    
    label.text=[NSString stringWithFormat:@"已选择：%d个人",5];
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=RGBA(64, 105, 225, 1);
    [barBttonview addSubview:label];
                                  
    UIButton *okBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    okBtn.frame=CGRectMake(screen_Width-80, 5, 60, 30);
    okBtn.backgroundColor=RGBA(65, 105, 225, 1);
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn.layer setCornerRadius:5];
    [barBttonview addSubview:okBtn];
    [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];

}
//点击取得按钮
-(void)okBtnClick{




}

//创建用于展示角色按钮的scre
-(void)creatJuSheview{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *juSheScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 30)];
    
    juSheScroll.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:juSheScroll];
    
    juSheScroll.userInteractionEnabled=YES;
    
    juSheScroll.backgroundColor=[UIColor whiteColor];
    
//    UILabel *tiShilabel=[UILabel alloc]initWithFrame:<#(CGRect)#>
    
    NSArray *array=@[@"校长",@"教师",@"家长",@"..."];
    for (int i=0; i<4; i++) {
        
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        
        but.frame=CGRectMake(10+i*75, 2, 75, 25);
        
        [but setTitle:array[i] forState:UIControlStateNormal];
        
        but.titleLabel.font=[UIFont systemFontOfSize:14];
        
        [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [but setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        if (i==0) {
            but.selected=YES;
        }
        
        but.tag=1450+i;
        
        but.backgroundColor=[UIColor whiteColor];
        
        [juSheScroll addSubview:but];
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView *selectView=[[UIView alloc]initWithFrame:CGRectMake(10+i*75, 27, 75, 3)];
        
        selectView.tag=1500+i;
        if (i==0) {
            but.selected=YES;
            selectView.backgroundColor=RGBA(65, 105, 225, 1 );
        }
        

        [juSheScroll addSubview:selectView];
        

    }
    
    juSheScroll.contentSize=CGSizeMake(screen_Width+20, 0);
    
    
    [self.view addSubview:juSheScroll];
    
    CALayer *gLayer=[juSheScroll layer];
    [gLayer setMasksToBounds:YES];
    [gLayer setBorderWidth:1];
    [gLayer setBorderColor:[RGBA(220, 220, 220, 1) CGColor]];
    
    

}
//选择以什么身份发送
-(void)butClick:(UIButton *)btn{

    UIView *view=[self.view viewWithTag:btn.tag+50];
    view.backgroundColor=[UIColor redColor];
    
    for (int i=0; i<4; i++) {
        UIButton *butt=[self.view viewWithTag:i+1450];
        UIView *view=[self.view viewWithTag:1500+i];

        if (btn==butt) {
            butt.selected=YES;
            
            view.backgroundColor=RGBA(65, 105, 225, 1);
        }else {
            butt.selected=NO;
            
            view.backgroundColor=[UIColor clearColor];
            
        }
        
    }
//    switch (btn.tag-1450) {
//        case 0:
//            
//            break;
//        case 1:
//            
//            
//            break;
//        case 2:
//            
//            break;
//            
//        default:
//            break;
//    }

    


}
//创建“取消”按钮
-(void)creatLeftBarBtn{
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    leftBtn.frame=CGRectMake(0, 0, 50, 50);
    
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(leftBtnClik) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarBtn=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem=leftBarBtn;

}
//点击取消按钮
-(void)leftBtnClik{

    [self.navigationController popViewControllerAnimated:YES];


}

#pragma mark UITableViewDataSource
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
    

    return cell;
    
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
    UIButton *btnChoose=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btnChoose.frame=CGRectMake(screen_Width-50, 5, 20, 20);
    
    [btnChoose setImage:[UIImage imageNamed:@"arrows_up.png"] forState:UIControlStateNormal];
    
    [btnChoose setImage:[UIImage imageNamed:@"组-2_4"] forState:UIControlStateSelected];
    
    [butn addSubview:btnChoose];
    
    
    butn.tag=section+1100;
    
    [butn addTarget:self action:@selector(butnCliuck:) forControlEvents:UIControlEventTouchUpInside];
    
    return butn;
    
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
