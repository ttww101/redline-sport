//
//  ItemView.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ItemView.h"


@interface ItemView ()

@property (nonatomic, strong) UIView *lineView;


@end

@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, Width, 60)];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    [self addSubview:self.lineView];
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Lazy Load

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - ONE_PX_LINE, self.width, ONE_PX_LINE)];
        _lineView.backgroundColor = UIColorHex(#eeeeee);
    }
    return _lineView;
}


@end
