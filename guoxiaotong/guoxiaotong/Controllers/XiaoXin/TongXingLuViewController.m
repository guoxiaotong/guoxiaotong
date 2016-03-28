//
//  TongXingLuViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "TongXingLuViewController.h"
#import "ShousuoViewController.h"
#import "XuanzZheQunViewContr.h"
#import "AddViewController.h"

#import "XuanZheQunLiaoTableViewCell.h"
#import "HttpDataModel.h"
#import "TongXunmodel.h"

#import "Singleton.h"


@interface TongXingLuViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //通迅录页面展开和收缩图
    UIImageView *_imagView;
    
    //数组
    int isOpen[10];
    
    UITableView *_xuanZheTabView;
    
    NSMutableArray *_titleDataArr;
    
    NSMutableArray *_userDataArr;

}

@end

@implementation TongXingLuViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden=YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _imagView=[[UIImageView alloc]init];
    
//    isOpen[0] = 1;
    //isOpen[1] 没赋值就是0
    
    self.navigationItem.title=@"通讯录";
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    //去掉返回按钮后的文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor=RGB(220, 220, 220);
    
    _titleDataArr=[[NSMutableArray alloc]init];
    
    _userDataArr=[[NSMutableArray alloc]init];
    
    Singleton *sin=[Singleton shareUser];
    
    NSLog(@"%@",sin.SingleMarry);
    
    //请求数据
    [self relodData];
    
    //创建搜索栏
    [self creatSouSuo];
    
    //创建两个按钮
    [self creatBut];
    
    //创建选择群对话
    [self creatXuanZheTabView];
    
}
-(void)relodData{

    
    NSString *urlStr = @"http://121.42.27.199:8888/csCampus/dynamic/contact.page";

    NSDictionary *bodyDict = @{@"roleId":@2,@"userId":@1046};

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
 
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager  POST:urlStr parameters:bodyDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功");
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
                NSArray *subrray=dict[@"members"];
                for (NSDictionary *sonDict1 in subrray) {
                    TongXunmodel *titlModel=[[TongXunmodel alloc]init];
        
                    [titlModel setValuesForKeysWithDictionary:sonDict1];
        
                    [_titleDataArr addObject:titlModel];
        
                    NSArray *array=sonDict1[@"userBean"];
        
                    NSMutableArray *marry=[[NSMutableArray alloc]init];
        
                    for (NSDictionary *dict2 in array) {
        
                        TongXunmodel *userModel=[[TongXunmodel alloc]init];
                        [userModel setValuesForKeysWithDictionary:dict2];
        
                        [marry addObject:userModel];
                    }
                    [_userDataArr addObject:marry];
                    
                    [_xuanZheTabView reloadData];
                }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    

    


}

//创建两个按钮
-(void)creatBut{

    UIButton *btnleft=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btnleft.frame=CGRectMake(5, 45, screen_Width/2-10, 40);
    
    btnleft.backgroundColor=[UIColor whiteColor];
    
    btnleft.layer.cornerRadius=5;
    
    [btnleft setTitle:@"全部角色" forState:UIControlStateNormal];
    
    [btnleft setTintColor:[UIColor blackColor]];
    
    [self.view addSubview:btnleft];
    
    
    UIButton *btnRit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btnRit.frame=CGRectMake(screen_Width/2+5, 45, screen_Width/2-10, 40);
    
    btnRit.backgroundColor=[UIColor whiteColor];
    
    btnRit.layer.cornerRadius=5;
    
    [btnRit setTitle:@"添加群聊" forState:UIControlStateNormal];
    
     [btnRit setTintColor:[UIColor blackColor]];
    
    [btnRit addTarget:self action:@selector(btnRitClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btnRit];

                   
}

//添加群聊按钮的点击事件
-(void)btnRitClick{

    AddViewController *addVC=[[AddViewController alloc]init];
    
    [self.navigationController pushViewController:addVC animated:YES];


}

//创建搜索栏
-(void)creatSouSuo{
    
    UIButton *shouShuoBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    shouShuoBtn.backgroundColor=[UIColor whiteColor];
    
    shouShuoBtn.layer.cornerRadius=5;
    
    shouShuoBtn.frame=CGRectMake(25, 5,screen_Width-50, 30);
    
    [self.view addSubview:shouShuoBtn];
    
    UIImageView *shouImageView=[[UIImageView alloc]initWithFrame:CGRectMake(screen_Width-75,2, 25, 25)];
    
    shouImageView.image=[UIImage imageNamed:@"iconfont-sousuo.png"];
    
    [shouShuoBtn addSubview:shouImageView];
    
    [shouShuoBtn addTarget:self action:@selector(shouShuoButClic) forControlEvents:UIControlEventTouchUpInside];
}

//创建选择群对话
-(void)creatXuanZheTabView{

    _xuanZheTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 90, screen_Width, screen_Height-90-64) style:UITableViewStyleGrouped];
    
    _xuanZheTabView.dataSource=self;
    
    _xuanZheTabView.delegate=self;
    
    _xuanZheTabView.bounces=NO;
    
    [self.view addSubview:_xuanZheTabView];
    
}


