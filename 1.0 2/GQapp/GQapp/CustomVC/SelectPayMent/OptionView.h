//
//  OptionView.h
//  newGQapp
//
//  Created by genglei on 2018/4/16.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const PayMentLeftIcon;

UIKIT_EXTERN NSString *const PayMentTitle;

UIKIT_EXTERN NSString *const PayMentType;

@protocol OptionViewDelegate;

@interface OptionView : UIView

@property (nonatomic, weak) id <OptionViewDelegate> deleate;

- (instancetype)initWithFrame:(CGRect)frame  configDictionary:(NSDictionary *)dic;

- (void)hideBottormLine;

@end

@protocol OptionViewDelegate <NSObject>

- (void)didSelectAction:(UIButton *)sender;

@end
