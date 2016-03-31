//
//  ChooseMemberViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/12.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ChooseMemberViewController.h"
#import "XuanZheQunLiaoTableViewCell.h"
#import "ChooseMenSingle.h"

#import "RoleModel.h"

@interface ChooseMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tabView;
    
    UITableView *_roleTabView;//角色tabView
    
    UIImageView *_imageView;
    
    NSMutableArray *_userDataArr;
    NSMutableArray *_titleDataArr;
    
    NSMutableArray  *_roleDataArry;//角色数组
    NSMutableArray *_chooseMem;//被选中的人
    
    UIButton *_btnleft;//选择角色按钮
    UIButton *_btnRit;//当前角色按钮
    
    //数组
    int isOpen[20];
    
    //是否勾选
    int isChpoose[20];

}

@end

@implementation ChooseMemberViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title=@"选择群聊成员";
    
    self.view.backgroundColor=RGBA(220, 220, 220, 1);
    
    _titleDataArr=[[NSMutableArray alloc]init];
    _userDataArr=[[NSMutableArray alloc]init];
    _chooseMem=[[NSMutableArray alloc]initWithArray:self.choosedarry];
    
    _roleDataArry=[[NSMutableArray alloc]init];
    SingleUserInfo *sigUser=[SingleUserInfo shareUserInfo];
    _roleDataArry=sigUser.roleList;

    
    [self lodeData];
    
    //添加导航栏右边的确定按钮
    [self creatRightBtn];
    //创建两个按钮
    [self creatBut];
    
    //创建tabView
    [self creatTabView];
    
    //创建角色tabView
    [self creatRoleTabView];

}
-(void)lodeData{
//    [LoadingView showCenterActivity:self.view];
    
    [_userDataArr removeAllObjects];
    [_titleDataArr removeAllObjects];
    
    SingleUserInfo *singleUsel=[SingleUserInfo shareUserInfo];
    
    
    NSString *urlStr = @"http://121.42.27.199:8888/csCampus/dynamic/contact.page";
    
    NSDictionary *bodyDict = @{@"roleId":@(singleUsel.roleId),@"userId":singleUsel.userId};
    
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
            
            [_tabView reloadData];
        }
        
//        [LoadingView hideCenterActivity:self.view];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    

}

