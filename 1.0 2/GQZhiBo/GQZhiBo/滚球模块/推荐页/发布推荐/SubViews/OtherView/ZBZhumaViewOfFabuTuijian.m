#import "ZBZhumaViewOfFabuTuijian.h"
@interface ZBZhumaViewOfFabuTuijian()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labPrice;
@property (nonatomic, strong) UIButton *btnPrices;
@property (nonatomic, strong) UILabel *labNoteCode;
@property (nonatomic, strong) UIButton *btnWin;
@property (nonatomic, strong) UIButton *btnPing;
@property (nonatomic, strong) UIButton *btnLose;
@property (nonatomic, assign) CGFloat btnWidth;
@property (nonatomic, strong) UIButton *priceBtns;
@property (nonatomic, strong) NSMutableArray *priceBtnsArr;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *btnConfirm;
@end
@implementation ZBZhumaViewOfFabuTuijian
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}
- (void)setPriceList:(NSArray *)priceList
{
    _priceList = priceList;
    [self setUpPriceBtns];
}
- (void)setUpPriceBtns {
    CGFloat btnwidth = (Width - 30 -(_priceList.count-1)*5)/_priceList.count;
    for (int i = 0 ; i < _priceList.count; i++) {
        ZBPriceListModel *mode = [_priceList objectAtIndex:i];
        UIButton *btnPrices = [UIButton buttonWithType:UIButtonTypeCustom];
        btnPrices.frame = CGRectMake(15+5*i + btnwidth*i , self.labPrice.bottom + 10,btnwidth, 30);
        btnPrices.tag = i;
        [btnPrices setTitle:mode.desc forState:UIControlStateNormal];
        btnPrices.titleLabel.font = font13;
        btnPrices.tag = i;
        [btnPrices setTitleColor:redcolor forState:UIControlStateSelected];
        [btnPrices setTitleColor:color27 forState:UIControlStateNormal];
        [btnPrices setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateHighlighted];
        [btnPrices setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
        if (i == 0) {
            [btnPrices setTitleColor:redcolor forState:UIControlStateNormal];
            btnPrices.layer.borderColor = redcolor.CGColor;
        }else{
            btnPrices.layer.borderColor = grayColor2.CGColor;
        }
        btnPrices.layer.borderWidth = 0.6;
        btnPrices.selected = NO;
        btnPrices.layer.cornerRadius = 3;
        [btnPrices addTarget:self action:@selector(priceBtnsClick:) forControlEvents:UIControlEventTouchUpInside];
        btnPrices.layer.masksToBounds = YES;
        [_basicView addSubview:btnPrices];
        [self.priceBtnsArr addObject:btnPrices];
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, self.height)];
        _btnWidth = (Width- 30)/4;
        [_basicView addSubview:self.labNoteCode];
        [_basicView addSubview:self.btnWin];
        [_basicView addSubview:self.btnPing];
        [_basicView addSubview:self.btnLose];
        [_basicView addSubview:self.btnConfirm];
        [_btnWin setTitle:@"均注" forState:UIControlStateNormal];
        [_btnPing setTitle:@"2倍" forState:UIControlStateNormal];
        [_btnLose setTitle:@"4倍" forState:UIControlStateNormal];
        [_btnConfirm setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    return _basicView;
}
- (NSMutableArray *)priceBtnsArr {
    if (!_priceBtnsArr) {
        _priceBtnsArr = [NSMutableArray array];
    }
    return _priceBtnsArr;
}
- (UILabel *)labNoteCode
{
    if (!_labNoteCode) {
        _labNoteCode = [[UILabel alloc] initWithFrame:CGRectMake(15, _labPrice.height+ 30 + 15, Width*0.7, 30)];
        _labNoteCode.text = @"方案注码";
        _labNoteCode.font = font14;
    }
    return _labNoteCode;
}
- (UIButton *)btnWin
{
    if (!_btnWin) {
        _btnWin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWin.frame =CGRectMake(15, _labNoteCode.bottom +10,(Width- 105)/5, 30);   
        _btnWin.titleLabel.font = font13;
        [_btnWin setTitleColor:redcolor forState:UIControlStateSelected];
        [_btnWin setTitleColor:color27 forState:UIControlStateNormal];
        [_btnWin setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnWin setBackgroundImage:[UIImage imageNamed:@"PeilvSelected"] forState:UIControlStateSelected];
        [_btnWin setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
        _btnWin.layer.borderColor = grayColor2.CGColor;
        _btnWin.layer.borderWidth = 0.6;
        _btnWin.selected = YES;
        _btnWin.layer.cornerRadius = 15;
        _btnWin.layer.masksToBounds = YES;
        _btnWin.tag = 1;
        [_btnWin addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnWin;
}
- (UIButton *)btnPing
{
    if (!_btnPing) {
        _btnPing = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPing.frame =CGRectMake(self.btnWin.right + 25, _labNoteCode.bottom+10, (Width- 105)/5, 30);
        _btnPing.titleLabel.font = font13;
        [_btnPing setTitleColor:redcolor forState:UIControlStateSelected];
        [_btnPing setTitleColor:color27 forState:UIControlStateNormal];
        [_btnPing setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _btnPing.tag = 2;
        [_btnPing addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
        [_btnPing setBackgroundImage:[UIImage imageNamed:@"PeilvSelected"] forState:UIControlStateSelected];
        [_btnPing setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
        _btnPing.layer.borderColor = grayColor2.CGColor;
        _btnPing.layer.borderWidth = 0.6;
        _btnPing.layer.cornerRadius = 15;
        _btnPing.layer.masksToBounds = YES;
    }
    return _btnPing;
}
- (UIButton *)btnLose
{
    if (!_btnLose) {
        _btnLose = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLose.frame =CGRectMake(self.btnPing.right + 25, _labNoteCode.bottom+10, (Width- 105)/5, 30);
        _btnLose.titleLabel.font = font13;
        [_btnLose setTitleColor:redcolor forState:UIControlStateSelected];
        [_btnLose setTitleColor:color27 forState:UIControlStateNormal];
        [_btnLose setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnLose setBackgroundImage:[UIImage imageNamed:@"PeilvSelected"] forState:UIControlStateSelected];
        [_btnLose setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal];
        _btnLose.tag = 3;
        [_btnLose addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
        _btnLose.layer.borderColor = grayColor2.CGColor;
        _btnLose.layer.borderWidth = 0.6;
        _btnLose.layer.cornerRadius = 15;
        _btnLose.layer.masksToBounds = YES;
    }
    return _btnLose;
}
- (UIButton *)btnConfirm {
    if (!_btnConfirm) {
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm.frame = CGRectMake(self.btnLose.right + 25, _labNoteCode.bottom + 10, (Width - 105)*2/5 , 30);
        _btnConfirm.titleLabel.font = font13;
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnConfirm.tag = 4;
        [_btnConfirm addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.backgroundColor = colorEa;
        _btnConfirm.layer.cornerRadius = 6;
        _btnConfirm.layer.masksToBounds = YES;
    }
    return _btnConfirm;
}
- (void)priceBtnsClick:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    for(int i = 0;i < self.priceBtnsArr.count;i++)
    {
        UIButton *btn = self.priceBtnsArr[i];
        [btn setTitleColor:color27 forState:UIControlStateNormal];
        btn.layer.borderColor  = grayColor2.CGColor;
        btn.selected = NO;
    }
    UIButton *btn = sender;
    btn.layer.borderColor = redcolor.CGColor;
    btn.selected = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(didselectedPriceViewWithModel:)]) {
        [_delegate didselectedPriceViewWithModel:[_priceList objectAtIndex:sender.tag]];
    }
}
- (void)choiceType:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
            _btnWin.selected = YES;
            _btnPing.selected = NO;
            _btnLose.selected = NO;
        }
            break;
        case 2:
        {
            _btnWin.selected = NO;
            _btnPing.selected = YES;
            _btnLose.selected = NO;
        }
            break;
        case 3:
        {
            _btnWin.selected = NO;
            _btnPing.selected = NO;
            _btnLose.selected = YES;
        }
            break;
        default:
            break;
    }
    _btnWin.layer.borderColor = _btnWin.selected? redcolor.CGColor : grayColor2.CGColor;
    _btnPing.layer.borderColor = _btnPing.selected? redcolor.CGColor : grayColor2.CGColor;
    _btnLose.layer.borderColor = _btnLose.selected? redcolor.CGColor : grayColor2.CGColor;
    if (_delegate && [_delegate respondsToSelector:@selector(didselectedZhumaAtIndex:)]) {
        [_delegate didselectedZhumaAtIndex:btn.tag];
    }
}
@end
