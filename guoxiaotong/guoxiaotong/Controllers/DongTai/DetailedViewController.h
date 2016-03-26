//
//  DetailedViewController.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/19.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DongTaiList.h"

@interface DetailedViewController : UIViewController

@property(nonatomic,strong)DongTaiList *dtModel;


@property(nonatomic,strong)NSString *nacTitle;

@property(nonatomic,assign)BOOL zhan;//用于区分是否是点赞

@end
