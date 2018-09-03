//
//  DCPlaySound.m
//  GunQiuLive
//
//  Created by WQ_h on 16/3/4.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "DCPlaySound.h"

@implementation DCPlaySound
- (id)initWithForPlayingVibrate
{
    self = [super init];
    if (self) {
        soundID = kSystemSoundID_Vibrate;

    }
    return self;
}
//播放系统的音频文件
- (id)initWithForPlayingSystemSoundEffrctWith:(NSString *)ResourceName ofType:(NSString *)type
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:ResourceName ofType:type];
        if (path) {
            SystemSoundID theSoundId;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundId);
            if (error == kAudioServicesNoError) {
                soundID = theSoundId;
            }else{
                NSLog(@"不能创建音频播放文件");
            }
        }
    }
    return self;
}

- (id)initWithForPlayingSoundEffectWith:(NSString *)filename ofType:(NSString *)type
{
    self = [super init];
    if (self) {
//        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"music2" ofType:@"wav"];

        if (path) {
            SystemSoundID theSoundId;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundId);
            if (error == kAudioServicesNoError) {
                soundID = theSoundId;
//                AudioServicesPlaySystemSound(theSoundId);
            }else{
                NSLog(@"不能创建音频播放文件");

            }
        }
    }
    return self;
}

- (void)play
{
    AudioServicesPlayAlertSound(soundID);
}
- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(soundID);
}














@end
