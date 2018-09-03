//
//  ZBShowActivityView.m
//  newGQapp
//
//  Created by genglei on 2018/7/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ZBShowActivityView.h"

@interface ZBShowActivityView ()



@end

@implementation ZBShowActivityView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = [UIColor orangeColor];
}

@end