-(void)creatRoleTabView{
    
    _roleTabView=[[UITableView alloc]initWithFrame:CGRectMake(10, 105, screen_Width/2-20, 30*(_roleDataArry.count+1)) style:UITableViewStylePlain];
    
    _roleTabView.delegate=self;
    
    _roleTabView.dataSource=self;
    
    _roleTabView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
    
    //
    //    __roleTabView.backgroundColor=RGB(41, 36,33);
    
    
    CALayer *layer=[_roleTabView layer];
    
    [layer setMasksToBounds:YES];
    
    [layer setCornerRadius:5];
    
    [layer setBorderWidth:1];
    
    [layer setBorderColor:[RGBA(41, 36, 33, 0.5) CGColor]];
    
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
    
    ChooseMenSingle *singele=[ChooseMenSingle shareChooseMen];
    singele.ChooseMenArry=_chooseMem;
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

//创建两个按钮
-(void)creatBut{
    SingleUserInfo *singUser=[SingleUserInfo shareUserInfo];
    
    _btnleft=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    _btnleft.frame=CGRectMake(5, 5, screen_Width/2-10, 40);
    
    _btnleft.backgroundColor=[UIColor whiteColor];
    
    _btnleft.layer.cornerRadius=5;
    
    [_btnleft setTitle:@"全部角色" forState:UIControlStateNormal];
    
    [_btnleft setTintColor:[UIColor blackColor]];
    
    [_btnleft addTarget:self action:@selector(btnleftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnleft];
    UIImageView *iamView=[[UIImageView alloc]initWithFrame:CGRectMake(screen_Width/2-30, 15, 15, 10)];
    iamView.image=[UIImage imageNamed:@"iconfont-control-arr.png"];
    [_btnleft addSubview:iamView];

    
    [self.view addSubview:_btnleft];
    
    _btnRit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    _btnRit.frame=CGRectMake(screen_Width/2+5, 5, screen_Width/2-10, 40);
    
    _btnRit.backgroundColor=[UIColor whiteColor];
    
    _btnRit.layer.cornerRadius=5;
    
    [_btnRit setTitle:[NSString stringWithFormat:@"当前角色:%@",singUser.roleInfo.roleName] forState:UIControlStateNormal];
    
    [_btnRit setTintColor:[UIColor blackColor]];
    
    [self.view addSubview:_btnRit];
    
}

//点击全部角色
-(void)btnleftClick{
    
    UIView *allImageView=[[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    [self.tabBarController.view addSubview:allImageView];
    
    UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesClick:)];
    
    tapGes.cancelsTouchesInView=NO;
    
    [allImageView addGestureRecognizer:tapGes];
    
    allImageView.userInteractionEnabled=YES;
    
    [UIView animateWithDuration:3 animations:^{
        
        [allImageView addSubview:_roleTabView];
    }];
    
    
}

-(void)tapGesClick:(UITapGestureRecognizer *)tap{
    
    UIImageView *imageView=(UIImageView *)tap.view;
    
    NSLog(@"23333");
    
    [imageView removeFromSuperview];
    imageView=nil;
    
}



//创建tabView
-(void)creatTabView{
    
    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, screen_Width, screen_Height-115) style:UITableViewStyleGrouped];
    
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
    if (tableView==_tabView) {
         return _titleDataArr.count;
    }else{
    
        return 1;
    
    }
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_tabView) {
        return isOpen[section]?[_userDataArr[section] count]:0;
    }else{
    
        return _roleDataArry.count+1;
    
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *cellID=@"cellName";
    
    if (tableView==_tabView) {
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

    }else{
        
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
        
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        
        cell.selectionStyle=NO;
        
        cell.backgroundColor=[UIColor whiteColor];
        CALayer *layer=[cell.contentView layer];
        [layer setMasksToBounds:YES];
        [layer setBorderWidth:1];
        [layer setBorderColor:[RGBA(41, 36, 33, 0.5) CGColor]];
        
        return cell;
        
    
    }
    
    
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
    
//    for (int i=0; i<_userDataArr.count; i++) {
//        int k=0;
//        for (int t=0; t<[_userDataArr[i] count]; t++) {
////            UIButton *btn=[self.view viewWithTag:10000*i+t];
////            if (btn.selected==YES) {
////                k++;
////            }
//            for (int m=0; m<_chooseMem.count; i++) {
//                if ([_userDataArr[i][t] isEqual:_chooseMem[m]]) {
//                    k++;
//                }
//            }
//            
//        }
//        if (k==[_userDataArr[i] count]) {
//            
//            isChpoose[i]=1;
//        }else{
//            isChpoose[i]=0;
//            
//        }
//    }

    
    [_tabView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tabView) {
         return 60;
    }else{
    
        return 30;
    
    }
   

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIButton *butn=[UIButton buttonWithType:UIButtonTypeCustom];
   butn.frame=CGRectMake(0, 0, screen_Width, 30);
    
    butn.backgroundColor=[UIColor whiteColor];
    
    UILabel *qunLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 5, 100, 20)];
    
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
    
    [butn addSubview:btnChoose];
    
       butn.tag=section+1100;
    
    [butn addTarget:self action:@selector(butnCliuck:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnChoose addTarget:self action:@selector(btnChooseClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    NSLog(@"%@",_chooseMem);

    [_tabView reloadData];


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==_tabView) {
        return 30;
    }else{
    
        return 0;
    }

    

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (tableView==_tabView) {
         return 3;
    }else{
    
        return 0;
    
    }
   

}

-(void)butnCliuck:(UIButton *)btn{
    
    for (int i = 0; i < 20; i++) {
        if (btn.tag - 1100 == i) {
            isOpen[i] = !isOpen[i];
        }
        
    }
    
    [_tabView reloadData];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    
    if (tableView==_roleTabView) {
        
        SingleUserInfo *singUser=[SingleUserInfo shareUserInfo];
        if (indexPath.row==0) {
            singUser.roleId=0;
            singUser.roleInfo.roleName=@"全部角色";
            
        }else{
            RoleModel *model=_roleDataArry[indexPath.row-1];
            singUser.roleId=model.roleId;
            singUser.roleInfo.roleName=model.roleName;
            
        }
        [_btnleft removeFromSuperview];
        [_btnRit removeFromSuperview];
        _btnRit=nil;
        _btnleft=nil;
        [self creatBut];
        
        [self lodeData];
        
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
