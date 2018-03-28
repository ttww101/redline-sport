//
//  BisaiTJRoundView.m
//  GQapp
//
//  Created by WQ on 2017/8/14.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BisaiTJRoundView.h"

@implementation BisaiTJRoundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //画布
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    //填充颜色
    //    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    //    //线条颜色
    //    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    //    CGContextSetLineWidth(context, 1);
    //    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    //    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    //    CGContextAddArc(context, 100, 20, 15, 0, M_PI*2, 0);
    //    CGContextDrawPath(context, kCGPathStroke);
    
    [self setClearsContextBeforeDrawing:YES];
            
        
        CGFloat persent = _roundData;
        if (persent<0) {
            persent = 0;
        }else if(persent >100){
            persent = 100;
        }else if (persent<1){
            persent = 1;
        }
        
        CGFloat startAngle1 = persent/100*M_PI*2;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        //红色
        //线条颜色
        CGContextSetStrokeColorWithColor(context, colorEE.CGColor);
        //填充颜色
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, 3.0);
        CGContextAddArc(context, self.width/2,self.height/2, self.width/2-2, 0, startAngle1, 0);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        //灰色
        CGContextSetStrokeColorWithColor(context, redcolor.CGColor);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, 3.0);
        CGContextAddArc(context, self.width/2,self.height/2, self.width/2-2, startAngle1, M_PI*2, 0);
        CGContextDrawPath(context, kCGPathStroke);
        
        
        
    
    self.transform = CGAffineTransformMakeRotation(-M_PI/2);
}


@end
