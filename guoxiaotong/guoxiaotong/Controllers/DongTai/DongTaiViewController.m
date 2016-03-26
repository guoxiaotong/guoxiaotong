//
//  DongTaiViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "DongTaiViewController.h"
#import "DetailedViewController.h"
#import "HuiFuViewController.h"
#import "TableViewCell.h"


#import "DongTaiList.h"
#import "commenData.h"

@interface DongTaiViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView  *_dongTaiTabView;
    
    NSMutableArray *_dongTaiArry;
    //点击+图标弹出的背景视图
    UIView *_bview;
    
    UILabel *_tisiLabel; //提示无更多更能的label
    
}

@end

@implementation DongTaiViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=NO;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.mine=@"";
    self.userId=1046;
    
    //动态分类
    [self creatFenLeiButn];
    

    
    //创建导航栏右边的两个按钮
    [self creatRitBtn];
    
       //创建tabView
    [self creatTabView];
    
}
-(void)lodaData:(NSString *)typstr{
    
    self.type=(NSMutableString *)typstr;
     _dongTaiArry=[[NSMutableArray alloc]init];
    //登录返回的数据
    NSString *str=@"http://121.42.27.199:8888/csCampus/dynamic/dynamic.page";
    
    
    NSDictionary *Dict=@{@"type":self.type ,@"userId":@(self.userId),@"page":@1,@"userRoleId":@123,@"mine":self.mine};
    
    AFHTTPRequestOperationManager *requst = [AFHTTPRequestOperationManager manager];
    //设置响应格式为NSData
    requst.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [requst  POST:str parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSArray *array=dict[@"comment"];
        
        for (NSDictionary *sonDict in array) {
            
            DongTaiList *Dmodel=[[DongTaiList alloc]init];
            
            [Dmodel setValuesForKeysWithDictionary:sonDict];
            //评论
            NSArray *commenArry=sonDict[@"commentBean"];
            
            for (NSDictionary *comenDict in commenArry) {
                
                commenData *cmModel=[[commenData alloc]init];
                
                [cmModel setValuesForKeysWithDictionary:comenDict];
                
            }
            
            
//           NSArray *picArry=sonDict[@"picBean"];
//            
//            for (NSDictionary *picDict in picArry) {
//                
//                DongTaiList *picModel=[[DongTaiList alloc]init];
//                
//                [picModel setValuesForKeysWithDictionary:picDict];
//            }

         NSDictionary *userDict=sonDict[@"userBean"];
            
            [Dmodel setValuesForKeysWithDictionary:userDict];

            [_dongTaiArry addObject:Dmodel];
            
           [_dongTaiTabView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}
-(void)creatRitBtn{
    
    UIBarButtonItem *ritBtn1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(ritBtn1Click)];
    
    UIBarButtonItem *ritBtn2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(ritBtn2Click)];
    
    NSArray *ritBtns=[NSArray arrayWithObjects:ritBtn2,ritBtn1, nil];

    self.navigationItem.rightBarButtonItems=ritBtns;
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];

}

-(void)ritBtn1Click{

    NSLog(@"ritBtn1Click");

}
-(void)ritBtn2Click{

    _bview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
    
    NSArray *arry=@[@"通知",@"分享",@"校长信箱"];
    NSArray *ImageArry=@[@"share",@"jishib",@"act"];
        for (int i=0; i<3; i++) {
            
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(screen_Width/7+screen_Width*2/7*i, screen_Height/2-screen_Width/7, screen_Width/7, screen_Width/7);
            btn.tag=1300+i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
            [btn setImage:[UIImage imageNamed:ImageArry[i]] forState:UIControlStateNormal];
    
            [_bview addSubview:btn];
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(screen_Width/7+screen_Width*2/7*i, screen_Height/2, screen_Width/7, screen_Width/7)];
            
            label.textAlignment=NSTextAlignmentCenter;
            
            label.text=arry[i];
            
            label.font=[UIFont systemFontOfSize:12];
            
            label.tintColor=RGBA(220, 220, 220, 0.9);
            
            [_bview addSubview:label];
            
        }

    
    [self.tabBarController.view addSubview:_bview];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    
    [_bview addGestureRecognizer:tap];
    
    _bview.backgroundColor=[UIColor whiteColor];
    

}

