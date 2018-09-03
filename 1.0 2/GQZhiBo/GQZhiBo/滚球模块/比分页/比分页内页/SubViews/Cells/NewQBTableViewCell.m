//
//  NewQBTableViewCell.m
//  GQapp
//
//  Created by WQ_h on 16/5/9.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "NewQBTableViewCell.h"
@interface NewQBTableViewCell ()
//是否添加过约束
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIView *basicView;
//主队或者客队
@property (nonatomic, strong) UILabel *labHomeOrAway;
//标题
@property (nonatomic, strong) UILabel *labtitle;
//具体内容
@property (nonatomic, strong) UILabel *labContent;
//日期
@property (nonatomic, strong) UILabel *labdate;
//事件和状态之间的竖线
@property (nonatomic, strong) UIView *LineV;
//竖线右
@property (nonatomic, strong) UIView *LineVRight;
//横线线
@property (nonatomic, strong) UIView *LineH;

@property (nonatomic, strong) UIImageView *imgType;

@end
@implementation NewQBTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(InfoListModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    _labdate.text =  [_model.create_time substringWithRange:NSMakeRange(5, 11)];
    _LineV.backgroundColor =colorDE;
    _labHomeOrAway.text = model.newsTypeName;
    _labHomeOrAway.textColor = [Methods getColor:model.newsTypeColor];
    _labtitle.text = [NSString stringWithFormat:@"%@",_model.title];
    if (_model.content == nil) {
        _model.content = @"";
    }
    [_labContent setAttributedText:[Methods setTextStyleWithString:_model.content WithLineSpace:6 WithHeaderIndent:heightHeaderIndent]];
    if (_hideBottomView) {
        _LineH.backgroundColor = [UIColor whiteColor];
    }else{
        _LineH.backgroundColor = colorDD;
    }
    switch (model.mark) {
        case 1:{
            self.imgType.image = [UIImage imageNamed:@"QBTypeDuJia"];
            
        }
            break;
        case 2:{
            self.imgType.image = [UIImage imageNamed:@"QBTypeHaiWai"];
        }
            break;
        case 3:{
            self.imgType.image = [UIImage imageNamed:@"QBTypeTuFa"];
        }
            break;
        case 4:{
            self.imgType.image = [UIImage imageNamed:@"QBTypeLiC"];
        }
            break;
        case 5:{
            self.imgType.image = [UIImage imageNamed:@"QBTypeNeiMu"];
        }
            break;
            
        default:{
            self.imgType.image = [UIImage imageNamed:@"clear"];
        }
            break;
    }
    
    if (!_didSetupConstraints) {
        _didSetupConstraints = YES;
        [self addAutoLayoutToCell];
        
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToDetailVC)];
        [_basicView addGestureRecognizer:tap];
        [_basicView addSubview:self.labHomeOrAway];
        [_basicView addSubview:self.labtitle];
        [_basicView addSubview:self.labContent];
        [_basicView addSubview:self.LineH];
        [_basicView addSubview:self.labdate];
        [_basicView addSubview:self.LineV];
        [_basicView addSubview:self.imgType];
    }
    return _basicView;
}


- (UILabel *)labHomeOrAway
{
    if (!_labHomeOrAway) {
        _labHomeOrAway = [[UILabel alloc] init];
        _labHomeOrAway.textColor = [UIColor whiteColor];
//        _labHomeOrAway.layer.cornerRadius = 3;
//        _labHomeOrAway.layer.masksToBounds = YES;
        _labHomeOrAway.textAlignment = NSTextAlignmentCenter;
        _labHomeOrAway.font = font12;
    }
    return _labHomeOrAway;
}
- (UILabel *)labtitle
{
    if (!_labtitle) {
        _labtitle = [[UILabel alloc] init];
        _labtitle.font = font20;
        _labtitle.textColor = color33;
        _labtitle.numberOfLines = 2;
//        [_labtitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
    }
    return _labtitle;
}
- (UILabel *)labContent
{
    if (!_labContent) {
        _labContent = [[UILabel alloc] init];
        _labContent.font = font14;
        _labContent.textColor = color66;
        _labContent.numberOfLines = 0;
    }
    return _labContent;
}

- (UILabel *)labdate
{
    if (!_labdate) {
        _labdate = [[UILabel alloc] init];
        _labdate.textColor = color66;
        _labdate.font = font12;
    }
    return _labdate;
}
- (UIView *)LineH
{
    if (!_LineH) {
        _LineH = [[UIView alloc] init];
        _LineH.backgroundColor = colorDD;
    }
    return _LineH;
}
- (UIView *)LineV
{
    if (!_LineV) {
        _LineV = [[UIView alloc] init];
        _LineV.backgroundColor = colorDE;
    }
    return _LineV;
}
- (UIImageView *)imgType{
    if (!_imgType) {
        _imgType = [[UIImageView alloc] init];
        _imgType.image = [UIImage imageNamed:@"clear"];
    }
    return _imgType;
}
- (void)addAutoLayoutToCell
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [self.labdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.basicView.mas_top).offset(12.5);

    }];
    
    [self.LineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labdate.mas_right).offset(5);
        make.centerY.equalTo(self.labdate.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(0.5, 10));
    }];
    
    [self.labHomeOrAway mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LineV.mas_right).offset(5);
        make.centerY.equalTo(self.labdate.mas_centerY);
    }];
    [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.labdate.mas_bottom).offset(10);
        make.right.equalTo(self.basicView.mas_right).offset(-15);
        
    }];
    
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.labtitle.mas_bottom).offset(10);
        make.right.equalTo(self.basicView.mas_right).offset(-15);
//        make.bottom.equalTo(self.basicView.mas_bottom).offset(-12.5);
    }];
    
    [self.LineH mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(0);
        make.right.equalTo(self.basicView.mas_right).offset(0);
        make.bottom.equalTo(self.basicView.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labtitle.mas_top).offset(5);
        make.right.mas_equalTo(self.basicView.mas_right);
    }];
    
}

- (void)pushToDetailVC
{
//    InfoDetailViewController *infoVC = [[InfoDetailViewController alloc] init];
//    infoVC.hidesBottomBarWhenPushed = YES;
//    infoVC.model = _model;
//    infoVC.typedVC = typedVCBaoliao;
//    infoVC.superVC = pushFromSuperOtherlVC;
//    
//    [APPDELEGATE.customTabbar pushToViewController:infoVC animated:YES];
    
}











@end
