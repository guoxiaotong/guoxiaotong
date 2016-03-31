//
//  NickNameAndHeadImage.h
//  guoxiaotong
//
//  Created by zxc on 16/3/30.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NickNameAndHeadImage : NSObject

+(instancetype) shareInstance;

- (void)loadUserProfileInBackgroundWithBuddy:(NSArray*)buddyList;

- (NSString*)getNicknameByUserName:(NSString*)username;

@end
