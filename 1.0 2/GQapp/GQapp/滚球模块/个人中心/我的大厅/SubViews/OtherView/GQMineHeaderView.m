//
//  GQMineHeaderView.m
//  newGQapp
//
//  Created by genglei on 2018/4/27.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "GQMineHeaderView.h"
#import "HeaderAmountView.h"
#import "ToAnalystsVC.h"
#import "ToolWebViewController.h"
#import "MyProfileVC.h"


@interface GQMineHeaderView ()

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic , strong) UIButton *messageBtn;

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIImageView *rightArrorImageView;

@property (nonatomic , strong) UIButton *applyBtn;

@property (nonatomic , strong) HeaderAmountView *amountView;

@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UIControl *control;



@end

static CGFloat imageHeight = 50;


@implementation GQMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

#pragma mark - Open Method

- (void)setModel:(UserModel *)model {
    _model = model;
    if (_model) {
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:@"defaultPic"]];
        self.nameLabel.text = _model.nickname;
        if (_model.analyst == 1) {
            self.applyBtn.hidden = YES;
        } else {
            self.applyBtn.hidden = false;
        }
        [self addSubview:self.amountView];
        _amountView.model = _model;
        self.desLabel.hidden = YES;
        self.control.hidden = YES;
    } else {
        self.avatarImageView.image = [UIImage imageNamed:@"defaultPic"];
        self.nameLabel.text = @"登陆/注册";
        self.desLabel.hidden = false;
        self.applyBtn.hidden = YES;
        self.control.hidden = false;
        if (_amountView) {
            [_amountView removeFromSuperview];
            _amountView = nil;
        }
    }
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(173);
    }];
    
    [self.bgImageView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_top).offset(30);
        make.centerX.equalTo(self.bgImageView.mas_centerX);
    }];
    
    [self.bgImageView addSubview:self.messageBtn];
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.equalTo(self.bgImageView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(15, 16));
    }];
    
    [self.bgImageView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_top).offset(60);
        make.left.equalTo(self.bgImageView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
    }];
    
    [self.bgImageView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_top);
        make.left.equalTo(self.avatarImageView.mas_right).offset(15);
    }];
    
    [self.bgImageView addSubview:self.control];
    [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.nameLabel);
    }];
    
    [self.bgImageView addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(68, 20));
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
    }];
    
    [self.bgImageView addSubview:self.rightArrorImageView];
    [self.rightArrorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatarImageView.mas_centerY);
        make.right.equalTo(self.bgImageView.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(11, 20));
    }];
    
    [self.bgImageView addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
    }];

}

#pragma mark - Events

- (void)applyAction {
    [[DependetNetMethods sharedInstance] loadUserInfocompletion:^(UserModel *userback) {
        UserModel *model = [Methods getUserModel];
        ToAnalystsVC *analysts = [[ToAnalystsVC alloc] init];
        analysts.hidesBottomBarWhenPushed = YES;
        analysts.type = model.analyst;
        analysts.model = model;
        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
    } errorMessage:^(NSString *msg) {
        UserModel *model = [Methods getUserModel];
        ToAnalystsVC *analysts = [[ToAnalystsVC alloc] init];
        analysts.hidesBottomBarWhenPushed = YES;
        analysts.type = model.analyst;
        analysts.model = model;
        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
    }];
}

- (void)pushMessageAction {
    if(![Methods login]) {
        [Methods toLogin];
        return;
    }
    WebModel *model = [[WebModel alloc]init];
    model.title = @"消息";
    model.webUrl = [NSString stringWithFormat:@"%@:81/appH5/message.html", APPDELEGATE.url_jsonHeader];
    ToolWebViewController *webDetailVC = [[ToolWebViewController alloc] init];
    model.hideNavigationBar = YES;
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

- (void)avatarClick {
    if ([Methods login]) {
        MyProfileVC *myProfile = [[MyProfileVC alloc] init];
        myProfile.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:myProfile animated:YES];
        
    }else{
        [Methods toLogin];
    }

}

- (void)controlAction {
    if (![Methods login]) {
        [Methods toLogin];
    }
}

#pragma mark - Lazy Load

- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [UIImageView new];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.image = [UIImage imageNamed:@"headerbg"];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.textColor = UIColorFromRGBWithOX(0xffffff);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"我的";
    }
    return _titleLabel;
}

- (UIButton *)messageBtn {
    if (_messageBtn == nil) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn setBackgroundImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        [_messageBtn addTarget:self action:@selector(pushMessageAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

- (UIButton *)applyBtn {
    if (_applyBtn == nil) {
        _applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_applyBtn setBackgroundImage:[UIImage imageNamed:@"applyBtn"] forState:UIControlStateNormal];
        [_applyBtn addTarget: self action:@selector(applyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyBtn;
}


- (UIImageView *)avatarImageView {
    if (_avatarImageView == nil) {
        _avatarImageView = [UIImageView new];
        _avatarImageView.backgroundColor = [UIColor orangeColor];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.layer.cornerRadius = imageHeight / 2.f;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.borderWidth = 0.5;
        _avatarImageView.layer.borderColor = UIColorFromRGBWithOX(0xffffff).CGColor;
        [_avatarImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClick)]];
        _avatarImageView.backgroundColor = [UIColor orangeColor];
        _avatarImageView.userInteractionEnabled = YES;
        
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:18.f];;
        _nameLabel.textColor = UIColorFromRGBWithOX(0xffffff);
        _nameLabel.text = @"你的名字";
    }
    return _nameLabel;
}

- (UIImageView *)rightArrorImageView {
    if (_rightArrorImageView == nil) {
        _rightArrorImageView = [UIImageView new];
        _rightArrorImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightArrorImageView.image = [UIImage imageNamed:@"goto"];
    }
    return _rightArrorImageView;
}

- (HeaderAmountView *)amountView {
    if (_amountView == nil) {
        _amountView = [[HeaderAmountView alloc]initWithFrame:CGRectMake(15, 137, Width - 30, 105)];
    }
    return _amountView;
}

- (UILabel *)desLabel {
    if (_desLabel == nil) {
        _desLabel = [UILabel new];
        _desLabel.font = [UIFont systemFontOfSize:14.f];;
        _desLabel.textColor = UIColorFromRGBWithOX(0xffffff);
        _desLabel.text = @"马上登录，获取更多的信息和福利";
        _desLabel.hidden = YES;
    }
    return _desLabel;
}

- (UIControl *)control {
    if (_control == nil) {
        _control = [[UIControl alloc]init];
        [_control addTarget:self action:@selector(controlAction) forControlEvents:UIControlEventTouchUpInside];
        _control.hidden = YES;
    }
    return _control;
}

@end
