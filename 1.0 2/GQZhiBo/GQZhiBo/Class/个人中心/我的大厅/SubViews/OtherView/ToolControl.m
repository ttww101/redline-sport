//
//  ToolControl.m
//  GQZhiBo
//
//  Created by genglei on 2019/1/20.
//  Copyright © 2019年 GQXX. All rights reserved.
//

#import "ToolControl.h"

@interface ToolControl ()


@end

@implementation ToolControl {
    
}

- (instancetype)initWithFrame:(CGRect)frame itemDic:(NSDictionary *)dic {
    self = [super initWithFrame:frame];
    if (self) {
        BaseImageView *icon = [[BaseImageView alloc]initWithImage:[UIImage imageNamed:dic[@"icon"]]];
        icon.layer.masksToBounds = true;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(8);
        }];
        
        UILabel *lab = [UILabel new];
        lab.attributedText = dic[@"title"];
        [self addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_bottom).offset(-13);
        }];
    }
    return  self;
}

@end
