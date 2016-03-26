//
//  PhotoViewController.m
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionViewCell.h"

#import "HuiFuViewController.h"

#import "XuanZhePhonData.h"
#import "DataManager.h"

@interface PhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView  *_cView;
    
    NSInteger phonenum;
    //用于自定义tabbar
    UIView *_barView;
    //用于显示选择图片个数的label
    UILabel *_numLabel;
    
    NSMutableArray *_XuanzheImageArry;
    
    //用于提示最多只能选择9张得label；
    UILabel *_tisileabel;
}

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    phonenum=0;
    
    _XuanzheImageArry=[[NSMutableArray alloc]init];
    
    self.dataArr=[NSMutableArray arrayWithCapacity:0];
    self.imageArr=[NSMutableArray arrayWithCapacity:0];
    
    self.navigationItem.title=@"所有照片";
    
    [self loadData];
    //创建rightBarButtonItem
    [self creatRightBtn];
    
    [self creatCollectionView];
    //自定义barbutn
    [self creatBarview];
    
    
    
}
-(void)creatRightBtn{
    
    UIButton *ritBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    ritBtn.frame=CGRectMake(screen_Width-25, 0, 50, 50);
    
    [ritBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [ritBtn addTarget:self action:@selector(ritBtnClik) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *ritBarBtn=[[UIBarButtonItem alloc]initWithCustomView:ritBtn];
    
    self.navigationItem.rightBarButtonItem=ritBarBtn;
    
    
}
//点击取消按钮
-(void)ritBtnClik{

    [self.navigationController popViewControllerAnimated:YES];


}
-(void)creatBarview{
    _barView=[[UIView alloc]initWithFrame:CGRectMake(0, screen_Height-44-64, screen_Width, 44)];
    _barView.backgroundColor=RGBA(41, 36, 33, 0.9);
    [self.view addSubview:_barView];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame=CGRectMake(screen_Width-80, 5, 70, 30);
    
    [btn.layer setCornerRadius:5];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.backgroundColor=RGBA(65, 105, 225, 1);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [_barView addSubview:btn];
    


}

//确定按钮被点击
-(void)btnClick{
    
    //单例
    XuanZhePhonData *xzdata=[XuanZhePhonData shareImage];
    xzdata.imarry=_XuanzheImageArry;
        
    [self.navigationController popViewControllerAnimated:YES];


}
-(NSMutableArray *)huifuImage{


    return _XuanzheImageArry;


}


-(void)loadData{
    /****要防止通知****/

    [self.dataArr removeAllObjects];
    [self.imageArr removeAllObjects];
    DataManager*manager=[DataManager shareManager];
    /******先倒序加载相机本身相册的图片*******/
    for (int i=0; i<manager.imageArr.count; i++) {
        NSString*name=[[manager.imageArr[i] allKeys] firstObject];
        if ([name isEqualToString:@"相机胶卷"]) {
            NSArray*imageArr=[manager.imageArr[i] objectForKey:name];
            NSArray*dataArr=[manager.dataArr[i] objectForKey:name];
            for (int i=(int)imageArr.count-1; i>=0; i--) {
                [self.imageArr addObject:imageArr[i]];
                [self.dataArr  addObject:dataArr[i]];
            }
        }
    }
    for (int i=0; i<manager.imageArr.count; i++) {
        NSString*name=[[manager.imageArr[i] allKeys] firstObject];
        if ([name isEqualToString:@"相机胶卷"]) {
            
        }
        else{
            NSArray*imageArr=[manager.imageArr[i] objectForKey:name];
            NSArray*dataArr=[manager.dataArr[i] objectForKey:name];
            for (int i=(int)imageArr.count-1; i>=0; i--) {
                [self.imageArr addObject:imageArr[i]];
                [self.dataArr  addObject:dataArr[i]];
            }
        }
    }
    
    [_cView    reloadData];
    
}


-(void)creatCollectionView{

    //创建流式布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //单元格（每一项）的大小（宽高）
    layout.itemSize = CGSizeMake((screen_Width-50)/4,(screen_Width-50)/4);
    //最小格间距（每个单元格之间的最小间距）
    layout.minimumInteritemSpacing = 5.0;
    //最小行间距
    layout.minimumLineSpacing = 7.0;
    //分区之间的边距
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //设置滚动的方法(Vertical竖向)
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _cView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height-54) collectionViewLayout:layout];
    _cView.delegate = self;
    _cView.dataSource = self;
    _cView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cView];
    
    //注册Cell
    [_cView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"cellName"];
   

}