//点击分享，通知,更多 按钮
-(void)btnClick:(UIButton *)btn{
    
    HuiFuViewController *hvc=[[HuiFuViewController alloc]init];
    
    [self.navigationController pushViewController:hvc animated:YES];
    
    if (btn.tag-1300==0) {
        hvc.naTitle=@"写通知";
        hvc.type=0;
        
    }else if (btn.tag-1300==1){
    
    hvc.naTitle=@"发分享";
        hvc.type=1;
    }

    [_bview removeFromSuperview];

}
-(void)tapClick:(UITapGestureRecognizer *)tt{
    
    [tt.view removeFromSuperview];

}
-(void)creatFenLeiButn{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *findScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, screen_Width, 30)];
    
    findScroll.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:findScroll];
    
    findScroll.userInteractionEnabled=YES;
    
    findScroll.backgroundColor=[UIColor whiteColor];
    NSArray *array=@[@"全部",@"通知",@"分享",@"校长信箱"];
    for (int i=0; i<4; i++) {
        
       UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(10+i*75, 2, 70, 25);
        [but setTitle:array[i] forState:UIControlStateNormal];
        
        but.titleLabel.font=[UIFont systemFontOfSize:14];
        
        [but setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        if (self.TongZhi) {
            if (i==1) {
                but.selected=YES;
                [self lodaData:@"0"];

            }
            
        }else{
            if (i==0) {
                but.selected=YES;
                [self lodaData:@"0,1"];

            }

        
        }
        
        
        [but setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
                but.tag=1200+i;
        
        but.backgroundColor=[UIColor whiteColor];
        
        [findScroll addSubview:but];
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    findScroll.contentSize=CGSizeMake(screen_Width+20, 0);
   
    
    [self.view addSubview:findScroll];
    
}

-(void)butClick:(UIButton *)btn{
    for (int i=0; i<4; i++) {
        UIButton *butt=[self.view viewWithTag:i+1200];
        
        if (btn==butt) {
            butt.selected=YES;
        }else {
            butt.selected=NO;
        
        }
        
    }
    switch (btn.tag-1200) {
        case 0:
            [self lodaData:@"0,1"];
            break;
        case 1:
            [self lodaData:@"0"];
            break;
        case 2:
            [self lodaData:@"1"];
            break;
        case 3:
            [self lodaData:@"2"];
            break;

            
        default:
            break;
    }

}

-(void)creatTabView{

    _dongTaiTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, screen_Width, screen_Height-144) style:UITableViewStylePlain];
    
    _dongTaiTabView.delegate=self;
    
    _dongTaiTabView.dataSource=self;
    
    _dongTaiTabView.bounces=NO;
    
    [self.view addSubview:_dongTaiTabView];

}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _dongTaiArry.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

