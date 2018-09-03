#import "ZBAllSelectedView.h"
@interface ZBAllSelectedView()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIButton *btnNotAll;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, strong) UIView *viewCenter;
@end
@implementation ZBAllSelectedView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] initWithFrame:self.bounds];
        _basicView.backgroundColor = colorF5;
        [_basicView addSubview:self.btnAll];
        [_basicView addSubview:self.btnNotAll];
        [_basicView addSubview:self.btnConfirm];
        [_basicView addSubview:self.viewLine];
        [_basicView addSubview:self.viewCenter];
    }
    return _basicView;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width, 0.6)];
        _viewLine.backgroundColor = colorDD;
    }
    return _viewLine;
}
- (UIView *)viewCenter
{
    if (!_viewCenter) {
        _viewCenter = [[UIView alloc]initWithFrame:CGRectMake((Width - 80)/2, 0, 0.5, self.height)];
        _viewCenter.backgroundColor = colorDD;
    }
    return _viewCenter;
}
- (UIButton *)btnAll
{
    if (!_btnAll) {
        _btnAll = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAll.frame = CGRectMake(0, 0, (Width-80)/2, self.height);
        _btnAll.center = CGPointMake(_btnAll.center.x, _basicView.height/2);
        [_btnAll setTitle:@"全选" forState:UIControlStateNormal];
        _btnAll.titleLabel.font = font14;
        [_btnAll setTitleColor:redcolor forState:UIControlStateSelected];
        [_btnAll setTitleColor:color33 forState:UIControlStateNormal];
        _btnAll.tag = 0;
        [_btnAll addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAll;
}
- (UIButton *)btnNotAll
{
    if (!_btnNotAll) {
        _btnNotAll = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnNotAll.frame = CGRectMake(_btnAll.right, 0, _btnAll.width, self.height);
        _btnNotAll.center = CGPointMake(_btnNotAll.center.x, _basicView.height/2);
        [_btnNotAll setTitle:@"全不选" forState:UIControlStateNormal];
        _btnNotAll.titleLabel.font = font14;
        [_btnNotAll setTitleColor:redcolor forState:UIControlStateSelected];
        [_btnNotAll setTitleColor:color33 forState:UIControlStateNormal];
        _btnNotAll.tag = 1;
        [_btnNotAll addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnNotAll;
}
- (UIButton *)btnConfirm
{
    if (!_btnConfirm) {
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm.frame = CGRectMake(Width - 80, 0, 80, self.basicView.height);
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize14];
        _btnConfirm.backgroundColor = redcolor;
        _btnConfirm.tag = 2;
        [_btnConfirm addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnConfirm;
}
- (void)btnClick:(UIButton *)btn
{
    if (btn.tag == 0) {
        if (!btn.selected) {
            _btnAll.selected = YES;
            _btnNotAll.selected = NO;
            if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtBtnIndex:whtherSelected:)]) {
                [_delegate didSelectedAtBtnIndex:btn.tag whtherSelected:btn.selected];
            }
        }
    }else if (btn.tag == 1){
        if (!btn.selected) {
            _btnNotAll.selected = YES;
            _btnAll.selected = NO;
            if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtBtnIndex:whtherSelected:)]) {
                [_delegate didSelectedAtBtnIndex:btn.tag whtherSelected:btn.selected];
            }
        }
    }else if(btn.tag == 2){
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectedAtBtnIndex:whtherSelected:)]) {
            [_delegate didSelectedAtBtnIndex:btn.tag whtherSelected:btn.selected];
        }
    }else{
    }
}
- (void)changeBtnSelectedState:(BOOL)isSelected
{
    if (isSelected) {
        _btnNotAll.selected = NO;
    }else{
        _btnAll.selected = NO;
    }
}
@end
