//
//  XiaoXinViewController.m
//  CountryAndSchool
//
//  Created by 刘晓娜 on 16/3/9.
//  Copyright © 2016年 刘晓娜. All rights reserved.
//

#import "XiaoXinViewController.h"
#import "XiaoXinTableViewCell.h"
#import "ShousuoViewController.h"
#import "UrlViewController.h"
#import "TongXingLuViewController.h"
#import"AFNetworking.h"
#import "DongTaiViewController.h"

#import "ADModel.h"
#import "RoleModel.h"
#import "HttpDataModel.h"
#import "Singleton.h"
#import "LoginModel.h"
#import "HttpClient.h"

#import "Singleton.h"


#define screen_Width [UIScreen mainScreen].bounds.size.width

#define screen_Height [UIScreen mainScreen].bounds.size.height

#define nav_Height 64.0f

#define tabBar_Height 49.0f

@interface XiaoXinViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UITableView *_tabView;
    
    //显示新闻内容的Label
    UILabel *_label;
    
    UITableView *_quanBuJueTab;
    
    NSMutableArray *_adDataArry;
    
    NSMutableArray *_roleData;
    
    UIScrollView *_scroll;
    
    UIPageControl *_contrl;
    
    NSMutableArray *_loginDataArry;
    
    HttpClient *_httpClient;
    
    }

@end

@implementation XiaoXinViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

self.tabBarController.tabBar.hidden=NO;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIBarButtonItem *liftBut=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftButClick)];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];

    
    self.navigationItem.leftBarButtonItem=liftBut;
    
    self.view.backgroundColor=RGB(220, 220, 220);
    
   
    
    _adDataArry=[[NSMutableArray alloc]init];

    _roleData=[[NSMutableArray alloc]init];
    
    _loginDataArry=[[NSMutableArray alloc]init];
    
    //解析登录数据
    [self lodeLoginData];
    
    //解析广告栏数据
   [self lodeADData];
    
    //创建搜索栏
    [self creatSouSuo];
    
        //创建导航点
    [self creatPageControl];
    
    //创建tabView
    [self creatTabView];
    
    //添加导航栏右边的全部角色按钮
    [self creatRightBtn];
    
    //定时器来控制sc的图片轮播
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(nextPhoto) userInfo:nil repeats:YES];
}

-(void)lodeLoginData{
    Singleton *sing=[Singleton shareUser];
    
    sing.SingleMarry=[[NSMutableArray alloc]init];

    
    //登录返回的数据
    NSString *str=@"http://121.42.27.199:8888/csCampus/user/login.page";
    NSDictionary *Dict=@{@"userName":@13600002000,@"password":@123456};
    
    AFHTTPRequestOperationManager *requst = [AFHTTPRequestOperationManager manager];
    //设置响应格式为NSData
    requst.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [requst  POST:str parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *sonDict=dict[@"user"];
        
        LoginModel *model=[[LoginModel alloc]init];
        
        [model setValuesForKeysWithDictionary:sonDict];
        
        [sing.SingleMarry addObject:model];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
//    [_httpClient get:str requestParams:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//        NSDictionary *json = responseObject;
//        NSDictionary *sonDict = json[@"user"];
//        
//        LoginModel *model=[[LoginModel alloc]init];
//        
//        [model setValuesForKeysWithDictionary:sonDict];
//        
//        [sing.SingleMarry addObject:model];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"%@", error);
//    }];

    
   
}

- (void)nextPhoto{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _scroll.contentOffset = CGPointMake(_scroll.contentOffset.x + _scroll.frame.size.width, 0);
        
    }completion:^(BOOL finished) {
        if (_scroll.contentOffset.x == (_adDataArry.count - 1) * _scroll.frame.size.width) {
            _scroll.contentOffset = CGPointMake(_scroll.frame.size.width, 0);
        }
    }];
   int  a=_scroll.contentOffset.x / _scroll.frame.size.width ;
    
    _label.text=[_adDataArry[a] title];
}


