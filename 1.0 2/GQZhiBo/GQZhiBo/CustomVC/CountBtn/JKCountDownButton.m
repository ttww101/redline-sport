//
//  JKCountDownButton.m
//  JKCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "JKCountDownButton.h"

@implementation JKCountDownButton
#pragma -mark touche action
-(void)addToucheHandler:(TouchedDownBlock)touchHandler{
    _touchedDownBlock = [touchHandler copy];
    [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)touched:(JKCountDownButton*)sender{
    if (_touchedDownBlock) {
        _touchedDownBlock(sender,sender.tag);
    }
}

#pragma -mark count down method
-(void)startWithSecond:(int)totalSecond
{
    _totalSecond = totalSecond;
    _second = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)timerStart:(NSTimer *)theTimer {
     double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    
     _second = _totalSecond - (int)(deltaTime+0.5) ;
//    NSLog(@"_second%.d",_second);
//
//    NSLog(@"deltaTime%.f",deltaTime);
//    NSLog(@"int deltaTime%.d",(int)deltaTime);
//    NSLog(@"%d",(int)(deltaTime+0.5));
    
    
    if (_second< 0.0)
    {
        [self stop];
    }
    else
    {
//        _second--;
        if (_didChangeBlock)
        {
            [self setTitle:_didChangeBlock(self,_second) forState:UIControlStateNormal];
            [self setTitle:_didChangeBlock(self,_second) forState:UIControlStateDisabled];
            [self setAttributedTitle:[Methods withContent:_didChangeBlock(self,_second) WithContColor:color33 WithContentFont:font14 WithText:[NSString stringWithFormat:@"%ds",_second] WithTextColor:redcolor WithTextFont:font14] forState:UIControlStateNormal];
       
        }
        else
        {
            NSString *title = [NSString stringWithFormat:@"%d秒",_second];
            [self setTitle:title forState:UIControlStateNormal];
            [self setTitle:title forState:UIControlStateDisabled];

        }
    }
}

- (void)stop{
    
    [_timer invalidate];
    _second = _totalSecond;
    if (_didFinishedBlock)
    {
        self.enabled = YES;
        [self setAttributedTitle:[Methods withContent:@"重新获取" WithContColor:color33 WithContentFont:font14 WithText:@"" WithTextColor:redcolor WithTextFont:font14] forState:UIControlStateNormal];
        
    }
    else
    {
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        [self setTitle:@"重新获取" forState:UIControlStateDisabled];
        
    }
    
    
    
}
#pragma -mark block
-(void)didChange:(DidChangeBlock)didChangeBlock{
    _didChangeBlock = [didChangeBlock copy];
}
-(void)didFinished:(DidFinishedBlock)didFinishedBlock{
    _didFinishedBlock = [didFinishedBlock copy];
}
@end
