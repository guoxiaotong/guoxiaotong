//
//  HuiFuViewController.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuiFuViewController : UIViewController

proStr(naTitle);
@property(nonatomic,strong)UIImageView *myImageView;

@property(nonatomic,assign) int type;//发送类型 0通知 1 分享
@property(nonatomic,assign)BOOL isFengwei;



@property(nonatomic,strong)NSMutableArray*imageArr;
@property(nonatomic,strong)NSMutableArray*dataArr;



@end
