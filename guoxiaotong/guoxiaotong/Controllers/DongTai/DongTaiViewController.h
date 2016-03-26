//
//  DongTaiViewController.h
//  guoxiaotong
//
//  Created by zxc on 16/3/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DongTaiViewController : UIViewController



@property(nonatomic,strong)NSMutableString *type;//动态类型0通知 1 分享
@property(nonatomic,assign)int userId;//用户ID
@property(nonatomic,assign)int page;//当前页码
@property(nonatomic,assign)int sendType;//发送类型  1 @  2发送范围
@property(nonatomic,assign)int userRoleId;//用户角色ID

@property(nonatomic,assign)BOOL TongZhi;//是否是通知

proArr(mine);
//空 正常 myPraise我的赞 myCollection我的收藏 mySend我发送的




@end
