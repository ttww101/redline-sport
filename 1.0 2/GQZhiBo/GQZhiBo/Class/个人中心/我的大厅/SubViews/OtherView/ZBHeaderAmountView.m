#import "ZBHeaderAmountView.h"
#import "ZBToolWebViewController.h"
#import "ZBItemControl.h"
@interface ZBHeaderAmountView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *verticalView;
@property (nonatomic, strong) UILabel *amauntLabel;
@property (nonatomic , strong) UIButton *buyBtn;
@property (nonatomic, strong) UIButton *myIncomeBtn;
@property (nonatomic, strong) UIImageView *rightArrorImageView;
@property (nonatomic, strong) UIControl *control;
@property (nonatomic , strong) UIButton *rechargeBtn;
@end
@implementation ZBHeaderAmountView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
- (void)setModel:(ZBUserModel *)model {
    _model = model;
    NSArray *itemArray = @[
                           @{
                               @"icon":@"income",
                               @"title":@"滚球币"
                               },
                           @{
                               @"icon":@"gold",
                               @"title":@"红包"
                               }
                           ];
    [self removeAllSubViews];
    NSString *str = @"";
    CGFloat itemWidth = self.width / (itemArray.count + 1);
    for (NSInteger i = 0; i < itemArray.count; i ++) {
        NSDictionary *dic = itemArray[i];
        if (i == 0) {
            NSString *amount = [_model.coin stringValue];
                if (!amount) {
                    amount = @"0";
                }
            str = amount;
        } else if (i == 1) {
            str = [NSString stringWithFormat:@"%@(元)",_model.redpackage ? _model.redpackage : @"0"];
        }
        ZBItemControl *control  = [[ZBItemControl alloc]initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, self.height) imageName:dic[@"icon"] title:dic[@"title"] amount:str];
        control.tag = i;
        [control addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
    }
    [self addSubview:self.rechargeBtn];
    CGFloat rightSpace = (itemWidth - 66) / 2;
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-rightSpace);
        make.size.mas_equalTo(CGSizeMake(66, 38));
    }];
}
#pragma mark - Config UI
- (void)configUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}
#pragma mark - Events
- (void)controlAction:(ZBItemControl *)senter {
    switch (senter.tag) {
        case 0: {
            [self myGold];
        }
            break;
        case 1:{
            [self myGift];
        }
            break;
        case 2: {
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
    ZBWebModel *model = [[ZBWebModel alloc]init];
    model.title = @"我的收入";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/my-earnings.html", APPDELEGATE.url_ip,H5_Host];
    ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}
- (void)myGift {
    [MobClick event:@"hongbao" label:@""];
    ZBWebModel *model = [[ZBWebModel alloc]init];
    model.title = @"我的红包";
    model.hideNavigationBar = YES;
    model.webUrl = [NSString stringWithFormat:@"%@/%@/my-redbag.html", APPDELEGATE.url_ip,H5_Host];
    ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}
- (void)myGold {
    [MobClick event:@"gqb" label:@""];
    ZBWebModel *model = [[ZBWebModel alloc]init];
    model.title = @"我的滚球币";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/my-gold.html", APPDELEGATE.url_ip,H5_Host];
    model.hideNavigationBar = YES;
    ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}
- (void)myCoupon {
    ZBWebModel *model = [[ZBWebModel alloc]init];
    model.title = @"我的优惠券";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/pay-card.html", APPDELEGATE.url_ip,H5_Host];
    ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}
- (void)rechargeAction {
    [MobClick event:@"chongzhi" label:@""];
    ZBWebModel *model = [[ZBWebModel alloc]init];
    model.title = @"充值";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/buy-gold.html", APPDELEGATE.url_ip,H5_Host];
    ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
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
- (UIButton *)rechargeBtn {
    if (_rechargeBtn == nil) {
        _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rechargeBtn setBackgroundImage:[UIImage imageNamed:@"recharge"] forState:UIControlStateNormal];
        [_rechargeBtn addTarget:self action:@selector(rechargeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeBtn;
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
