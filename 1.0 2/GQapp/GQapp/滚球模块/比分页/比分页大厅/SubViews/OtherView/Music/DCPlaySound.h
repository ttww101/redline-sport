//
//  DCPlaySound.h
//  GunQiuLive
//
//  Created by WQ_h on 16/3/4.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface DCPlaySound : NSObject
{
    SystemSoundID soundID;
}
//震动效果
- (id)initWithForPlayingVibrate;
//播放系统的音频文件
- (id)initWithForPlayingSystemSoundEffrctWith:(NSString *)ResourceName ofType:(NSString *)type;
- (id)initWithForPlayingSoundEffectWith:(NSString *)filename ofType:(NSString *)type;
- (void)play;
@end


















