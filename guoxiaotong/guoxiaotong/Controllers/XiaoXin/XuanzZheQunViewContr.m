//
//  XuanzZheQunViewContr.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/11.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "XuanzZheQunViewContr.h"
#import "QunTableViewCell.h"

#import "GroupModel.h"

@interface XuanzZheQunViewContr ()<UITableViewDataSource,UITableViewDelegate>
{

    UITableView *_qunTabView;
    
    NSMutableArray *_dataArr;

}
@end

@implementation XuanzZheQunViewContr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=RGB(220, 220, 220);
    
    self.navigationItem.title=@"选择群对话";
    
    _dataArr=[[NSMutableArray alloc]init];
    //解析数据
    [self reloadData];
    
    
    //创建两个按钮
    [self creatBut];
    
    //创建tabView
    [self creatTabView];
    
}
-(void)reloadData{

    NSString *urlStr = @"http://121.42.27.199:8888/csCampus/dynamic/contact.page";
    
    NSDictionary *bodyDict = @{@"roleId":@2,@"userId":@1046};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager  POST:urlStr parameters:bodyDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功");
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        NSArray *subrray=dict[@"group"];
        for (NSDictionary *sonDict1 in subrray) {
            
            GroupModel *model=[[GroupModel alloc]init];
            
            [model setValuesForKeysWithDictionary:sonDict1];
            
            [_dataArr addObject:model];
            
            [_qunTabView reloadData];
        
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
    




}

//创建tabView
-(void)creatTabView{

    _qunTabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, screen_Width, screen_Height-50-64) style:UITableViewStylePlain];
    
    _qunTabView.backgroundColor=[UIColor clearColor];
    
//    _qunTabView.separatorStyle=YES;
    
    _qunTabView.delegate=self;
    
    _qunTabView.dataSource=self;
    
    _qunTabView.bounces=NO;
    
//    [_qunTabView setSeparatorColor:[UIColor redColor]];
    
    [self.view addSubview:_qunTabView];
}

//创建两个按钮
-(void)creatBut{
    
    UIButton *btnleft=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btnleft.frame=CGRectMake(5, 5, screen_Width/2-10, 40);
    
    btnleft.backgroundColor=[UIColor whiteColor];
    
    btnleft.layer.cornerRadius=5;
    
    [btnleft setTitle:@"我管理的群" forState:UIControlStateNormal];
    
    [btnleft setTintColor:[UIColor blackColor]];
    
    [self.view addSubview:btnleft];
    
    UIButton *btnRit=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    btnRit.frame=CGRectMake(screen_Width/2+5, 5, screen_Width/2-10, 40);
    
    btnRit.backgroundColor=[UIColor whiteColor];
    
    btnRit.layer.cornerRadius=5;
    
    [btnRit setTitle:@"我加入的群" forState:UIControlStateNormal];
    
    [btnRit setTintColor:[UIColor blackColor]];
    
    [self.view addSubview:btnRit];
    
}

#pragma mark UITableViewDataSource{


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName=@"cellId";
    
    
    QunTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"QunTableViewCell" owner:self options:nil]firstObject];
    }
    GroupModel *model=_dataArr[indexPath.row];
    
    cell.nameLabel.text=model.groupName;
    
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ketangzhiwai.com/%@",model.picPath]]];
    
    //设置layer
    CALayer *layer=[cell.contentView layer];
    //是否设置边框以及是否可见
    [layer setMasksToBounds:YES];
    //设置边框圆角的弧度
    //        [layer setCornerRadius:5];
    //设置边框线的宽
    //
    [layer setBorderWidth:2];
    //设置边框线的颜色
    [layer setBorderColor:[RGBA(220, 220, 220, 1) CGColor]];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
    
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
