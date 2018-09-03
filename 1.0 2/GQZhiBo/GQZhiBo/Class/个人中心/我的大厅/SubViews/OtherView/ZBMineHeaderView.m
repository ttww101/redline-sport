#import "ZBMineHeaderView.h"
#import "ZBHeaderAmountView.h"
#import "ZBToAnalystsVC.h"
#import "ZBToolWebViewController.h"
#import "ZBMyProfileVC.h"
#import "ZBHeaderControl.h"
#import "ZBUserTuijianVC.h"
@interface ZBMineHeaderView ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic , strong) UIButton *messageBtn;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIImageView *levealImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *rightArrorImageView;
@property (nonatomic , strong) UIButton *applyBtn;
@property (nonatomic , strong) ZBHeaderAmountView *amountView;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIControl *control;
@property (nonatomic , strong) ZBHeaderControl *leftControl;
@property (nonatomic , strong) ZBHeaderControl *centerControl;
@property (nonatomic , strong) ZBHeaderControl *rightControl;
@property (nonatomic, assign) CGFloat controlWidth;
@end
static CGFloat imageHeight = 50;
@implementation ZBMineHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
- (void)setModel:(ZBUserModel *)model {
    _model = model;
    if (_model) {
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:@"defaultPic"]];
        NSString *name = _model.nickname;
        if (name.length >= 8) {
            NSString *str = [name substringToIndex:8];
            name = [NSString stringWithFormat:@"%@...",str];
        }
        NSDictionary *dic = _model.userDetail;
        NSString *text = [NSString stringWithFormat:@"%@| %@", name ,dic[@"levelName"]];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:text];
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:[text rangeOfString:name]];
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.f] range:[text rangeOfString:dic[@"levelName"]]];
        _nameLabel.attributedText = att;
        NSString *imageName = [ZBMethods getPersonLeavelImageName:_model.analysttype];
        self.levealImageView.image = [UIImage imageNamed:imageName];
        if (_model.analyst == 1) {
            self.applyBtn.hidden = YES;
        } else {
            self.applyBtn.hidden = false;
        }
        [self addSubview:self.amountView];
        _amountView.model = _model;
        self.desLabel.hidden = YES;
        self.control.hidden = YES;
        self.leftControl.content = [NSString stringWithFormat:@"推荐:%zi",_model.recommendCount];
        self.centerControl.content = [NSString stringWithFormat:@"关注:%zi",_model.focusCount];
        self.rightControl.content = [NSString stringWithFormat:@"粉丝:%zi",_model.followerCount];
        self.leftControl.hidden = false;
        self.centerControl.hidden = false;
        self.rightControl.hidden = false;
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
        self.leftControl.hidden = YES;
        self.centerControl.hidden = YES;
        self.rightControl.hidden = YES;
    }
}
#pragma mark - Config UI
- (void)configUI {
    self.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    self.controlWidth = Width / 3.f;
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(200);
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
    [self.bgImageView addSubview:self.levealImageView];
    [self.levealImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_top).offset(95);
        make.left.equalTo(self.bgImageView.mas_left).offset(45);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [self.bgImageView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_top);
        make.left.equalTo(self.avatarImageView.mas_right).offset(15);
        make.right.equalTo(self.bgImageView.mas_right).offset(-10);
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
    [self addSubview:self.leftControl];
    [self addSubview:self.centerControl];
    [self addSubview:self.rightControl];
}
#pragma mark - Events
- (void)applyAction {
    [[ZBDependetNetMethods sharedInstance] loadUserInfocompletion:^(ZBUserModel *userback) {
        ZBUserModel *model = [ZBMethods getUserModel];
        ZBToAnalystsVC *analysts = [[ZBToAnalystsVC alloc] init];
        analysts.hidesBottomBarWhenPushed = YES;
        analysts.type = model.analyst;
        analysts.model = model;
        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
    } errorMessage:^(NSString *msg) {
        ZBUserModel *model = [ZBMethods getUserModel];
        ZBToAnalystsVC *analysts = [[ZBToAnalystsVC alloc] init];
        analysts.hidesBottomBarWhenPushed = YES;
        analysts.type = model.analyst;
        analysts.model = model;
        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
    }];
}
- (void)pushMessageAction {
    if(![ZBMethods login]) {
        [ZBMethods toLogin];
        return;
    }
    ZBWebModel *model = [[ZBWebModel alloc]init];
    model.title = @"消息";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/message.html", APPDELEGATE.url_ip,H5_Host];
    ZBToolWebViewController *webDetailVC = [[ZBToolWebViewController alloc] init];
    model.hideNavigationBar = YES;
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}
- (void)avatarClick {
    if ([ZBMethods login]) {
        ZBMyProfileVC *myProfile = [[ZBMyProfileVC alloc] init];
        myProfile.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:myProfile animated:YES];
    }else{
        [ZBMethods toLogin];
    }
}
- (void)personInfoAction {
    [self avatarClick];
}
- (void)controlAction {
    if (![ZBMethods login]) {
        [ZBMethods toLogin];
    }
}
- (void)leftControlAction {
    if(![ZBMethods login]) {
        [ZBMethods toLogin];
        return;
    }
    ZBUserTuijianVC *tuijian = [[ZBUserTuijianVC alloc] init];
    tuijian.userName = _model.nickname;
    tuijian.userId = _model.idId;
    tuijian.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:tuijian animated:YES];
}
- (void)centerControlAction {
    if(![ZBMethods login]) {
        [ZBMethods toLogin];
        return;
    }
    ZBFriendsVC *friend = [[ZBFriendsVC alloc] init];
    friend.userId = _model.idId;
    friend.selectedIndex = 0;
    friend.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
}
- (void)rightControlAction {
    if(![ZBMethods login]) {
        [ZBMethods toLogin];
        return;
    }
    ZBFriendsVC *friend = [[ZBFriendsVC alloc] init];
    friend.userId = _model.idId;
    friend.selectedIndex = 1;
    friend.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:friend animated:YES];
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
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}
- (UIImageView *)rightArrorImageView {
    if (_rightArrorImageView == nil) {
        _rightArrorImageView = [UIImageView new];
        _rightArrorImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightArrorImageView.image = [UIImage imageNamed:@"goto"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personInfoAction)];
        [_rightArrorImageView addGestureRecognizer:tap];
        _rightArrorImageView.userInteractionEnabled = YES;
    }
    return _rightArrorImageView;
}
- (ZBHeaderAmountView *)amountView {
    if (_amountView == nil) {
        _amountView = [[ZBHeaderAmountView alloc]initWithFrame:CGRectMake(15, 165, Width - 30, 60)];
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
- (UIImageView *)levealImageView {
    if (_levealImageView == nil) {
        _levealImageView = [UIImageView new];
    }
    return _levealImageView;
}
- (ZBHeaderControl *)leftControl {
    if (_leftControl == nil) {
        _leftControl = [[ZBHeaderControl alloc]initWithFrame:CGRectMake(0, 130, self.controlWidth, 30) content:@"推荐:0" showRightLine:false];
        [_leftControl addTarget:self action:@selector(leftControlAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftControl;
}
- (ZBHeaderControl *)centerControl {
    if (_centerControl == nil) {
        _centerControl = [[ZBHeaderControl alloc]initWithFrame:CGRectMake(self.controlWidth, 130, self.controlWidth, 30) content:@"关注:0" showRightLine:false];
        [_centerControl addTarget:self action:@selector(centerControlAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerControl;
}
- (ZBHeaderControl *)rightControl {
    if (_rightControl == nil) {
        _rightControl = [[ZBHeaderControl alloc]initWithFrame:CGRectMake(self.controlWidth * 2, 130, self.controlWidth, 30) content:@"粉丝:0" showRightLine:YES];
        [_rightControl addTarget:self action:@selector(rightControlAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightControl;
}
@end
