#import <UIKit/UIKit.h>
@class ZBJKCountDownButton;
typedef NSString* (^DidChangeBlock)(ZBJKCountDownButton *countDownButton,int second);
typedef NSString* (^DidFinishedBlock)(ZBJKCountDownButton *countDownButton,int second);
typedef void (^TouchedDownBlock)(ZBJKCountDownButton *countDownButton,NSInteger tag);
@interface ZBJKCountDownButton : UIButton
{
    int _second;
    int _totalSecond;
    NSTimer *_timer;
    NSDate *_startDate;
    DidChangeBlock _didChangeBlock;
    DidFinishedBlock _didFinishedBlock;
    TouchedDownBlock _touchedDownBlock;
}
-(void)addToucheHandler:(TouchedDownBlock)touchHandler;
-(void)didChange:(DidChangeBlock)didChangeBlock;
-(void)didFinished:(DidFinishedBlock)didFinishedBlock;
-(void)startWithSecond:(int)second;
- (void)stop;
@end
