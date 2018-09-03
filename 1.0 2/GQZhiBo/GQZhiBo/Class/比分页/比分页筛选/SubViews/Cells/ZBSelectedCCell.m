#import "ZBSelectedCCell.h"
@interface ZBSelectedCCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labCount;
@property (nonatomic, strong) UIView *bgSelectedView;
@property (nonatomic, strong) UILabel *labSelectedTitle;
@property (nonatomic, strong) UILabel *labSelectedCount;
@end
@implementation ZBSelectedCCell
- (void)setCellSize:(CGSize)cellSize
{
    _cellSize = cellSize;
    self.backgroundView = self.bgView;
    _bgView.frame = CGRectMake(0, 0, _cellSize.width, _cellSize.height);
    _labTitle.frame = CGRectMake(5, 0, _cellSize.width - 10, _cellSize.height);
    _labCount.frame = CGRectMake(5, 0, _cellSize.width - 10, _cellSize.height);
    self.selectedBackgroundView = self.bgSelectedView;
    _bgSelectedView.frame = CGRectMake(0, 0, _cellSize.width, _cellSize.height);
    _labSelectedTitle.frame = CGRectMake(5, 0, _cellSize.width - 10, _cellSize.height);
    _labSelectedCount.frame = CGRectMake(5, 0, _cellSize.width - 10, _cellSize.height);
}
- (void)setModel:(ZBBIfenSelectedSaishiModel *)model
{
    _model = model;
    NSString *title;
    if (_cellSize.width < ((Width - 30 - 10)/2)) {
        if (isOniPhone4 || isOniPhone5) {
            if (model.name.length>3) {
                title = [model.name substringToIndex:3];
            }else{
                title = model.name;
            }
        }else{
            title = model.name;
        }
    }else{
        title = model.name;
    }
    if (model.isSelected) {
        self.bgView.backgroundColor = redcolor;
        _labTitle.textColor = [UIColor clearColor];
        _labCount.textColor = [UIColor clearColor];
    }else{
        self.bgView.backgroundColor = [UIColor whiteColor];
        _labTitle.textColor = color33;
        _labCount.textColor = color99;
    }
    _labTitle.text = title;
    _labCount.text = [NSString stringWithFormat:@"%ld场",(long)_model.count];
    _labSelectedTitle.text = title;
    _labSelectedCount.text = [NSString stringWithFormat:@"%ld场",(long)_model.count];
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView  = [[UIView alloc] init];
        _bgView.frame = CGRectMake(0, 0, _cellSize.width, _cellSize.height);
        _bgView.layer.borderColor = colorDD.CGColor;
        _bgView.layer.borderWidth = 0.7;
        _bgView.layer.cornerRadius = 3;
        [_bgView addSubview:self.labTitle];
        [_bgView addSubview:self.labCount];
    }
    return _bgView;
}
- (UILabel *)labTitle
{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] init];
        _labTitle.textColor = color33;
        _labTitle.font = font12;
    }
    return _labTitle;
}
- (UILabel *)labCount
{
    if (!_labCount) {
        _labCount = [[UILabel alloc] init];
        _labCount.textColor = color99;
        _labCount.font = font12;
        _labCount.textAlignment = NSTextAlignmentRight;
    }
    return _labCount;
}
- (UIView *)bgSelectedView
{
    if (!_bgSelectedView) {
        _bgSelectedView  = [[UIView alloc] init];
        _bgSelectedView.frame = CGRectMake(0, 0, _cellSize.width, _cellSize.height);
        _bgSelectedView.layer.borderColor = redcolor.CGColor;
        _bgView.backgroundColor = redcolor;
        _bgSelectedView.layer.borderWidth = 0.7;
        _bgSelectedView.layer.cornerRadius = 3;
        [_bgSelectedView addSubview:self.labSelectedTitle];
        [_bgSelectedView addSubview:self.labSelectedCount];
    }
    return _bgSelectedView;
}
- (UILabel *)labSelectedTitle
{
    if (!_labSelectedTitle) {
        _labSelectedTitle = [[UILabel alloc] init];
        _labSelectedTitle.textColor = [UIColor whiteColor];
        _labSelectedTitle.font = font12;
    }
    return _labSelectedTitle;
}
- (UILabel *)labSelectedCount
{
    if (!_labSelectedCount) {
        _labSelectedCount = [[UILabel alloc] init];
        _labSelectedCount.textColor = [UIColor whiteColor];
        _labSelectedCount.font = font12;
        _labSelectedCount.textAlignment = NSTextAlignmentRight;
    }
    return _labSelectedCount;
}
@end
