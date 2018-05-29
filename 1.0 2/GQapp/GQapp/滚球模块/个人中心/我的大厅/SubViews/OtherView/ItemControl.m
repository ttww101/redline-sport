//
//  ItemControl.m
//  newGQapp
//
//  Created by genglei on 2018/5/29.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ItemControl.h"

@implementation ItemControl {
    NSString *_imageName;
    NSString *_title;
}

- (instancetype)initWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
                        title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        _imageName = [imageName copy];
        _title = [title copy];
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = [UIImage imageNamed:_imageName];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(18, 22));
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = _title;
        label.font = font12;
        label.textColor = UIColorFromRGBWithOX(0x323232);
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImageView.mas_bottom).offset(5);
            make.centerX.equalTo(self.mas_centerX);
        }];
    }
    return self;
}

@end
