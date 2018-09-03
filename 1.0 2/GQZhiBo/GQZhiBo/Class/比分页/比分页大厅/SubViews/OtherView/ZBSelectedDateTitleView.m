#import "ZBSelectedDateTitleView.h"
@interface ZBSelectedDateTitleView()
@property (nonatomic, strong) UIButton *btnDate;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIView *viewline;
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation ZBSelectedDateTitleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentIndex = 0;
        _btnDate = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDate.tag = 1;
        _btnDate.titleLabel.font = font12;
        [_btnDate setTitleColor:color33 forState:UIControlStateNormal];
        [_btnDate setTitleColor:color33 forState:UIControlStateHighlighted];
        [self addSubview:_btnDate];
        [_btnDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.centerX.equalTo(self.mas_centerX).offset(-11);
            make.width.mas_equalTo(Width/2);
            make.height.mas_equalTo(self.mas_height);
        }];
        _btnLeft  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.tag = 2;
        _btnLeft.titleLabel.font = font12;
        [_btnLeft setTitleColor:color33 forState:UIControlStateNormal];
        [_btnLeft setTitleColor:color33 forState:UIControlStateHighlighted];
        _btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_btnLeft addTarget:self action:@selector(btnLeftClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnLeft];
        [_btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.mas_equalTo(Width/5);
            make.height.mas_equalTo(self.mas_height);
        }];
        _btnRight  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.tag = 3;
        _btnRight.titleLabel.font = font12;
        [_btnRight setTitleColor:color33 forState:UIControlStateNormal];
        [_btnRight setTitleColor:color33 forState:UIControlStateHighlighted];
        [_btnRight addTarget:self action:@selector(btnRightClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:_btnRight];
        [_btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-10);
            make.width.mas_equalTo(Width/5);
            make.height.mas_equalTo(self.mas_height);
        }];
        _viewline = [[UIView alloc] init];
        [self addSubview:_viewline];
        [_viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.width.mas_equalTo(Width);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}
- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    if (_isBeforeTwo) {
        [_btnLeft setTitle:@"上一天" forState:UIControlStateNormal];
        [_btnLeft setTitle:@"上一天" forState:UIControlStateHighlighted];
        [_btnRight setTitle:@"下一天" forState:UIControlStateNormal];
        [_btnRight setTitle:@"下一天" forState:UIControlStateHighlighted];
    }else{
        [_btnLeft setTitle:@"上一期" forState:UIControlStateNormal];
        [_btnLeft setTitle:@"上一期" forState:UIControlStateHighlighted];
        [_btnRight setTitle:@"下一期" forState:UIControlStateNormal];
        [_btnRight setTitle:@"下一期" forState:UIControlStateHighlighted];
    }
    _imageV.image = [UIImage imageNamed:@"bfdateXiala"];
    _viewline.backgroundColor = colorCellLine;
    [_btnRight setTitleColor:color33 forState:UIControlStateNormal];
    _btnRight.enabled = YES;
    [_btnLeft setTitleColor:color33 forState:UIControlStateNormal];
    _btnLeft.enabled = YES;
    _currentIndex = 0;
    if (_arrData.count>0) {
        ZBQiciModel *qici = [_arrData objectAtIndex:_currentIndex];
        [_btnDate setTitle:qici.name forState:UIControlStateNormal];
        [_btnDate setTitle:qici.name forState:UIControlStateNormal];
    }
    [self updateSubView];
}
- (void)setDateIndex:(NSInteger)index
{
    _currentIndex = index;
    [self updateSubView];
}
- (void)updateSubView
{
    ZBQiciModel *qici;
    if (_arrData.count >0) {
        qici = [_arrData objectAtIndex:_currentIndex];
        [_btnDate setTitle:qici.name forState:UIControlStateNormal];
        [_btnDate setTitle:qici.name forState:UIControlStateNormal];
    }
    [_btnLeft setTitleColor:color33 forState:UIControlStateNormal];
    _btnLeft.enabled = YES;
    [_btnRight setTitleColor:color33 forState:UIControlStateNormal];
    _btnRight.enabled = YES;
    if (_isSaiguo) {
        if (_currentIndex == 0 || isNUll(qici.date)) {
            [_btnRight setTitleColor:color99 forState:UIControlStateNormal];
            _btnRight.enabled = NO;
        }
        if (_currentIndex == _arrData.count-1) {
            [_btnLeft setTitleColor:color99 forState:UIControlStateNormal];
            _btnLeft.enabled = NO;
        }
    }else{
        if (_currentIndex == 0) {
            [_btnLeft setTitleColor:color99 forState:UIControlStateNormal];
            _btnLeft.enabled = NO;
        }
        if (_currentIndex == _arrData.count-1) {
            [_btnRight setTitleColor:color99 forState:UIControlStateNormal];
            _btnRight.enabled = NO;
        }
    }
    if (_currentIndex>0 && _currentIndex <_arrData.count-1) {
        [_btnRight setTitleColor:color33 forState:UIControlStateNormal];
        _btnRight.enabled = YES;
        [_btnLeft setTitleColor:color33 forState:UIControlStateNormal];
        _btnLeft.enabled = YES;
    }
}
- (void)btnLeftClick:(UIButton *)btn
{
    if (_isSaiguo) {
        _currentIndex++;
    }else{
        _currentIndex--;
    }
    [self updateSubView];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedDateViewIndex:)]) {
        if (_isSaiguo) {
            [_delegate selectedDateViewIndex:3];
        }else{
            [_delegate selectedDateViewIndex:btn.tag];
        }
    }
}
- (void)btnRightClick:(UIButton *)btn
{
    if (_isSaiguo) {
        _currentIndex--;
    }else{
        _currentIndex++;
    }
    [self updateSubView];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedDateViewIndex:)]) {
        if (_isSaiguo) {
            [_delegate selectedDateViewIndex:2];
        }else{
            [_delegate selectedDateViewIndex:btn.tag];
        }
    }
}
@end
