//
//  TiXingViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/28.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "TiXingViewController.h"
#import "TableViewCell.h"

#import "DongTaiList.h"
#import "commenData.h"

@interface TiXingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_quanBuJueTab;//用来呈现角色
    UITableView  *_TiXingTabView;
    NSMutableArray *_tiXingDataArry;

}
@end

@implementation TiXingViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
self.navigationItem.title=@"消息提醒";
    //去掉返回按钮后的文字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    _tiXingDataArry=[[NSMutableArray alloc]init];
    [self loadData];
    //添加导航栏右边的全部角色按钮
    [self creatRightBtn];
    
    [self creatTabView];

}
-(void)loadData{
    SingleUserInfo *singUser=[SingleUserInfo shareUserInfo];
    
    NSString *str=@"http://121.42.27.199:8888/csCampus/dynamic/dynamic.page";
    
    NSDictionary *Dict=@{@"type":@1 ,@"userId":singUser.userId,@"page":@1,@"userRoleId":@444,@"mine":@""};
    
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
            
                       NSArray *picArry=sonDict[@"picBean"];
            
                        for (NSDictionary *picDict in picArry) {
            
                            DongTaiList *picModel=[[DongTaiList alloc]init];
            
                            [picModel setValuesForKeysWithDictionary:picDict];
                        }
            
            NSDictionary *userDict=sonDict[@"userBean"];
            
            [Dmodel setValuesForKeysWithDictionary:userDict];
            
            [_tiXingDataArry addObject:Dmodel];
            
            [_TiXingTabView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}

//添加导航栏右边的全部角色按钮
-(void)creatRightBtn{
    
    SingleUserInfo *singel=[SingleUserInfo shareUserInfo];
    
    UIButton *ritBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    ritBtn.frame=CGRectMake(screen_Width-25, 0, 80, 50);
    if (singel.roleId==nil) {
        [ritBtn setTitle:@"全部角色" forState:UIControlStateNormal];
        
    }else{
        
        [ritBtn setTitle:singel.roleName forState:UIControlStateNormal];
    }
    
    [ritBtn addTarget:self action:@selector(ritBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ritBarBtn=[[UIBarButtonItem alloc]initWithCustomView:ritBtn];
    
    self.navigationItem.rightBarButtonItem=ritBarBtn;
    
    
}

-(void)ritBtnClik:(UIButton *)btn{
    
    UIView *allImageView=[[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    [self.tabBarController.view addSubview:allImageView];
    
    UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesClick:)];
    
    tapGes.cancelsTouchesInView=NO;
    
    [allImageView addGestureRecognizer:tapGes];
    
    allImageView.userInteractionEnabled=YES;
    
    [UIView animateWithDuration:3 animations:^{
        
        [allImageView addSubview:_quanBuJueTab];
    }];
    
    
}
-(void)tapGesClick:(UITapGestureRecognizer *)tap{
    
    UIImageView *imageView=(UIImageView *)tap.view;
    
    NSLog(@"23333");
    
    [imageView removeFromSuperview];
    imageView=nil;
    
}

-(void)creatTabView{

    _TiXingTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 35, screen_Width, screen_Height-35-108) style:UITableViewStylePlain];
    
     _TiXingTabView.delegate=self;
    
     _TiXingTabView.dataSource=self;
    
     _TiXingTabView.bounces=NO;
    
    [self.view addSubview: _TiXingTabView];

}

#pragma mark tabView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


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
