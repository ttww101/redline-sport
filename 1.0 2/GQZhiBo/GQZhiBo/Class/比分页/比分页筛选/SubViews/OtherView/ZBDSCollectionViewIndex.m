#import "ZBDSCollectionViewIndex.h"
#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]
@interface ZBDSCollectionViewIndex(){
    BOOL _isLayedOut;
    CAShapeLayer *_shapeLayer;
    CGFloat _letterHeight;
}
@end
@implementation ZBDSCollectionViewIndex
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)setCollectionDelegate:(id<DSCollectionViewIndexDelegate>)collectionDelegate{
    _collectionDelegate = collectionDelegate;
    _isLayedOut = NO;  
    [self layoutSubviews];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self setup];
    if (!_isLayedOut) {
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        _shapeLayer.frame = CGRectMake(CGPointZero.x, CGPointZero.y, self.layer.frame.size.width, self.layer.frame.size.height);
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointZero];
        [bezierPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
        _letterHeight = self.height/self.titleIndexes.count;
        CGFloat fontSize = 12;
        [self.titleIndexes enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            CGFloat originY = idx * _letterHeight;
            CATextLayer *ctl = [self textLayerWithSize:fontSize
                                                string:obj
                                              andFrame:CGRectMake(0, originY, self.frame.size.width, _letterHeight)];
            [self.layer addSublayer:ctl];
            [bezierPath moveToPoint:CGPointMake(0, originY)];
            [bezierPath addLineToPoint:CGPointMake(ctl.frame.size.width, originY)];
        }];
        _shapeLayer.path = bezierPath.CGPath;
        if(_isFrameLayer){
            [self.layer addSublayer:_shapeLayer];
        }
        _isLayedOut = YES;
    }
}
#pragma mark- 私有方法
-(void)setup{
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.lineWidth = 1.0f;
    _shapeLayer.fillColor = [UIColor blackColor].CGColor;
    _shapeLayer.lineJoin = kCALineCapSquare;
    _shapeLayer.strokeColor = [[UIColor blackColor] CGColor];
    _shapeLayer.strokeEnd = 1.0f;
    self.layer.masksToBounds = NO;
}
- (CATextLayer*)textLayerWithSize:(CGFloat)size string:(NSString*)string andFrame:(CGRect)frame{
    CATextLayer *tl = [CATextLayer layer];
    [tl setFont:@"ArialMT"];
    [tl setFontSize:size];
    [tl setFrame:frame];
    [tl setAlignmentMode:kCAAlignmentCenter];
    [tl setContentsScale:[[UIScreen mainScreen] scale]];
    [tl setForegroundColor:color33.CGColor];
    [tl setString:string];
    return tl;
}
- (void)sendEventToDelegate:(UIEvent*)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    NSInteger indx = ((NSInteger) floorf(point.y) / _letterHeight);
    if (indx< 0 || indx > self.titleIndexes.count - 1) {
        return;
    }
    [self.collectionDelegate collectionViewIndex:self didselectionAtIndex:indx withTitle:self.titleIndexes[indx]];
}
#pragma mark- response事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self sendEventToDelegate:event];
    [self.collectionDelegate collectionViewIndexTouchesBegan:self];
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self sendEventToDelegate:event];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.collectionDelegate collectionViewIndexTouchesEnd:self];
}
@end
