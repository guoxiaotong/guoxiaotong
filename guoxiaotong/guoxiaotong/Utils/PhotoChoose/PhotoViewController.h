//
//  PhotoViewController.h
//  guoxiaotong
//
//  Created by 刘晓娜 on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoViewController : UIViewController



@property(nonatomic,strong)NSMutableArray*imageArr;
@property(nonatomic,strong)NSMutableArray*dataArr;


@property(nonatomic,strong)NSMutableArray *imageViewArry;//从回复界面更传过来的已经选好的图片


@end
