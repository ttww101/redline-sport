//
//  HeaderControl.h
//  newGQapp
//
//  Created by genglei on 2018/5/29.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderControl : UIControl


@property (nonatomic , copy) NSString *content;

- (instancetype)initWithFrame:(CGRect)frame
                      content:(NSString *)content
                showRightLine:(BOOL)show;

@end
