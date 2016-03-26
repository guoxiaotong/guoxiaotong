//
//  DetailedViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "DetailedViewController.h"
#import "HuiFuViewController.h"

#import "DetailedCell.h"
#import "HuiFuTableViewCell.h"
#import "WeiHuiFuTableViewCell.h"

#import "DongTaiList.h"
#import "commenData.h"
#import "commenListData.h"

#import "DianZhanTableViewCell.h"


@interface DetailedViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *_tabView;
    
    NSMutableArray *_comMarry;
    
    NSMutableArray *_dianZhangMarry;//用于装点赞人名

}
@end

@implementation DetailedViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden=YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=self.nacTitle;
    
    _comMarry=[[NSMutableArray alloc]init];
    _dianZhangMarry=[[NSMutableArray alloc]init];
    
    self.view.backgroundColor=RGBA(245,245, 245, 0.9);
    
    [self loadData];
    
    [self creatTabView];
    
    //自定义tabBar
    [self creattabBar];


}
-(void)loadData{
       _dianZhangMarry=(NSMutableArray *)[self.dtModel.praise componentsSeparatedByString:@","];
    
    NSArray *array=self.dtModel.commentBean;
    if (array.count) {
        
    
//    for (NSDictionary *sonDic in array) {
//
        commenData *comModel=[[commenData alloc]init];
        
        [comModel setValuesForKeysWithDictionary:array[0]];
        
//        [_comMarry addObject:comModel];
//        
//        [_tabView reloadData];
        
        NSString *str=@"http://121.42.27.199:8888/csCampus/dynamic/detail.page";
        
        NSDictionary *Dict=@{@"dynamicId":comModel.dynamicId ,@"page":@1};
        
        AFHTTPRequestOperationManager *requst = [AFHTTPRequestOperationManager manager];
        //设置响应格式为NSData
        requst.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [requst  POST:str parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            NSArray *array=dict[@"comment"];
            
            for (NSDictionary *sonDict in array) {
                
                commenListData *model=[[commenListData alloc]init];
                [model setValuesForKeysWithDictionary:sonDict];
                [model setValuesForKeysWithDictionary:sonDict[@"userBean"]];
                
                [_comMarry addObject:model];
                
        }
            [_tabView reloadData];

            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        
//    }
    }
    
        

}


-(void)creattabBar{

    UIView *tabBarView=[[UIView alloc]initWithFrame:CGRectMake(0, screen_Height-44, screen_Width, screen_Height)];
    
    tabBarView.backgroundColor=[UIColor whiteColor];
    
    NSArray *array=@[@"iconfont-huifu-副本-3.png",@"iconfont-shoucang.png",@"iconfont-crmtubiao69.png",@"组-1_2"];
    
    NSArray *labelArry=@[@"回复",@"赞",@"收藏",@"更多"];
    
    for (int i=0; i<4; i++) {
       
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake( screen_Width/4*i,0, screen_Width/4, 44)];
        
        UIButton *viewbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        viewbtn.frame=CGRectMake(0, 0, screen_Width/4, 44);
        
        UIImageView *imgeView=[[UIImageView alloc]initWithFrame:CGRectMake(screen_Width/16, 10, screen_Width/16, 20)];
        imgeView.image=[UIImage imageNamed:array[i]];

        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(screen_Width/8, 10, screen_Width/16, 20)];
        label.text=labelArry[i];
        label.textAlignment=NSTextAlignmentCenter;
        
        label.font=[UIFont systemFontOfSize:10];
        
        
        [view addSubview:label];
        [tabBarView addSubview:view];
        
        [view addSubview:imgeView];

        viewbtn.tag=1400+i;
        [view addSubview:viewbtn];
        [viewbtn addTarget:self action:@selector(viewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }


    CALayer *layer=[tabBarView layer];
 
    [layer setMasksToBounds:YES];

    [layer setBorderWidth:1];

    [layer setBorderColor:[RGBA(220, 220, 220, 1) CGColor]];
    
    [self.view addSubview:tabBarView ];

}
-(void)viewBtnClick:(UIButton *)btn{
    switch (btn.tag-1400) {
        case 0:
            //回复
        {
            [self huifuBtnClick];
        }
            break;
        case 1:
            //点赞
        {
            
            for (NSString *nameStr in _dianZhangMarry) {
                
                if ([nameStr isEqualToString:self.dtModel.userName]) {
                    //以前点过赞了
                    btn.selected=YES;
                }
                btn.selected=!btn.selected;
                NSInteger praise;
                
                if (btn.selected==YES) {
                    praise=1;
                }else{
                    
                    praise=0;
                }
                
                NSString *str=@"http://121.42.27.199:8888/csCampus/dynamic/addComment.page";
                
                NSDictionary *Dict=@{@"type":@"1" ,@"userId":self.dtModel.userId,@"dynamicId":self.dtModel.dynamicId,@"praise":@(praise),@"mcontent":@"",@"collection":@0};
                
                AFHTTPRequestOperationManager *requst = [AFHTTPRequestOperationManager manager];
                //设置响应格式为NSData
                requst.responseSerializer = [AFHTTPResponseSerializer serializer];
                
                [requst  POST:str parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    
                    NSLog(@"%@",dict);
                    
        
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
                
    

            }
            
            
        }
            
            break;
        case 2:
            //收藏
            break;
        case 3:
            //更多
            break;
            
        default:
            break;
    }
    








}

-(void)creatTabView{

    _tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height) style:UITableViewStylePlain];;
    
    _tabView.delegate=self;
    
    _tabView.dataSource=self;
    
    _tabView.backgroundColor=[UIColor whiteColor];
    
    _tabView.backgroundColor=RGBA(245, 245, 245, 1);
    
    [self.view addSubview:_tabView];

}

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        
  
       if (self.zhan==YES) {
        
            if (_comMarry.count==0) {
                return 1;
            }else{
                return _comMarry.count;
            }

            
        }else{
            //呈现点赞下面的cell个数
            return 1;
       }
    
        
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

