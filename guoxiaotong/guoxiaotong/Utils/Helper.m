//
//  Helper.m
//  guoxiaotong
//
//  Created by zxc on 16/3/21.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "Helper.h"

@implementation Helper

- (instancetype)initForPlayingVibrate {
    if (self = [super init]) {
        soundID = kSystemSoundID_Vibrate;
    }
    return self;
}

- (instancetype)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type {
    if (self = [super init]) {
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
        if (path) {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error == kAudioServicesNoError) {
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound");
            }
        }
    }
    return self;
}

- (instancetype)initForPlayingSoundEffectWith:(NSString *)filename {
    if (self = [super init]) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (fileURL) {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError) {
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound");
            }
        }
    }
    return self;
}

- (void)play {
    AudioServicesPlaySystemSound(soundID);
}

- (void)dealloc {
    AudioServicesDisposeSystemSoundID(soundID);
}

@end
