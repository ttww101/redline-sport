//
//  ZBMessageSoundMgr.m
//  GQapp
//
//  Created by Marjoice on 28/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "ZBMessageSoundMgr.h"

@implementation ZBMessageSoundMgr
static ZBMessageSoundMgr *_sharedInstance;
static ZBMessageSoundMgr *_sharedInstanceForSound;

-(id)initForPlayingVibrate {
    
    if(self = [super init]) {
        
        soundID=kSystemSoundID_Vibrate;
    }
    return self;
}

+(id)sharedInstanceForVibrate {
    
    @synchronized ([ZBMessageSoundMgr class]) {
        
        if (_sharedInstance == nil) {
            
            _sharedInstance = [[ZBMessageSoundMgr alloc] initForPlayingVibrate];
            
        }
    }
    return _sharedInstance;
    
}

+ (id) sharedInstanceForSound {

    @synchronized ([ZBMessageSoundMgr class]) {
        
        if (_sharedInstanceForSound == nil) {
            
            _sharedInstanceForSound = [[ZBMessageSoundMgr alloc] init]; //ForPlayingSystemSoundEffectWith:@"sms-received2" ofType:@"caf"
            
        }
    }
    return _sharedInstanceForSound;
}

-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type {

    if(self = [super init]){
        
//        NSString *path=[[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
//        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",resourceName,type];
      
        NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:type];
        if(path){
            
            SystemSoundID theSoundID;
            
            OSStatus error =AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&theSoundID);
            
            if(error == kAudioServicesNoError){
                
                soundID=theSoundID;
            }else{
                
                NSLog(@"Failed to create sound");
                
            }
            
        }
        
    }
    return  self;
}

-(id)initForPlayingSoundEffectWith:(NSString *)filename {

    if(self = [super init]){
        
        NSURL *fileURL=[[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        if(fileURL!=nil){
            
            SystemSoundID theSoundID;
            
            OSStatus error=AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            
            if(error ==kAudioServicesNoError){
                
                soundID=theSoundID;
            }else{
                
                NSLog(@"Failed to create sound");
                
            }
        }
    }
    
    return self;
    
}

-(void)play {

    AudioServicesPlaySystemSound(soundID);
}

-(void)cancleSound {

    _sharedInstance = nil;
    //AudioServicesRemoveSystemSoundCompletion(soundID);
}

@end