-(void)shouShuoButClic{
    
    ShousuoViewController *shouShuoVc=[[ShousuoViewController alloc]init];
    
    [self.navigationController pushViewController:shouShuoVc animated:YES];
    
    
}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

  return _titleDataArr.count+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else{
     return isOpen[section]?[_userDataArr[section-1] count]:0;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *cellName=@"cellId";

    XuanZheQunLiaoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"XuanZheQunLiaoTableViewCell" owner:self options:nil]firstObject];
    }
        
    //设置layer
    CALayer *layer=[cell.contentView layer];

    [layer setMasksToBounds:YES];
    //        [layer setCornerRadius:5];
  
    //
    [layer setBorderWidth:2];
    //设置边框线的颜色
    [layer setBorderColor:[RGBA(220, 220, 220, 0.5) CGColor]];

    
    cell.backgroundColor=RGBA(245, 245, 245, 1);
    
    TongXunmodel *model=_userDataArr[indexPath.section-1][indexPath.row];
    cell.tongXunModel=model;
    
    return cell;
    

}

//tableView头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
     UIButton *butn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 40)];
    
    butn.backgroundColor=[UIColor whiteColor];
    
    UILabel *qunLabel=[[UILabel alloc]init];
    
    if (section==0) {
        
        qunLabel.frame=CGRectMake(10, 10, 100, 20);
        
        _imagView.frame=CGRectMake(screen_Width-30, 10, 20, 20);
        
        _imagView.image=[UIImage imageNamed:@"arrows_down.png"];
        
        qunLabel.text=@"选择群对话";
        
        
    }else{
    
        qunLabel.frame=CGRectMake(30, 10, 100, 20);
        
        if (isOpen[section]?1:0) {
            
            _imagView=[[UIImageView alloc]init];
            
            _imagView.frame=CGRectMake(10, 10, 20, 20);
            
            _imagView.image=[UIImage imageNamed:@"arrows_up.png"];
            
            [butn addSubview:_imagView];
            
        }else{
            
            _imagView=[[UIImageView alloc]init];
            
            _imagView.frame=CGRectMake(10, 10, 20, 20);
            
            _imagView.image=[UIImage imageNamed:@"arrows_down.png"];
            
            [butn addSubview:_imagView];
            
        }
        
        qunLabel.text=[_titleDataArr[section-1] roleName];
    
    }
    
    
    
    [butn addSubview:_imagView];
    
    [butn addSubview:qunLabel];
    
    butn.tag=section+1000;
    
    [butn addTarget:self action:@selector(butnCliuck:) forControlEvents:UIControlEventTouchUpInside];
    
    return butn;
}

-(void)butnCliuck:(UIButton *)but{
    if (but.tag==1000) {
        
        XuanzZheQunViewContr *xuanZheVC=[[XuanzZheQunViewContr alloc]init];
        
        [self.navigationController pushViewController:xuanZheVC animated:YES];
        
    }
    for (int i = 1; i < 10; i++) {
        if (but.tag - 1000 == i) {
            isOpen[i] = !isOpen[i];
       }
        
        UIImageView *ima=[[UIImageView alloc]init];
        
       ima.frame=CGRectMake(10, 10, 20, 20);
        
        ima.image=[UIImage imageNamed:@"arrows_up.png"];
        
        [but addSubview:ima];
        
    }
    
        [_xuanZheTabView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
      }





//tableView组尾
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;

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
