//
//  FangWeiViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "FangWeiViewController.h"
#import "XuanZheQunLiaoTableViewCell.h"
#import "ChooseMenSingle.h"

#import "RoleModel.h"
#import "TongXunmodel.h"

@interface FangWeiViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_tabView;
    
    //数组
    int isOpen[20];
    
    //是否勾选
    int isChpoose[20];//tabView分区的头是否被勾选

    //展开收缩图标
    UIImageView  *_imageView;
    
    NSMutableArray *_roleArry;
    
    NSMutableArray *_chooseMem;//被选中的人
    
    NSMutableArray *_userDataArr;
    NSMutableArray *_titleDataArr;
    
    
    UIView *_barBttonview;//显示选择了多少人和确定按钮
}

@end

@implementation FangWeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"选择发送范围";
    
    _chooseMem=[[NSMutableArray alloc]init];
    _roleArry=[[NSMutableArray alloc]init];
    
    _userDataArr=[[NSMutableArray alloc]init];
    _titleDataArr=[[NSMutableArray alloc]init];
     SingleUserInfo *singUse=[SingleUserInfo shareUserInfo];
    _roleArry=singUse.roleList;
    [self lodeData];
    //创建“取消”按钮
    [self creatLeftBarBtn];
    //创建用于展示角色按钮的scre
    [self creatJuSheview];
   
    //提供选择的列表
    [self creatTabView];

    [self craetBatBtn];
    

}

-(void)lodeData{
    //    [LoadingView showCenterActivity:self.view];
    
   
    
    SingleUserInfo *singleUsel=[SingleUserInfo shareUserInfo];
    
    
    NSString *urlStr = @"http://121.42.27.199:8888/csCampus/dynamic/contact.page";
    
    NSDictionary *bodyDict = @{@"roleId":@(singleUsel.roleId),@"userId":singleUsel.userId};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager  POST:urlStr parameters:bodyDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功");
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        [_userDataArr removeAllObjects];
        [_titleDataArr removeAllObjects];
        
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
            
            [_tabView reloadData];
        }
        
        //        [LoadingView hideCenterActivity:self.view];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    
}
  //提供选择的列表
-(void)creatTabView{
    
    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 45, screen_Width, screen_Height-85) style:UITableViewStylePlain];
   
    _tabView.dataSource=self;
    _tabView.delegate=self;
    [self.view addSubview:_tabView];

}
-(void)craetBatBtn{
    _barBttonview=[[UIView alloc]initWithFrame:CGRectMake(0, screen_Height-44-64, screen_Width, 44)];
    _barBttonview.backgroundColor=RGBA(220, 220, 220, 0.9);
    [self.view addSubview:_barBttonview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10,5 , screen_Width-100, 30)];
    label.text=[NSString stringWithFormat:@"已选择：%ld个人",[_chooseMem count]];
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=RGBA(64, 105, 225, 1);
    [_barBttonview addSubview:label];
                                  
    UIButton *okBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    okBtn.frame=CGRectMake(screen_Width-80, 5, 60, 30);
    okBtn.backgroundColor=RGBA(65, 105, 225, 1);
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn.layer setCornerRadius:5];
    [_barBttonview addSubview:okBtn];
    [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];

}
//点击确定按钮
-(void)okBtnClick{

    ChooseMenSingle *choose=[ChooseMenSingle shareChooseMen];
    
    choose.huiFuRangArry=_chooseMem;
    
    [self.navigationController popViewControllerAnimated:YES];


}

//创建用于展示角色按钮的scre
-(void)creatJuSheview{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *juSheScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 40)];
    
    juSheScroll.backgroundColor=[UIColor redColor];
    
    [self.view addSubview:juSheScroll];
    
    juSheScroll.userInteractionEnabled=YES;
    
    juSheScroll.backgroundColor=[UIColor whiteColor];
    