-(void)lodeADData{
    
    NSString *urlStr = @"http://121.42.27.199:8888/csCampus/basic/rankingChart.page";
    
    NSDictionary *bodyDict = @{@"type":@9,@"city":@25};
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
        [manager  POST:urlStr parameters:bodyDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
     
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *arry=dict[@"adv"];
        for (NSDictionary *subDiction in arry) {
        
        ADModel *model=[[ADModel alloc]init];
        
        [model setValuesForKeysWithDictionary:subDiction];
        
        [_adDataArry addObject:model];
        
}
            //处理好前后各加一张
            [_adDataArry addObject:[_adDataArry firstObject]];
            //0 1 2 3 4
            [_adDataArry insertObject:_adDataArry[_adDataArry.count - 2] atIndex:0];
            //创建滚动视图
            [self creaScrollView];
            
            //创建scrollView下的标题栏
            [self creatLabel];
            
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
    

   // 请求全部角色数据

    NSString *httpStr = @"http://121.42.27.199:8888/csCampus/role/role.page";
    
    NSDictionary *Dict = @{@"userId":@891};
    
    AFHTTPRequestOperationManager *mana = [AFHTTPRequestOperationManager manager];
    
    mana.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mana POST:httpStr parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
                NSArray *array=dict[@"role"];
        
                for (NSDictionary *sonDic in array) {
        
                    RoleModel *model=[[RoleModel alloc]init];
        
                    [model setValuesForKeysWithDictionary:sonDic];
                    
                    [_roleData addObject:model];
        
                    [_quanBuJueTab reloadData];
                }
        [self creatQuBuTabView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];




}
-(void)creatQuBuTabView{
    
    _quanBuJueTab=[[UITableView alloc]initWithFrame:CGRectMake(screen_Width-100, 55, 80, 30*_roleData.count) style:UITableViewStylePlain];
    
    _quanBuJueTab.delegate=self;
    
    _quanBuJueTab.dataSource=self;
    

    _quanBuJueTab.backgroundColor=RGB(41, 36,33);
    
    //设置layer
    CALayer *layer=[_quanBuJueTab layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框圆角的弧度
    [layer setCornerRadius:5];
    //设置边框线的宽
    [layer setBorderWidth:2];
    //设置边框线的颜色
    [layer setBorderColor:[RGBA(41, 36, 33, 0.5) CGColor]];

}

//添加导航栏右边的全部角色按钮
-(void)creatRightBtn{
    
    UIButton *ritBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    ritBtn.frame=CGRectMake(screen_Width-25, 0, 80, 50);
    
    [ritBtn setTitle:@"全部角色" forState:UIControlStateNormal];
    
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


}

//创建scrollView下的标题栏
-(void)creatLabel{
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, screen_Width/2+10, screen_Width, 30)];
    
    _label.backgroundColor=RGBA(41, 36, 33, 0.6);
    
    [self.view addSubview:_label];


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

-(void)shouShuoButClic{

    ShousuoViewController *shouShuoVc=[[ShousuoViewController alloc]init];
    
    [self.navigationController pushViewController:shouShuoVc animated:YES];

   
}

 //创建导航点
-(void)creatPageControl{

    _contrl = [[UIPageControl alloc] initWithFrame:CGRectMake(screen_Width/2-20, screen_Width/2+40, 40, 20)];
    //一共有多少个点
    _contrl.numberOfPages = 3;
    //设置没有被点亮的所有点的颜色
    _contrl.pageIndicatorTintColor = [UIColor lightGrayColor];
    //设置当前被点亮的点的颜色
    _contrl.currentPageIndicatorTintColor = [UIColor redColor];
    
    _contrl.backgroundColor=[UIColor redColor];
    
    //    contrl.currentPage = 5;q
    _contrl.tag = 100;
    _contrl.userInteractionEnabled = NO;
    [self.view addSubview:_contrl];
    
    
    
    
}


//创建tabView
-(void)creatTabView{
    
    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, screen_Width/2+60, screen_Width, self.view.frame.size.height-100) style:UITableViewStylePlain];
    
    _tabView.delegate=self;
    
    _tabView.dataSource=self;
    