static NSString *cellID=@"cellName";
    if (indexPath.section==0) {
        DetailedCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"DetailedCell" owner:self options:nil]firstObject];
        }
        
        cell.model=self.dtModel;
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
            
            [cell.tuPian addSubview:picImageVew];
        }
        
        return cell;

    }else{
        
        
        if (self.zhan) {
            if (_comMarry.count==0) {
                WeiHuiFuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
                
                if (cell==nil) {
                    cell=[[[NSBundle mainBundle]loadNibNamed:@"WeiHuiFuTableViewCell" owner:self options:nil]firstObject];
                }
                //点击cell中的回复图片
                [cell.huifuBtn addTarget:self action:@selector(huifuBtnClick) forControlEvents:UIControlEventTouchUpInside];
                
                return cell;
                
                
            }else{
                
                HuiFuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell==nil) {
                    cell=[[[NSBundle mainBundle]loadNibNamed:@"HuiFuTableViewCell" owner:self options:nil]firstObject];
                }
                commenListData *model=_comMarry[indexPath.row];
                cell.model=model;
                
                [cell setIntroductionText:cell.model.content andphonnum:0];
                
                return cell;
            }

        }else{
        //赞被点击
            if (_dianZhangMarry.count==0) {
                
                WeiHuiFuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell==nil) {
                    cell=[[[NSBundle mainBundle]loadNibNamed:@"WeiHuiFuTableViewCell" owner:self options:nil]firstObject];
                }
                return cell;
                
            }else{
                
                DianZhanTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell==nil) {
                    cell=[[[NSBundle mainBundle]loadNibNamed:@"DianZhanTableViewCell" owner:self options:nil]firstObject];
                }
                cell.DainNmaeLabel.text=self.dtModel.praise;
                return cell;
            
            }
        
        
        }
        
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        UITableView *cell = [self tableView:_tabView cellForRowAtIndexPath:indexPath];
        
        return cell.frame.size.height;
      
        
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section==1) {
        return 30;
    }else{
    
        return 5;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 15;


}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
    
        UIView *btnView=[[UIView alloc]initWithFrame:CGRectMake(20, 0, 300, 20)];
        
        NSArray *butArry=@[[NSString stringWithFormat:@"回复（%ld）",[self.dtModel.commentBean count]],[NSString stringWithFormat:@"赞（%ld)",_dianZhangMarry.count]];
        
        for (int i=0; i<2; i++) {
            UIButton *buton=[UIButton buttonWithType:UIButtonTypeCustom];
            
            buton.frame=CGRectMake(20+80*i, 5, 80, 20);
            [buton setTitle:butArry[i] forState:UIControlStateNormal];
            buton.titleLabel.font=[UIFont systemFontOfSize:14];
            [buton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [buton setTitleColor:RGBA(65, 105, 225, 1) forState:UIControlStateSelected];
            buton.tag=1350+i;
            [buton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
            [btnView addSubview:buton];
            
            
            UIView *selectView=[[UIView alloc]initWithFrame:CGRectMake(20+i*75, 28, 80, 2)];
            selectView.tag=1360+i;
            [btnView addSubview:selectView];
            
            if (self.zhan) {
                if (i==0) {
                    selectView.backgroundColor=RGBA(65, 105, 225, 1 );
                    buton.selected=YES;
                }
            }else{
                if (i==1) {
                    buton.selected=YES;
                     selectView.backgroundColor=RGBA(65, 105, 225, 1 );
                }

            
            }
           

        }
        
        return btnView;
        
        
    }
    return nil;
}
-(void)buttonClick:(UIButton *)but{
    
    if (but.tag-1350==0) {
        self.zhan=YES;
    }else{
        self.zhan=NO;
    }
    
    for (int i=0; i<2; i++) {
        UIButton *butt=[self.view viewWithTag:i+1350];
        UIView *view=[self.view viewWithTag:1360+i];
        
        if (but==butt) {
            butt.selected=YES;
            view.backgroundColor=RGBA(65, 105, 225, 1);
        }else {
            butt.selected=NO;
            view.backgroundColor=[UIColor clearColor];
            
        }
        
    }

    [_tabView reloadData];

}


//回复图片按钮被点
-(void)huifuBtnClick{

    HuiFuViewController *huiVC=[[HuiFuViewController alloc]init];
    huiVC.naTitle=@"回复";
    
   [self.navigationController pushViewController:huiVC animated:YES];
    
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