//    UILabel *tiShilabel=[UILabel alloc]initWithFrame:<#(CGRect)#>
    //加入全部角色
    NSMutableArray *marry=[[NSMutableArray alloc]init];
    [marry addObject:@"全部角色"];
    for (int i=0; i<_roleArry.count; i++) {
        RoleModel *model=_roleArry[i];
        [marry addObject:model.roleName];
    }
    
    for (int i=0; i<marry.count; i++) {
        
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        
        but.frame=CGRectMake(10+i*75, 10, 75, 25);
        
        [but setTitle:marry[i] forState:UIControlStateNormal];
        
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
        
        
        UIView *selectView=[[UIView alloc]initWithFrame:CGRectMake(10+i*75, 37, 75, 3)];
        
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

//    UIView *view=[self.view viewWithTag:btn.tag+50];
//    view.backgroundColor=[UIColor redColor];
    
    for (int i=0; i<_roleArry.count+1; i++) {
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
    
    SingleUserInfo *singUse=[SingleUserInfo shareUserInfo];

    if (btn.tag-1450==0) {
        //全部角色被选择
//        NSMutableArray *roleIdArry=[[NSMutableArray alloc]init];
//        for (int i=0; i<_roleArry.count; i++) {
//         
//            [roleIdArry addObject:[NSString stringWithFormat:@"%ld",[[_roleArry[i] roleInfo] roleId]]];
//        }
//        NSString *str=[roleIdArry componentsJoinedByString:@","];
//        
//        singUse.roleId=[str intValue];
        singUse.roleId=0;
        
    }else{
    
        RoleModel *model=_roleArry[btn.tag-1450-1];
        
        singUse.roleId=model.roleId;
    
    }
    
    [self lodeData];


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
    
    return _titleDataArr.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return isOpen[section]?[_userDataArr[section] count]:0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID=@"cellName";
    
    XuanZheQunLiaoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"XuanZheQunLiaoTableViewCell" owner:self options:nil]firstObject];
    }
    
    
    TongXunmodel *model=_userDataArr[indexPath.section][indexPath.row];
    cell.tongXunModel=model;
    
    CALayer *layer=[cell.contentView layer];
    
    [layer setMasksToBounds:YES];
    
    //        [layer setCornerRadius:5];
    
    [layer setBorderWidth:2];
    
    [layer setBorderColor:[RGBA(220, 220, 220, 0.5) CGColor]];
    
    cell.backgroundColor=RGBA(245, 245, 245, 1);
    
    for (int i=0; i<_chooseMem.count; i++) {
        if ([model isEqual:_chooseMem[i]]) {
            cell.chooesBtn.selected=YES;
        }
    }
    [cell.chooesBtn setImage:[UIImage imageNamed:@"FriendsSendsPicturesSelectBigYIcon"] forState:UIControlStateSelected];
    cell.chooesBtn.tag=10000*indexPath.section+indexPath.row;
    
    [cell.chooesBtn addTarget:self action:@selector(cellButnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;    
    
}
//cell后面用于勾选用的btn的点击事件
-(void)cellButnClick:(UIButton *)butn{
    
    butn.selected=!butn.selected;
    
    if (butn.selected) {
        [_chooseMem addObject:_userDataArr[butn.tag/10000][butn.tag%10000]];
        if ([_userDataArr[butn.tag/10000] count]==1) {
            isChpoose[butn.tag/10000]=1;
        }
        
    }else{
        
        [_chooseMem removeObject:_userDataArr[butn.tag/10000][butn.tag%10000]];
        isChpoose[butn.tag/10000]=0;
        
    }
    [_barBttonview removeFromSuperview];
    _barBttonview=nil;
    [self craetBatBtn];
    [_tabView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    NSArray *array=@[@"校长",@"班主任",@"教师",@"监护人",@"家长"];
    
    UIButton *butn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 30)];
    
    butn.backgroundColor=[UIColor whiteColor];
    
    UILabel *qunLabel=[[UILabel alloc]init];
    
    qunLabel.frame=CGRectMake(30, 5, 100, 20);
    
    qunLabel.text=[_titleDataArr[section] roleName];
    
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
    
    if (isChpoose[section]?1:0) {
        [btnChoose setImage:[UIImage imageNamed:@"FriendsSendsPicturesSelectBigYIcon"] forState:UIControlStateNormal];
        
    }else{
        [btnChoose setImage:[UIImage imageNamed:@"FriendsSendsPicturesSelectBigNIcon"] forState:UIControlStateNormal];
    }
    
    btnChoose.tag=6000+section;

    [btnChoose addTarget:self action:@selector(btnChooseClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [butn addSubview:btnChoose];
    
    butn.tag=section+1100;
    
    [butn addTarget:self action:@selector(butnCliuck:) forControlEvents:UIControlEventTouchUpInside];
    
    return butn;
    
}

-(void)btnChooseClick:(UIButton *)btn{
    
    for (int i = 0; i < 20; i++) {
        if (btn.tag - 6000 == i) {
            isChpoose[i] = !isChpoose[i];
        }
        
    }
    if (isChpoose[btn.tag-6000]) {
        [_chooseMem addObjectsFromArray:_userDataArr[btn.tag-6000]];
    }else{
        [_chooseMem removeObjectsInArray:_userDataArr[btn.tag-6000]];
        
    }
    [_barBttonview removeFromSuperview];
    _barBttonview=nil;
    [self craetBatBtn];
    
    NSLog(@"%@",_chooseMem);
    
    [_tabView reloadData];
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 3;
    
}

-(void)butnCliuck:(UIButton *)btn{
    
    for (int i = 0; i < 20; i++) {
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
