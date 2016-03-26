//
//  ShousuoViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/10.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "ShousuoViewController.h"

#import "ShousuoMOdel.h"

@interface ShousuoViewController ()<UITextFieldDelegate>
{

    NSMutableArray *_shouSuoDataArr;
}

@end

@implementation ShousuoViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"高级搜索";
    
    self.view.backgroundColor=RGB(220, 220, 220);
    
    _shouSuoDataArr=[[NSMutableArray alloc]init];
 
    //创建搜索栏
    [self creatTextFile];
    
   
}

-(void)creatTextFile{
    
    UITextField *shouSuoTextFild=[[UITextField alloc]initWithFrame:CGRectMake(25, 70,screen_Width-50, 30)];
    
    shouSuoTextFild.borderStyle=UITextBorderStyleRoundedRect;
    
    shouSuoTextFild.placeholder=@"请输入搜索内容";
    
    shouSuoTextFild.font=[UIFont systemFontOfSize:14];
    
    shouSuoTextFild.layer.cornerRadius=5;
    
    shouSuoTextFild.tag=1300;
    
    [self.view addSubview:shouSuoTextFild];
    
    UIButton *shouShuoBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    shouShuoBtn.frame=CGRectMake(screen_Width-50,72, 25, 25);
    
    [shouShuoBtn setImage:[UIImage imageNamed:@"iconfont-sousuo.png"] forState:UIControlStateNormal];
    
    [shouShuoBtn addTarget:self action:@selector(shouShuoBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shouShuoBtn];
    
    shouSuoTextFild.backgroundColor=[UIColor whiteColor];
    

}

-(void)shouShuoBtn{
    
    UITextField *textFiel=[self.view viewWithTag:1300];

    [self textFieldShouldReturn:textFiel];


}


#pragma mark -以下是UITextFile的协议方法

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"当键盘上return键被点击，委托代理调用这个方法");
    //收回键盘
    //让文本框，放弃第一响应者的身份就可以关闭键盘了
    [textField   resignFirstResponder];
    
    [self relodData:textField.text];
    
    return YES;
    
}
-(void)relodData:(NSString *)str{
    
    //解析搜索数据
    NSString *httpStr = @"http://121.42.27.199:8888/csCampus/consult/findGroup.page";
    
    NSDictionary *Dict = @{@"name":str};
    
    AFHTTPRequestOperationManager *mana = [AFHTTPRequestOperationManager manager];
    
    mana.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mana POST:httpStr parameters:Dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSArray *array=dict[@"groupBean"];
        
        for (NSDictionary *sonDict in array) {
            
            ShousuoMOdel *model=[[ShousuoMOdel alloc]init];
            
            [model setValuesForKeysWithDictionary:sonDict];
            
            [_shouSuoDataArr addObject:sonDict];
            
        }
        
        NSLog(@"%@",_shouSuoDataArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

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
