//
//  HeaderViewController.h
//  guoxiaotong
//
//  Created by zxc on 16/3/23.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageHeaderView.h"
/**头部有图片的继承这个类*/
@interface HeaderViewController : UIViewController

@property (nonatomic, strong) ImageHeaderView *header;
@property (nonatomic, assign) CGFloat headerHeight;

@end
