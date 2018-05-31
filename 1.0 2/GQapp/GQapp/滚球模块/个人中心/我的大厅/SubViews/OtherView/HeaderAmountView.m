//
//  HeaderAmountView.m
//  newGQapp
//
//  Created by genglei on 2018/4/27.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "HeaderAmountView.h"
#import "ToolWebViewController.h"
#import "ItemControl.h"

@interface HeaderAmountView ()

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *verticalView;

@property (nonatomic, strong) UILabel *amauntLabel;

@property (nonatomic , strong) UIButton *buyBtn;

@property (nonatomic, strong) UIButton *myIncomeBtn;

@property (nonatomic, strong) UIImageView *rightArrorImageView;

@property (nonatomic, strong) UIControl *control;

@end

@implementation HeaderAmountView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - Open Method

- (void)setModel:(UserModel *)model {
    _model = model;
//    NSString *amount = [_model.coin stringValue];
//    if (!amount) {
//        amount = @"0";
//    }
//    NSString *text = [NSString stringWithFormat:@"我的金币 %@",PARAM_IS_NIL_ERROR(amount)];
//    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:text];
//    [att addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:16] range:[text rangeOfString:@"我的金币"]];
//    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBWithOX(0x333333) range:[text rangeOfString:@"我的金币"]];
//    [att addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Semibold" size:16] range:[text rangeOfString:PARAM_IS_NIL_ERROR(amount)]];
//    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBWithOX(0xDB2D21) range:[text rangeOfString:PARAM_IS_NIL_ERROR(amount)]];
//    _amauntLabel.attributedText = att;
    
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    NSArray *itemArray = @[
                           @{
                               @"icon":@"income",
                               @"title":@"收入"
                             },
                           @{
                               @"icon":@"gold",
                               @"title":@"金币"
                            },
                           @{
                               @"icon":@"gift",
                               @"title":@"红包"
                               
                            },
                           @{
                               @"icon":@"Coupons",
                               @"title":@"优惠券"
                            }
                           ];
    
    [self removeAllSubViews];
    
    CGFloat itemWidth = self.width / itemArray.count;
    for (NSInteger i = 0; i < itemArray.count; i ++) {
        NSDictionary *dic = itemArray[i];
        ItemControl *control = [[ItemControl alloc]initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, self.height) imageName:dic[@"icon"] title:dic[@"title"]];
        control.tag = i;
        [control addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
    }
    
    
//    [self addSubview:self.lineView];
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left);
//        make.right.equalTo(self.mas_right);
//        make.centerY.equalTo(self.mas_centerY);
//        make.height.mas_equalTo(0.5);
//    }];
//
//    [self addSubview:self.verticalView];
//    [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top);
//        make.centerX.equalTo(self.mas_centerX);
//        make.bottom.equalTo(self.lineView.mas_top);
//        make.width.mas_equalTo(0.5);
//    }];
//
//    [self addSubview:self.amauntLabel];
//    [self.amauntLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(20);
//        make.top.equalTo(self.mas_top).offset(15);
//    }];
//
//    [self addSubview:self.control];
//    [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.amauntLabel);
//    }];
//
//    [self addSubview:self.buyBtn];
//    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        CGFloat right = (self.width / 2.f - 84) / 2;
//        make.size.mas_equalTo(CGSizeMake(84, 40));
//        make.top.equalTo(self.mas_top).offset(10);
//        make.right.equalTo(self.mas_right).offset(-right);
//    }];
//
//    [self addSubview:self.myIncomeBtn];
//    [self.myIncomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(15);
//        make.bottom.equalTo(self.mas_bottom).offset(0);
//        make.right.equalTo(self.mas_right).offset(0);
//        make.height.mas_equalTo(52);
//    }];
//
//    [self addSubview:self.rightArrorImageView];
//    [self.rightArrorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.myIncomeBtn.mas_centerY);
//        make.right.equalTo(self.mas_right).offset(-15);
//        make.size.mas_equalTo(CGSizeMake(7, 14));
//    }];
}

#pragma mark - Events


- (void)controlAction:(ItemControl *)senter {
    switch (senter.tag) {
        case 0: {
            [self myIncomeAction];
        }
            break;
            
        case 1:{
            [self myGold];
        }
            break;
        case 2: {
            [self myGift];
        }
            break;
            
        case 3: {
            [self myCoupon];
        }
            break;
            
        default:
            break;
    }
}

- (void)myIncomeAction {
    WebModel *model = [[WebModel alloc]init];
    model.title = @"收入";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/my-earnings.html", APPDELEGATE.url_ip,H5_Host];
    ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

- (void)myGift {
    WebModel *model = [[WebModel alloc]init];
    model.title = @"红包";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/my-redbag.html", APPDELEGATE.url_ip,H5_Host];
    ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

- (void)myGold {
    WebModel *model = [[WebModel alloc]init];
    model.title = @"滚球币";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/my-gold.html", APPDELEGATE.url_ip,H5_Host];
    ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

- (void)myCoupon {
    WebModel *model = [[WebModel alloc]init];
    model.title = @"优惠券";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/pay-card.html", APPDELEGATE.url_ip,H5_Host];
    ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

#pragma mark - Lazy Load

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColorFromRGBWithOX(0xe2e2e2);
    }
    return _lineView;
}

- (UIView *)verticalView {
    if (_verticalView == nil) {
        _verticalView = [UIView new];
        _verticalView.backgroundColor = UIColorFromRGBWithOX(0xe2e2e2);
    }
    return _verticalView;
}

- (UILabel *)amauntLabel {
    if (_amauntLabel == nil) {
        _amauntLabel = [UILabel new];
    }
    return _amauntLabel;
}

- (UIControl *)control {
    if (_control == nil) {
        _control = [[UIControl alloc]init];
        [_control addTarget:self action:@selector(myGold) forControlEvents:UIControlEventTouchUpInside];
    }
    return _control;
}

- (UIButton *)buyBtn {
    if (_buyBtn == nil) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setBackgroundImage:[UIImage imageNamed:@"buybtn"] forState:UIControlStateNormal];
    }
    return _buyBtn;
}

- (UIButton *)myIncomeBtn {
    if (_myIncomeBtn == nil) {
        _myIncomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_myIncomeBtn setTitle:@"我的收入" forState:UIControlStateNormal];
        [_myIncomeBtn setTitleColor:UIColorFromRGBWithOX(0x333333) forState:UIControlStateNormal];
        _myIncomeBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        _myIncomeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_myIncomeBtn addTarget:self action:@selector(myIncomeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myIncomeBtn;
}

- (UIImageView *)rightArrorImageView {
    if (_rightArrorImageView == nil) {
        _rightArrorImageView = [UIImageView new];
        _rightArrorImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightArrorImageView.image = [UIImage imageNamed:@"meRight"];
    }
    return _rightArrorImageView;
}

@end