static NSString *cellID=@"cellName";
    
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil]firstObject];
    }
    
    DongTaiList *model=_dongTaiArry[indexPath.row];
    
    cell.model=model;
    NSLog(@"%@",model.praise);
    NSInteger picLien;
        if (cell.model.picBean.count==0) {
        picLien=0;
    }else{
        picLien=(cell.model.picBean.count+2)/3;
    }
    
    [cell setIntroductionText:cell.model.content andphonnum:picLien];
    
    for (int i=0; i<cell.model.picBean.count; i++) {
        
        UIImageView *picImageVew=[[UIImageView alloc]initWithFrame:CGRectMake(i%3*95, i/3*95, 90, 90)];
        NSString *str=cell.model.picBean[i][@"imageUrl"];
        
        [picImageVew sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://ketangzhiwai.com/%@",str]]];
        
        [cell.zhanSiView addSubview:picImageVew];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
   
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //设置layer
    CALayer *layer=[cell.contentView layer];

    [layer setMasksToBounds:YES];

    //        [layer setCornerRadius:5];
  
  
    [layer setBorderWidth:3];

    [layer setBorderColor:[RGBA(220, 220, 220, 0.5) CGColor]];
    
    CALayer *gLayer=[cell.gongNenView layer];
    [gLayer setMasksToBounds:YES];
    [gLayer setBorderWidth:2];
    [gLayer setBorderColor:[RGBA(220, 220, 220, 1) CGColor]];

    cell.xiaoXiBtn.tag=2000+indexPath.row;
    cell.dianZhangBtn.tag=2500+indexPath.row;
    [cell.xiaoXiBtn addTarget:self action:@selector(huifuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.dianZhangBtn addTarget:self action:@selector(dianZhangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.genDuoBtn addTarget:self action:@selector(genDuoBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    
    
    return cell;
    
    
}
//点击回复
-(void)huifuBtnClick:(UIButton *)btn{
    
     DongTaiList *model=_dongTaiArry[btn.tag-2000];
    DetailedViewController *deVc=[[DetailedViewController alloc]init];
    deVc.dtModel=model;
    deVc.zhan=YES;
    NSArray *titleArray=@[@"全部",@"通知",@"分享",@"校长信箱"];
    for (int i=0; i<4; i++) {
        UIButton *btn=[self.view viewWithTag:1200+i];
        if (btn.selected) {
            deVc.nacTitle=titleArray[i];
        }
    }


    [self.navigationController pushViewController:deVc animated:YES];
    

}
//点击赞
-(void)dianZhangBtnClick:(UIButton *)btn{
    DongTaiList *model=_dongTaiArry[btn.tag-2500];
     NSArray *arry=[model.praise componentsSeparatedByString:@","];
    
    for (NSString *nameStr in arry) {
        if ([nameStr isEqualToString:model.userName]) {
            //以前点过赞了
            btn.selected=YES;
            
        }
    }

    btn.selected=!btn.selected;
    NSInteger praise;
    if (btn.selected==YES) {
        praise=1;
    }else{
    
        praise=0;
    }
    
    NSString *str=@"http://121.42.27.199:8888/csCampus/dynamic/addComment.page";
    
    
    NSDictionary *Dict=@{@"type":self.type ,@"userId":@(self.userId),@"dynamicId":model.dynamicId,@"praise":@(praise),@"mcontent":self.mine,@"collection":@0};
    
    AFHTTPRequestOperationManager *requst = [AFHTTPRequestOperationManager manager];
    //设置响应格式为NSData
    requst.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [requst  POST:str parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
    
        NSLog(@"8888888888888%@",dict[@"msg"]);
        
        [self lodaData:self.type];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

}
//点击更多
-(void)genDuoBtnClick:(UIButton *)btn{

    [_tisiLabel removeFromSuperview];
    _tisiLabel=nil;
    _tisiLabel=[[UILabel alloc]initWithFrame:CGRectMake((screen_Width-200)/2, screen_Height-120, 200, 50)];
    _tisiLabel.backgroundColor=RGBA(41, 36, 33, 1);
    _tisiLabel.text=@"暂时没有更多功能，敬请期待!";
    _tisiLabel.textAlignment=NSTextAlignmentCenter;
    _tisiLabel.font=[UIFont systemFontOfSize:14];
    CALayer *layer=[_tisiLabel layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5];
    [self.view addSubview:_tisiLabel];
    [UIView animateWithDuration:3 animations:^{
        _tisiLabel.alpha=0;
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableView *cell = [self tableView:_dongTaiTabView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailedViewController *dvc=[[DetailedViewController alloc]init];
    
    DongTaiList *model=_dongTaiArry[indexPath.row];
    
    dvc.dtModel=model;
    NSArray *titleArray=@[@"全部",@"通知",@"分享",@"校长信箱"];
    for (int i=0; i<4; i++) {
        UIButton *btn=[self.view viewWithTag:1200+i];
        if (btn.selected) {
            dvc.nacTitle=titleArray[i];
        }
    }
    dvc.zhan=YES;
    [self.navigationController pushViewController:dvc animated:YES];


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
