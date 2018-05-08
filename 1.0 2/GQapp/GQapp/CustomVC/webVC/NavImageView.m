//
//  NavImageView.m
//  newGQapp
//
//  Created by genglei on 2018/5/7.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "NavImageView.h"

@implementation NavImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

@end
