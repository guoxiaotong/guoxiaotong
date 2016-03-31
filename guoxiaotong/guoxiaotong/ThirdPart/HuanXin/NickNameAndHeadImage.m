//
//  NickNameAndHeadImage.m
//  guoxiaotong
//
//  Created by zxc on 16/3/30.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "NickNameAndHeadImage.h"

@interface NickNameAndHeadImage()

@property (strong, nonatomic) NSMutableArray *UserNames;

@property (strong, nonatomic) NSMutableDictionary *NickNames;

@property (nonatomic) BOOL DownloadHasDone;

@property (nonatomic) BOOL LoadFromLocalDickDone;

@end

static NickNameAndHeadImage* _instance = nil;

@implementation NickNameAndHeadImage

//+(instancetype) shareInstance
//{
//    static dispatch_once_t onceToken ;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc] init] ;
//    }) ;
//    
//    return _instance ;
//}
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _DownloadHasDone = NO;
//        _LoadFromLocalDickDone = NO;
//        _UserNames = [NSMutableArray array];
//        NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:dUserDefaults_Dic_NickName];
//        if (dic == nil || [dic count] == 0) {
//            _NickNames = [NSMutableDictionary dictionary];
//            _LoadFromLocalDickDone = YES;
//        }
//        else
//        {
//            _LoadFromLocalDickDone = YES;
//            _NickNames = [NSMutableDictionary dictionaryWithDictionary:dic];
//        }
//        
//        
//    }
//    return self;
//}
//
//
//- (void)loadUserProfileInBackgroundWithBuddy:(NSArray*)buddyList
//{
//    _DownloadHasDone = NO;
//    [_UserNames removeAllObjects];
//    [_NickNames removeAllObjects];
//    
//    if (buddyList == nil || [buddyList count] == 0)
//    {
//        return;
//    }
//    else
//    {
//        for (EMBuddy *buddy in buddyList)
//        {
//            [_UserNames addObject:buddy.username];
//        }
//    }
//    
//    [self loadUserProfileInBackgroundWithUsernames];
//}
//
//- (void)loadUserProfileInBackgroundWithUsernames
//{
//    
//    _DownloadHasDone = NO;
//    
//    //首先构造Json数组
//    //1.头
//    NSMutableString *jsonString = [[NSMutableString alloc] initWithString:@"{\"mobilelist\":["];
//    
//    for(NSString *mobile in _UserNames){
//        
//        //2. 遍历数组，取出键值对并按json格式存放
//        NSString *string;
//        
//        string  = [NSString stringWithFormat:
//                   @"{\"mobile\":\"%@\"},",mobile];
//        
//        [jsonString appendString:string];
//        
//    }
//    // 3. 获取末尾逗号所在位置
//    NSUInteger location = [jsonString length]-1;
//    
//    NSRange range       = NSMakeRange(location, 1);
//    
//    // 4. 将末尾逗号换成结束的]}
//    [jsonString replaceCharactersInRange:range withString:@"]}"];
//    
//    NSLog(@"请求昵称时要发送的jsonString = %@",jsonString);
//    
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:dUserDefaults_String_LoginToken];
//    NSString *url = [NSString stringWithFormat:@"customer/contract?token=%@",token];
//    NSDictionary *postdic = [NSDictionary dictionaryWithObjectsAndKeys:jsonString,@"mobilelist",nil];
//    [HttpUtil POST_Path:url params:postdic completed:^(id JSON,NSString *str)
//     {
//         _LoadFromLocalDickDone = NO;
//         NSLog(@"打印JSON数据：%@",str);//打印Json数据
//         NSString *state = [[JSON objectForKey:@"json"] objectForKey:@"state"];
//         if ([state isEqualToString:@"1"]) {//获得昵称成功
//             
//             //打印信息
//             NSString *msg = [[JSON objectForKey:@"json"] objectForKey:@"msg"];
//             NSLog(@"获得昵称成功:msg:%@",msg);
//             
//             NSArray *array = [[[JSON objectForKey:@"json"] objectForKey:@"data"] objectForKey:@"list"];
//             
//             
//             for (NSDictionary *dic in array) {
//                 [_NickNames setObject: [dic objectForKey:@"name"] forKey: [dic objectForKey:@"mobile"]];
//             }
//             
//             NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//             [ud setObject:_NickNames forKey:dUserDefaults_Dic_NickName];
//             [ud synchronize];
//             _LoadFromLocalDickDone = YES;
//             
//             _DownloadHasDone = YES;
//             
//             
//         }
//         else//获得昵称失败
//         {
//             _DownloadHasDone = NO;
//             //打印信息
//             NSString *msg = [[JSON objectForKey:@"json"] objectForKey:@"msg"];
//             NSLog(@"获得昵称失败:msg:%@",msg);
//         }
//     }
//                 failed:^(NSError *err){
//                     
//                     _DownloadHasDone = NO;
//                     [SVProgressHUD showSuccessWithStatus:@"登录失败"];
//                     NSLog(@"获得昵称失败:%@",err);
//                     
//                 }];
//}
//
//- (NSString*)getNicknameByUserName:(NSString*)username
//{
//    if(_DownloadHasDone == YES)
//    {
//        NSString *string = [_NickNames objectForKey:username];
//        if (string == nil || [string length] == 0) {
//            return username;
//        }
//        return string;
//    }
//    
//    else if(_LoadFromLocalDickDone == YES)
//    {
//        NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:dUserDefaults_Dic_NickName];
//        NSString *string = [dic objectForKey:username];
//        if (string == nil || [string length] == 0) {
//            return username;
//        }
//        return string;
//    }
//    return username;
//}


@end


