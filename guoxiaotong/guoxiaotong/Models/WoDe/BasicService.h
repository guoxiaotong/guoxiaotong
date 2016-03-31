//
//  BasicService.h
//  guoxiaotong
//
//  Created by zxc on 16/3/21.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicService : NSObject

- (instancetype)initWithView:(UIView *)view;

/**获取联系人列表*/
- (void)getContect:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess, NSArray *roleList))callBack;

/**获取收藏动态列表()*/
- (void)getCollectTrendList:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess, NSArray *trendList))callBack;

/**获取收藏图片列表*/
- (void)getCollectImageList:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess, NSArray *imageList))callBack;

/**通过城市获取学校*/
- (void)getSchoolListWithCityName:(NSString *)cityName callBack:(void (^)(BOOL isSuccess, NSArray *schoolList))callBack;

/**通过学校获取年级*/
- (void)getGradeListWithSchoolId:(NSString *)schoolId callBack:(void (^)(BOOL isSuccess, NSArray *gradeList))callBack;

///**通过年级获取班级*/
//- (void)getClassListWithCityName:(NSString *)cityName callBack:(void (^)(BOOL isSuccess, NSArray *schoolList))callBack;


/**获取关系列表*/
- (void)getRelationListCallBack:(void (^)(BOOL isSuccess, NSArray *relationList))callBack;

/**添加子女*/
- (void)addChild:(NSDictionary *)params callBack:(void (^)(NSInteger code, NSString *msg))callBack;

/**申请校长*/
- (void)applyForHeader:(NSDictionary *)params callBack:(void (^)(BOOL isSuccess))callBack;

/**上传图片*/
- (void)uploadImage:(NSData *)imageFile callBack:(void (^)(BOOL isSuccess, NSString *picPath))callBack;

/**做任务*/
- (void)doTask:(NSString *)type callBack:(void (^)(NSInteger code, NSString *msg, NSString *reward, NSString *totalPoint, NSString *lastDay))callBack;

/**获取已做任务列表*/
- (void)getTaskDidListCallBack:(void (^)(NSInteger code, NSArray *taskList))callBack;

/**通过loginName获取用户信息*/
- (void)getUserInfo:(NSString *)loginName callBack:(void (^)(BOOL isSuccess, UserInfoModel *userInfo))callBack;

@end
