#import "ZBMineTableViewCell.h"
@interface ZBMineTableViewCell ()
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *rightArrorImageView;
@property (nonatomic, strong) UILabel *rightContentLabel;
@property (nonatomic, strong) UILabel *bridgeLab;
@end
@implementation ZBMineTableViewCell
static CGFloat cell_Height = 44;
static NSString *identifier = @"listCell";
+ (ZBMineTableViewCell *)cellForTableView:(UITableView *)tableView {
    ZBMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZBMineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
+ (CGFloat)heightForCell {
    return cell_Height;
}
- (void)refreshContentData:(ZBMineModel *)model; {
    self.leftImageView.image = [UIImage imageNamed:model.leftImageName];
    self.contentLabel.text = model.leftContent;
    self.rightArrorImageView.image = [UIImage imageNamed:model.rightImageName];
    
    if (model.rightContent) {
        self.rightContentLabel.hidden = false;
        self.rightContentLabel.text = model.rightContent;
    } else {
        self.rightContentLabel.hidden = YES;
    }
    
    if ([model.numbers integerValue] > 0) {
        CGFloat width = [model.numbers widthForFont:[UIFont systemFontOfSize:10.f]] + 10;
        self.bridgeLab.layer.cornerRadius = width / 2;
        [self.bridgeLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, width));
        }];
        self.bridgeLab.text = model.numbers;
    } else {
        self.bridgeLab.hidden = true;
    }
}
#pragma mark - Config UI
- (void)configUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(18, 17));
    }];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.leftImageView.mas_right).offset(15);
    }];
    [self.contentView addSubview:self.rightArrorImageView];
    [self.rightArrorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(7, 14));
    }];
    [self.contentView addSubview:self.rightContentLabel];
    [self.rightContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.rightArrorImageView.mas_leftMargin).offset(-15);
    }];
    
    [self.contentView addSubview:self.bridgeLab];
    [self.bridgeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.rightArrorImageView.mas_leftMargin).offset(-15);
        make.size.mas_equalTo(CGSizeZero);
    }];
}
#pragma mark - Lazy Load
- (UIImageView *)leftImageView {
    if (_leftImageView == nil) {
        _leftImageView = [UIImageView new];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImageView;
}
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:16.f];;
        _contentLabel.textColor = UIColorFromRGBWithOX(0x333333);
    }
    return _contentLabel;
}

- (UILabel *)rightContentLabel {
    if (_rightContentLabel == nil) {
        _rightContentLabel = [UILabel new];
        _rightContentLabel.font = [UIFont systemFontOfSize:14.f];;
        _rightContentLabel.textColor = UIColorFromRGBWithOX(0xDB2D21);
    }
    return _rightContentLabel;
}

- (UILabel *)bridgeLab {
    if (_bridgeLab == nil) {
        _bridgeLab = [UILabel new];
        _bridgeLab.font = [UIFont systemFontOfSize:10.f];
        _bridgeLab.backgroundColor = UIColorFromRGBWithOX(0xDB2D21);
        _bridgeLab.textColor = [UIColor whiteColor];
        _bridgeLab.layer.masksToBounds = true;
        _bridgeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _bridgeLab;
}

- (UIImageView *)rightArrorImageView {
    if (_rightArrorImageView == nil) {
        _rightArrorImageView = [UIImageView new];
        _rightArrorImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightArrorImageView;
}
@end
