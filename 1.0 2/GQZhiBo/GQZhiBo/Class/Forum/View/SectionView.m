//
//  SectionView.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "SectionView.h"

@implementation SectionView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, Width, 40)];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = [UIColor orangeColor];
}

#pragma mark - Lazy Load

@end
