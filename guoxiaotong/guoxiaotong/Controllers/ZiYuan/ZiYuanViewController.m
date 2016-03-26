//
//  ZiYuanViewController.m
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ZiYuanViewController.h"
#import "ZhiYuanTableViewCell.h"
#import "ZhiYuanModel.h"
#import "UrlViewController.h"
#import "ADModel.h"


@interface ZiYuanViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
    
    NSMutableArray *_adDataArr;
    
    UITableView *_ziYuanTabView;
    
    UIImageView *_adViewLeft;
    
    UIImageView *_adViewRith;
    
  
}

@end

@implementation ZiYuanViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden=NO;
    
    }


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor blackColor];
    
     _dataArray=[[NSMutableArray alloc]init];
    
    _adDataArr=[[NSMutableArray alloc]init];
    
    [self loadADdata];

    [self loadData];
    // 创建tabView
    [self creatTabView];
}


-(void)loadADdata{
    
    
    
    NSString *urlStr = @"http://121.42.27.199:8888/csCampus/basic/rankingChart.page";
    
    //拼接请求体里的内容 [这里可以拼接成数组，字典，字符串]
    NSDictionary *bodyDict = @{@"type":@6,@"city":@25};
    
    AFHTTPRequestOperationManager *requst = [AFHTTPRequestOperationManager manager];
    //设置响应格式为NSData
    requst.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [requst  POST:urlStr parameters:bodyDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功");
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSArray *array=dict[@"adv"];
        
        for (NSDictionary *sonDic in array) {
            
            ADModel *modele=[[ADModel alloc]init];
            
            [modele setValuesForKeysWithDictionary:sonDic];
            
            [_adDataArr addObject:modele];
            
            }
        
        //左右广告页加载数据
        _adViewLeft=[[UIImageView alloc]initWithFrame:CGRectMake(4, 4, screen_Width/2-6, screen_Width/3-8)];
        
        _adViewRith=[[UIImageView alloc]initWithFrame:CGRectMake(screen_Width/2+2,4, screen_Width/2-6, screen_Width/3-8)];
        
            ADModel *modelL=_adDataArr[0];
       
          ADModel *modelR=_adDataArr[1];
        
           NSString *strL=[NSString stringWithFormat:@"http://www.ketangzhiwai.com/%@",modelL.img];
        
            NSString *strR=[NSString stringWithFormat:@"http://www.ketangzhiwai.com/%@",modelR.img];
        
            [_adViewLeft sd_setImageWithURL:[NSURL URLWithString:strL]];
        
            [_adViewRith sd_setImageWithURL:[NSURL URLWithString:strR]];
        
    
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败nmhgmhmh");
    }];
    

}
-(void)tapClik:(UITapGestureRecognizer *)tap{
    
    UrlViewController *urlVC=[[UrlViewController alloc]init];
    
    urlVC.titelStr=@"详情";
    
    if (tap.view==_adViewLeft) {
        ADModel *model=_adDataArr[0];
        
        urlVC.httpStr=model.url;
        
    }else{
        ADModel *model=_adDataArr[1];
        
        urlVC.httpStr=model.url;    }
    
    [self.navigationController pushViewController:urlVC animated:YES];


}


