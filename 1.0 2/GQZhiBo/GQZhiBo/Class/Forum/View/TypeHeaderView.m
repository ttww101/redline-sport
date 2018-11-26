//
//  TypeHeaderView.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "TypeHeaderView.h"

@interface TypeHeaderView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) BaseImageView *topIV;
@property (nonatomic, strong) UIView *spaceView;


@end

@implementation TypeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)layoutSubviews {
    self.lineView.frame = CGRectMake(0, self.height - ONE_PX_LINE, self.width, ONE_PX_LINE);
    
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    for (NSInteger i =0; i < _dataSource.count; i++) {
        ItemView *item = [[ItemView alloc]init];
        item.frame = CGRectMake(0, self.topIV.bottom + i * 60, self.width, 60);
        [self addSubview:item];
    }
    
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = UIColorHex(#EBEBEB);
    [self addSubview:self.lineView];
    [self addSubview:self.spaceView];
    [self addSubview:self.topIV];
    
    
}

#pragma mark - Lazy Load

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.backgroundColor = UIColorHex(#eeeeee);
    }
    return _lineView;
}

- (UIView *)spaceView {
    if (_spaceView == nil) {
        _spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topIV.top, self.width, self.topIV.height)];
        _spaceView.backgroundColor = [UIColor whiteColor];
    }
    return _spaceView;
}


- (BaseImageView *)topIV {
    if (_topIV == nil) {
        _topIV = [[BaseImageView alloc]initWithFrame:CGRectMake(0, Scale_Value(135), 20, 20)];
        _topIV.contentMode = UIViewContentModeScaleAspectFit;
        _topIV.clipsToBounds = true;
        _topIV.backgroundColor = [UIColor orangeColor];
    }
    return _topIV;
}

@end