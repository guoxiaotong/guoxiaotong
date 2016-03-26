//
//  Helper.h
//  guoxiaotong
//
//  Created by zxc on 16/3/21.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Helper : NSObject
{
    SystemSoundID soundID;
}

/**为播放震动效果初始化*/
- (instancetype)initForPlayingVibrate;

/**为播放系统音效初始化(无需提供音频文件)
 resourceName 系统音效名称
 type 系统音效类型*/
- (instancetype)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;

/**为播放特定的音频文件初始化（需提供音频文件）
 filename 音频文件名（加在工程中）*/
- (instancetype)initForPlayingSoundEffectWith:(NSString *)filename;

/**播放音效*/
-(void)play;

@end