#pragma mark - UICollectionViewDataSource
//1问 有几个分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
//2问 每个分区有多少项
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.imageArr count];
}
//3问 每一项长什么样子
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //从复用池里去取有没有符合要求的单元格，如果没有，自己创建一个cell返回
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellName" forIndexPath:indexPath];
    
    cell.phonImagView.image=self.imageArr[indexPath.row];
    cell.isChooseBtn.tag=2000+indexPath.row;
    //判断之前是否选中
    for (UIImage *img in self.imageViewArry) {
        if ([img isEqual:self.imageArr[indexPath.row]]) {
            //表示之前选中过
            cell.isChooseBtn.selected=YES;
            phonenum++;
            [_XuanzheImageArry addObject:self.imageArr[indexPath.row]];
            [_numLabel removeFromSuperview];
            _numLabel=nil;
            [self creatnumLabel];
        }
    }
    
    [cell.isChooseBtn addTarget:self action:@selector(isChooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}
-(void)isChooseBtnClick:(UIButton *)btn{
    
  
     btn.selected=!btn.selected;
    
    if (phonenum<9) {
        if (btn.selected) {
            phonenum++;
            [_XuanzheImageArry addObject:self.imageArr[btn.tag-2000]];
            
        }else{
            phonenum--;
            [_XuanzheImageArry removeObject:self.imageArr[btn.tag-2000]];
            
            
        }
        
    }else{
        
        btn.selected=!btn.selected;
        if (btn.selected) {
            phonenum--;
            [_XuanzheImageArry removeObject:self.imageArr[btn.tag-2000]];
            btn.selected=NO;
        }else{

        [_tisileabel removeFromSuperview];
        _tisileabel=[[UILabel alloc]initWithFrame:CGRectMake((screen_Width-150)/2, 300, 150, 50)];
        _tisileabel.backgroundColor=RGBA(41, 36, 33, 1);
        _tisileabel.text=@"最多只能选择9张";
        _tisileabel.textAlignment=NSTextAlignmentCenter;
        CALayer *layer=[_tisileabel layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:5];
        
        [self.view addSubview:_tisileabel];
        [UIView animateWithDuration:3 animations:^{
            _tisileabel.alpha=0;
          
        }];
            
        }

    }
    
    if (phonenum) {
        [_numLabel removeFromSuperview];
        _numLabel=nil;
        [self creatnumLabel];
    }else{
        [_numLabel removeFromSuperview];
        _numLabel=nil;
    }

    
    NSLog(@"%@",_XuanzheImageArry);
    
    
    
}
//用于显示选择的图片张数
-(void)creatnumLabel{

    _numLabel=[[UILabel alloc]initWithFrame:CGRectMake(screen_Width-90, 0, 20, 20)];
    _numLabel.backgroundColor=RGBA(0, 225, 127, 1);
    _numLabel.text=[NSString stringWithFormat:@"%ld",phonenum];
    _numLabel.textAlignment=NSTextAlignmentCenter;
    CALayer *layer=[_numLabel layer];
    
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:10];
    //    [layer setBorderWidth:1];
    
    //    [layer setBorderColor:[RGBA(220, 220, 220, 1) CGColor]];
    
    [_barView addSubview:_numLabel ];
    

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
