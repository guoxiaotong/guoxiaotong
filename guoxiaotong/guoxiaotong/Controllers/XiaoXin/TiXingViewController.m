//
//  TiXingViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/28.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "TiXingViewController.h"
#import "TableViewCell.h"
#import "DetailedViewController.h"

#import "DongTaiList.h"
#import "commenData.h"
#import "RoleModel.h"

@interface TiXingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_quanBuJueTab;//用来呈现角色
    UITableView  *_TiXingTabView;
    NSMutableArray *_tiXingDataArry;
    NSMutableArray *_roleDataArry;//用于装角色的数组
     UILabel *_tisiLabel; //提示无更多更能的label

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
    _roleDataArry=[[NSMutableArray alloc]init];
    
    SingleUserInfo *singUser=[SingleUserInfo shareUserInfo];
    _roleDataArry=singUser.roleList;
    [self creatQuBuTabView];

    
    [self loadData];
    //添加导航栏右边的全部角色按钮
    [self creatRightBtn];
    
    [self creatLabel];//用于书写以下人@了你
    
   [self creatTabView];

}
-(void)loadData{
    SingleUserInfo *singUser=[SingleUserInfo shareUserInfo];
   
    NSString *str=@"http://121.42.27.199:8888/csCampus/dynamic/dynamic.page";
    
    NSDictionary *Dict=@{@"type":@1 ,@"userId":singUser.userId,@"page":@1,@"userRoleId":singUser.roleInfo.userRoleId,@"mine":@""};
    
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
-(void)creatLabel{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, screen_Width,35)];
    label.text=@"  以下人动态@了你";
    label.textColor=RGB(154, 154, 154);

    [self.view addSubview:label];

}
//添加导航栏右边的全部角色按钮
-(void)creatRightBtn{
    
    SingleUserInfo *singel=[SingleUserInfo shareUserInfo];
    
    UIButton *ritBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    ritBtn.frame=CGRectMake(screen_Width-25, 0, 80, 50);
    if (singel.roleId==nil) {
        [ritBtn setTitle:@"全部角色" forState:UIControlStateNormal];
        
    }else{
        
        [ritBtn setTitle:singel.roleInfo.roleName forState:UIControlStateNormal];
    }
    
    [ritBtn addTarget:self action:@selector(ritBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ritBarBtn=[[UIBarButtonItem alloc]initWithCustomView:ritBtn];
    
    self.navigationItem.rightBarButtonItem=ritBarBtn;
    
    
}

-(void)creatQuBuTabView{
    
    _quanBuJueTab=[[UITableView alloc]initWithFrame:CGRectMake(screen_Width-100, 55, 80, 30*(_roleDataArry.count+1)) style:UITableViewStylePlain];
    
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

    _TiXingTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 35, screen_Width, screen_Height-35-64) style:UITableViewStylePlain];
    
     _TiXingTabView.delegate=self;
    
     _TiXingTabView.dataSource=self;
    
     _TiXingTabView.bounces=NO;
    
    [self.view addSubview: _TiXingTabView];

}

#pragma mark tabView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==_TiXingTabView) {
        return _tiXingDataArry.count;
        
    }else{
        return _roleDataArry.count+1;
    
    }
    

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID=@"cellNam";
    if (tableView==_quanBuJueTab) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        
        if (indexPath.row==0) {
            cell.textLabel.text=@"全部角色";
        }else{
            
            RoleModel *roleModel=_roleDataArry[indexPath.row-1];
            
            cell.textLabel.text=roleModel.roleName;
            
        }
               cell.selectionStyle=NO;
        
        cell.textLabel.textColor=[UIColor whiteColor];
        
        cell.backgroundColor=[UIColor clearColor];
        
        return cell;

        
    }else{
    
        TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil]firstObject];
        }
        
        DongTaiList *model=_tiXingDataArry[indexPath.row];
        
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
    
    
    
    
}

//点击回复
-(void)huifuBtnClick:(UIButton *)btn{
    
    DongTaiList *model=_tiXingDataArry[btn.tag-2000];
    DetailedViewController *deVc=[[DetailedViewController alloc]init];
    deVc.dtModel=model;
//    deVc.zhan=YES;
//    NSArray *titleArray=@[@"全部",@"通知",@"分享",@"校长信箱"];
//    for (int i=0; i<4; i++) {
//        UIButton *btn=[self.view viewWithTag:1200+i];
//        if (btn.selected) {
//            deVc.nacTitle=titleArray[i];
//        }
//    }
    
    
    [self.navigationController pushViewController:deVc animated:YES];
    
    
}
//点击赞
-(void)dianZhangBtnClick:(UIButton *)btn{
    DongTaiList *model=_tiXingDataArry[btn.tag-2500];
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
    SingleUserInfo *singUser=[SingleUserInfo shareUserInfo];
    
    NSDictionary *Dict=@{@"type":@1 ,@"userId":singUser.userId,@"dynamicId":model.dynamicId,@"praise":@(praise),@"mcontent":@"",@"collection":@0};
    
    AFHTTPRequestOperationManager *requst = [AFHTTPRequestOperationManager manager];
    //设置响应格式为NSData
    requst.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [requst  POST:str parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSLog(@"8888888888888%@",dict[@"msg"]);
        [self loadData];
        
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
    
    UITableView *cell = [self tableView:_TiXingTabView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailedViewController *dvc=[[DetailedViewController alloc]init];
    
    DongTaiList *model=_tiXingDataArry[indexPath.row];
    
    dvc.dtModel=model;
//    NSArray *titleArray=@[@"全部",@"通知",@"分享",@"校长信箱"];
//    for (int i=0; i<4; i++) {
//        UIButton *btn=[self.view viewWithTag:1200+i];
//        if (btn.selected) {
//            dvc.nacTitle=titleArray[i];
//        }
//    }
//    dvc.zhan=YES;
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
