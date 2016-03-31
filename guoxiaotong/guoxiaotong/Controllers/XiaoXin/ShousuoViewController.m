//
//  ShousuoViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ShousuoViewController.h"
#import "ShouGroupCell.h"
#import "XuanZheQunLiaoTableViewCell.h"

#import "ShousuoMOdel.h"
#import "UserListDataModel.h"

@interface ShousuoViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{

    NSMutableArray *_shouSuoDataArr;//用于装群组的model
    NSMutableArray *_userListArry;//用于装收缩到的联系人的model
    
    UITableView *_shouShuotabView;
}

@end

@implementation ShousuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"高级搜索";
    
    self.view.backgroundColor=RGB(220, 220, 220);
    
    _shouSuoDataArr=[[NSMutableArray alloc]init];
    _userListArry=[[NSMutableArray alloc]init];
 
    //创建搜索栏
    [self creatTextFile];
    
   
}

-(void)creatTextFile{
    
    UITextField *shouSuoTextFild=[[UITextField alloc]initWithFrame:CGRectMake(25, 5,screen_Width-50, 30)];
    
    shouSuoTextFild.borderStyle=UITextBorderStyleRoundedRect;
    
    shouSuoTextFild.placeholder=@"请输入搜索内容";
    
    shouSuoTextFild.font=[UIFont systemFontOfSize:14];
    
    shouSuoTextFild.layer.cornerRadius=5;
    
    shouSuoTextFild.tag=1300;
    
    [self.view addSubview:shouSuoTextFild];
    
    UIButton *shouShuoBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    shouShuoBtn.frame=CGRectMake(screen_Width-50,7, 25, 25);
    
    [shouShuoBtn setImage:[UIImage imageNamed:@"iconfont-sousuo.png"] forState:UIControlStateNormal];
    
    [shouShuoBtn addTarget:self action:@selector(shouShuoBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shouShuoBtn];
    
    shouSuoTextFild.backgroundColor=[UIColor whiteColor];
    

}

-(void)shouShuoBtn{
    
    UITextField *textFiel=[self.view viewWithTag:1300];
    
    [self relodData:textFiel.text];
    //开始创建tabView
    [self creattabView];

   
    [self textFieldShouldReturn:textFiel];


}


#pragma mark -以下是UITextFile的协议方法

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"当键盘上return键被点击，委托代理调用这个方法");
    //收回键盘
    //让文本框，放弃第一响应者的身份就可以关闭键盘了
    [textField   resignFirstResponder];
    
    return YES;
    
}
-(void)relodData:(NSString *)str{
    
    //解析搜索数据
    NSString *http = @"http://121.42.27.199:8888/csCampus/consult/findGroup.page";
    
    NSDictionary *Diction = @{@"name":str};
    
    AFHTTPRequestOperationManager *manaGer = [AFHTTPRequestOperationManager manager];
    
    manaGer.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manaGer POST:http parameters:Diction success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSArray *array=dict[@"groupBean"];
        
        for (NSDictionary *sonDict in array) {
            
            ShousuoMOdel *model=[[ShousuoMOdel alloc]init];
            
            [model setValuesForKeysWithDictionary:sonDict];
            
            [_shouSuoDataArr addObject:model];
            
        }
        [_shouShuotabView reloadData];
        
        
        NSLog(@"%@",_shouSuoDataArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    //解析搜索数据
    NSString *httpStr = @"http://121.42.27.199:8888/csCampus/user/userList.page";
    
    NSDictionary *Dict = @{@"userName":str};
    
    AFHTTPRequestOperationManager *manaG = [AFHTTPRequestOperationManager manager];
    
    manaG.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manaG POST:httpStr parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSArray *array=dict[@"roleInfo"];
        
        for (NSDictionary *sonDict in array) {
            
            UserListDataModel *model=[[UserListDataModel alloc]init];
            
            [model setValuesForKeysWithDictionary:sonDict];
            
            [_userListArry addObject:model];
            
        }
        [_shouShuotabView reloadData];
        
        
        NSLog(@"%@",_userListArry);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];




}
-(void)creattabView{

    _shouShuotabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, screen_Width, screen_Height-84) style:UITableViewStyleGrouped];
    
    _shouShuotabView.delegate=self;
    
    _shouShuotabView.dataSource=self;
    
    _shouShuotabView.backgroundColor=RGBA(220, 220, 220, 0.8);
    
    [self.view addSubview:_shouShuotabView];

}
#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return 2;


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0) {
        return _userListArry.count;
    }else{
    
        return _shouSuoDataArr.count;
    
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *cellId=@"cellName";
    
    if (indexPath.section==0) {
        UserListDataModel *model=_userListArry[indexPath.row];
        if (model.desc!=nil) {
            XuanZheQunLiaoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell==nil) {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"XuanZheQunLiaoTableViewCell" owner:self options:nil]firstObject];
            }
            cell.nameLanel.text=model.userName;
            cell.jieShaoLabel.text=model.desc;
            cell.iconImageView.image=[UIImage imageNamed:@"myList_jiaose"];
            [cell.chooesBtn removeFromSuperview];
            cell.chooesBtn=nil;
            
            //将图片设置成圆角
            CALayer *layer=[cell.iconImageView layer];
            [layer setMasksToBounds:YES];
            [layer setCornerRadius:20];
            
            CALayer *caLayer=[cell.contentView layer];
            [caLayer setMasksToBounds:YES];
            [caLayer setBorderColor:[RGBA(220, 220, 220, 1) CGColor]];
            [caLayer setBorderWidth:0.3];

            return cell;
            
        }else{
            
            ShouGroupCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell==nil) {
                cell=[[[NSBundle mainBundle]loadNibNamed:@"ShouGroupCell" owner:self options:nil]firstObject];
                
            }
            cell.nameLabel.text=model.userName;
            //将图片设置成圆角
            CALayer *layer=[cell.iconImage layer];
            [layer setMasksToBounds:YES];
            [layer setCornerRadius:20];
            
            CALayer *caLayer=[cell.contentView layer];
            [caLayer setMasksToBounds:YES];
            [caLayer setBorderColor:[RGBA(220, 220, 220, 1) CGColor]];
            [caLayer setBorderWidth:0.3];
            
            return cell;

        
        }
        
        
    }else{
        
        //群组
        ShouGroupCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"ShouGroupCell" owner:self options:nil]firstObject];
            
        }
        ShousuoMOdel *model=_shouSuoDataArr[indexPath.row];
        cell.model=model;
        //将图片设置成圆角
        CALayer *layer=[cell.iconImage layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:20];
        
        CALayer *caLayer=[cell.contentView layer];
        [caLayer setMasksToBounds:YES];
        [caLayer setBorderColor:[RGBA(220, 220, 220, 1) CGColor]];
        [caLayer setBorderWidth:0.3];
        
        return cell;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UILabel *headerLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, screen_Width, 30)];
    if (section==0) {
        headerLabel.text=@"   联系人";
    }else{
        headerLabel.text=@"   群组";
    
    }
    headerLabel.backgroundColor=[UIColor whiteColor];
    
    return headerLabel;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0;
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