//请求数据
-(void)loadData{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSString *urlstr=@"http://ketangzhiwai.com/gxt/index.php/Home/RankingList/mylist/source/zhoubian/role_id/1/user_id/891/school_id/13773/school_type/73";
    
    [manager GET:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *subrray=responseObject[@"msg"];
        
        for (NSDictionary *subDic in subrray) {
            
            ZhiYuanModel *model=[[ZhiYuanModel alloc]init];
            
            [model setValuesForKeysWithDictionary:subDic];
            
            [_dataArray addObject:model];
            
            [_ziYuanTabView reloadData];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    
    
}


// 创建tabView
-(void)creatTabView{
    
    _ziYuanTabView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    _ziYuanTabView.dataSource=self;
    
    _ziYuanTabView.delegate=self;
    
    _ziYuanTabView.bounces=NO;
    
    [_ziYuanTabView registerNib:[UINib nibWithNibName:@"ZhiYuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellNa"];
    
    [self.view addSubview:_ziYuanTabView];
    
    
    
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId=@"cellNa";
    
    ZhiYuanTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell==nil) {
//        cell=[[[NSBundle mainBundle]loadNibNamed:@"ZhiYuanTableViewCell" owner:self options:nil]firstObject];
//    }
    ZhiYuanModel *model=_dataArray[indexPath.row];
    
    //设置layer
    CALayer *layer=[cell.contentView layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框圆角的弧度
    //        [layer setCornerRadius:5];
    //设置边框线的宽
    //
    [layer setBorderWidth:1];
    //设置边框线的颜色
    [layer setBorderColor:[RGBA(220, 220, 220, 0.5) CGColor]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    cell.ziYuanModel=model;
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UrlViewController *urlVC=[[UrlViewController alloc]init];
    
    ZhiYuanModel *model=_dataArray[indexPath.row];
    
    urlVC.httpStr=model.url;
    
    urlVC.titelStr=model.title;
    
    [self.navigationController pushViewController:urlVC animated:YES];

}

//设置分区头部视图的高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return screen_Width*11/24+80;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Width*13/24-80)];
    
    bView.backgroundColor=RGB(220, 220, 220);
    
    //按钮页面
    UIImageView *anLiuImageView=[self creatButImageView];
    
     [bView addSubview:anLiuImageView];
    
     //广告画面
    UIView *adImageView=[self creatImageView];
    
    [bView addSubview:adImageView];
   // 标题
    UILabel *adlabel=[self creatLabel];
    
    [bView addSubview:adlabel];
    
    return bView;
}

//按钮页面
-(UIImageView *)creatButImageView{
    UIImageView *anLiuImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Width/8+40)];
    
    anLiuImageView.backgroundColor=[UIColor whiteColor];
    
   
    
    NSArray *imageArry=@[@"res_article",@"res_audio",@"res_video",@"res_app"];
    
    NSArray *titleArry=@[@"文章",@"音频",@"视频",@"APP"];
    
    for (int i=0; i<4; i++) {
        UIButton *anLiuBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        anLiuBtn.frame=CGRectMake(screen_Width/16+(screen_Width/4*i), 10, screen_Width/8, screen_Width/8+20);
        
        anLiuBtn.tag=500+i;
        
        [anLiuBtn addTarget:self action:@selector(anButClik) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *butImagView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen_Width/8, screen_Width/8)];
        
        butImagView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArry[i]]];
        
        UILabel *butLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, screen_Width/8, screen_Width/8, 20)];
        
        butLabel.text=[NSString stringWithFormat:@"%@",titleArry[i]];
        
        butLabel.font=[UIFont systemFontOfSize:14];
        
        butLabel.textAlignment=NSTextAlignmentCenter;
        
        [anLiuBtn addSubview:butImagView];
        
        [anLiuBtn addSubview:butLabel];
        
        [anLiuImageView addSubview:anLiuBtn];
    }
    
        return anLiuImageView;

}

//广告画面
-(UIView *)creatImageView{
     UIView *adView=[[UIView alloc]initWithFrame:CGRectMake(0, screen_Width/8+45, screen_Width, screen_Width/3)];
    
    adView.backgroundColor=[UIColor whiteColor];
    
    
    [adView addSubview:_adViewRith];
    
    [adView addSubview:_adViewLeft];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClik:)];
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClik:)];
    
    _adViewLeft.userInteractionEnabled=YES;
    
    _adViewRith.userInteractionEnabled=YES;
    
    [_adViewRith addGestureRecognizer:tap1];
    
    [_adViewLeft addGestureRecognizer:tap];
    
       return adView;

}

 // 标题
-(UILabel *)creatLabel{
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, screen_Width*11/24+50, screen_Width, 30)];
    
    lab.backgroundColor=[UIColor whiteColor];
    lab.text=@"  猜你喜欢";
    
    [lab.layer setMasksToBounds:YES];
    
    [lab.layer setBorderWidth:1];
    
    lab.font=[UIFont systemFontOfSize:14];
    
    [lab.layer setBorderColor:[RGB(220, 220, 220) CGColor]];
    
    return lab;

}

-(void)anButClik{


//按钮被电击；

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
