//
//  WithdrawalView.m
//  newGQapp
//
//  Created by genglei on 2018/4/13.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "WithdrawalView.h"

@interface WithdrawalView ()

@property (nonatomic , strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic , strong) UIButton *withdrawalBtn;




@end

@implementation WithdrawalView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, Width, 190)];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
    
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.top.equalTo(self.bgView.mas_top).offset(15);
        
    }];
    
    [self.bgView addSubview:self.withdrawalBtn];
    [self.withdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(112, 54));
    }];
}

#pragma mark - Events

- (void)withdrawalAction:(UIButton *)sender {
    
}

#pragma mark - Lazy Load

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"当前金额";
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = UIColorFromRGBWithOX(0x333333);
    }
    return _titleLabel;
}

- (UIButton *)withdrawalBtn {
    if (_withdrawalBtn == nil) {
        _withdrawalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_withdrawalBtn setImage:[UIImage imageNamed:@"withdrawal"] forState:UIControlStateNormal];
        [_withdrawalBtn addTarget:self action:@selector(withdrawalAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withdrawalBtn;
}

@end
