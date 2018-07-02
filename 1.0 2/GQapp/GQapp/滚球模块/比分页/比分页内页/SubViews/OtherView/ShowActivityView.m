//
//  ShowActivityView.m
//  newGQapp
//
//  Created by genglei on 2018/7/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ShowActivityView.h"

@interface ShowActivityView ()



@end

@implementation ShowActivityView

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
