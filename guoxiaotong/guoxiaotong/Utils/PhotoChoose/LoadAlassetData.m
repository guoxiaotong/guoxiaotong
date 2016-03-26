//
//  LoadAlassetData.m
//  PhotoChoose
//
//  Created by lijunxiang on 15/7/3.
//  Copyright (c) 2015年 lijunxiang. All rights reserved.
//

#import "LoadAlassetData.h"
#import "DataManager.h"
static LoadAlassetData*alassetData;

@implementation LoadAlassetData{
    BOOL isScreenshot;
}

+(instancetype)shareManager{
    static dispatch_once_t block;
    dispatch_once(&block, ^{
        alassetData=[[LoadAlassetData alloc]init];
    });
    return alassetData;
}

-(instancetype)init{
    
    if (self=[super init]) {
        isScreenshot=NO;
        [self LoadAlAsset];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LoadAlAssetAgain) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
        
        
    }
    return  self;
}

-(void)LoadAlAssetAgain{
    isScreenshot=YES;
    NSLog(@"******延迟1秒是因为系统存储需要时间 不然取到的并不是最新的图");
    [self performSelector:@selector(LoadAlAsset) withObject:nil afterDelay:1];
    
}
-(void)LoadAlAsset{
    self.dataArray=[NSMutableArray arrayWithCapacity:0];

    ALAssetsLibraryAccessFailureBlock failureblock=^(NSError*error){
        NSLog(@"访问失败%@",[error  localizedDescription]);
        if (![[error localizedDescription] rangeOfString:@"Global denied access"].location!=NSNotFound) {
            NSLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
        }else {
            NSLog(@"相册访问失败.");
        }
    };
    
    ALAssetsLibraryGroupsEnumerationResultsBlock
    libraryGroupsEnumeration = ^(ALAssetsGroup* group,BOOL* stop){
        if (group!=nil) {
            NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
            NSLog(@"gg:%@",g);//gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
            NSString *g1=[g substringFromIndex:16 ] ;
            NSArray *arr=[NSArray arrayWithArray:[g1 componentsSeparatedByString:@","]];
            NSString *g2=[[arr objectAtIndex:0]substringFromIndex:5];
            if ([g2 isEqualToString:@"Camera Roll"]) {
                g2=@"相机胶卷";
            }
            NSString *groupName=g2;//组的name
            NSLog(@"相册名字%@",groupName);
            if ([group numberOfAssets]) {
                NSDictionary*dic=@{groupName:group};
                [self.dataArray addObject:dic ];
            }
            
        }
        else{
            [self ResolveALAssetsGroup];
        }
    };
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:libraryGroupsEnumeration
                         failureBlock:failureblock];
}

-(void)ResolveALAssetsGroup{
    
    NSMutableArray*lastALAsset=[NSMutableArray arrayWithCapacity:0];
    DataManager*manager=[DataManager shareManager];
    [manager.dataArr removeAllObjects];
    [manager.imageArr removeAllObjects];
    for (int i=0; i<self.dataArray.count; i++) {
        NSDictionary*dic=self.dataArray[i];
        NSString*groupName=[[dic  allKeys] firstObject];
        ALAssetsGroup*group=(ALAssetsGroup*) [dic objectForKey:groupName] ;
        
        NSMutableArray*arr1=[NSMutableArray arrayWithCapacity:0];
        NSMutableArray*arr2=[NSMutableArray arrayWithCapacity:0];
        
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result != nil) {
                if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    UIImage*image=[[UIImage alloc]initWithCGImage:result.thumbnail];
                    [arr1 addObject:image];
                    [arr2 addObject:result.defaultRepresentation];
                    if ([groupName isEqualToString:@"相机胶卷"]) {
                        [lastALAsset addObject:result];
                    }
                }
            }
        }];
        [manager.dataArr addObject:@{groupName:arr2}];
        [manager.imageArr addObject:@{groupName:arr1}];
    }
    if (isScreenshot) {
        self.getImage([lastALAsset lastObject]);
        isScreenshot=NO;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ResolveALAssetsGroupOver" object:nil];
   // 通知数据加载完毕
    
  
    
}
@end
