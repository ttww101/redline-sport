//
//  BifenDTTable.m
//  GQapp
//
//  Created by WQ on 2017/6/30.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BifenDTTable.h"

@implementation BifenDTTable

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
/*
同时识别多个手势

@param gestureRecognizer gestureRecognizer description
@param otherGestureRecognizer otherGestureRecognizer description
@return return value description
*/
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