//    _tabView.bounces=NO;
    
    [self.view addSubview:_tabView];
    
}


-(void)creaScrollView{
    
    _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, screen_Width, screen_Width/2)
                          ];
    _scroll.backgroundColor=[UIColor blueColor];
    
    _scroll.delegate=self;
    
    [self.view addSubview:_scroll];
    
    for (int i=0; i<_adDataArry.count; i++) {
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scroll.frame.size.width, 0, _scroll.frame.size.width, _scroll.frame.size.height)];
        
        [iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ketangzhiwai.com/%@",[_adDataArry[i] img]]] placeholderImage:[UIImage imageNamed:@"cook_place.jpg"]];
        
        [_scroll addSubview:iv];
        
        
    }
       _scroll.contentSize=CGSizeMake(self.view.frame.size.width*5, 0);
    
    _scroll.pagingEnabled=YES;
    
    _scroll.contentOffset = CGPointMake(screen_Width, 0);
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adTap:)];
    
    _scroll.userInteractionEnabled=YES;
    
    [_scroll addGestureRecognizer:tap];
    
    
}
//点击广告页
-(void)adTap:(UITapGestureRecognizer *)tap{

    UrlViewController *urlVC=[[UrlViewController alloc]init];
    
    int  a=_scroll.contentOffset.x / _scroll.frame.size.width ;
    
    urlVC.httpStr=[_adDataArry[a] url];
    
    urlVC.titelStr=[_adDataArry[a] title];
    
    
    [self.navigationController pushViewController:urlVC animated:YES];

}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==_quanBuJueTab) {
        return [_roleData count];
    }else{
        return 3;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView==_quanBuJueTab) {
        
        static NSString *cellID=@"cellName";
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        
        RoleModel *roleModel=_roleData[indexPath.row];
       
        cell.textLabel.text=roleModel.roleName;
        
        cell.textLabel.font=[UIFont systemFontOfSize:14];
    
        cell.selectionStyle=NO;
        
        cell.textLabel.textColor=[UIColor whiteColor];
        
        cell.backgroundColor=[UIColor clearColor];
        
        return cell;

    }else{

    static NSString *cellID = @"cellName";

    XiaoXinTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"XiaoXinTableViewCell" owner:self options:nil]firstObject];
    }
    

        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_quanBuJueTab) {
        NSLog(@"_quanBuJueCell");
        
        NSLog(@"%ld",_roleData.count);
        
    }else{
        
            
        if (indexPath.row==0) {
            
            DongTaiViewController *donVc=[[DongTaiViewController alloc]init];
            donVc.TongZhi=YES;
            
            [self.navigationController pushViewController:donVc animated:YES];
        }else if (indexPath.row==1){
        
        
        
        
        }else{
        
            UrlViewController *urlVC=[[UrlViewController alloc]init];
            
            urlVC.httpStr=@"http://ketangzhiwai.com/gxt/index.php/Home/SearchNews/index";
            
            urlVC.titelStr=@"国搜新闻";
            
            [self.navigationController pushViewController:urlVC animated:YES];

        
        }
        
        
        
    }
    
}
-(void)leftButClick{

//左边按钮被点击；
    TongXingLuViewController *txVC=[[TongXingLuViewController alloc]init];
    
    [self.navigationController pushViewController:txVC animated:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_quanBuJueTab) {
        
        return 30;
        
    }else{

        return 70;
    }

}

#pragma mark - 处理scrollView的滑动轮播

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _contrl.currentPage = _scroll.contentOffset.x / _scroll.frame.size.width - 1;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_scroll]) {
        if (scrollView.contentOffset.x == (_adDataArry.count - 1) * scrollView.frame.size.width) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
        }
        
        if (scrollView.contentOffset.x == 0) {
            scrollView.contentOffset = CGPointMake(scrollView.frame.size.width * (_adDataArry.count - 2), 0);
        }
    }
    
    
    
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
