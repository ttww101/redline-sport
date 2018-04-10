//
//  TuijianDatingCell.m
//  GQapp
//
//  Created by WQ_h on 16/8/2.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "TuijianDatingCell.h"
#import "TuijianDetailVC.h"
#import "TeamViewofTuijianCell.h"
#import "BuyViewofTuijianView.h"
#import "PeilvViewOfTuijianCell.h"
#import "UserViewofMyBuyTuijian.h"
@interface TuijianDatingCell()
//是否添加过约束
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UserViewOfTuijianCell *headerUser;
@property (nonatomic, strong) UserViewofMyBuyTuijian *UserofMyBuy;

@property (nonatomic, strong) TeamViewofTuijianCell *teamView;

@property (nonatomic, strong) BuyViewofTuijianView *buymView;
@property (nonatomic, strong) PeilvViewOfTuijianCell *peilvView;

//具体内容
@property (nonatomic, strong) UILabel *labContent;
//具体内容
@property (nonatomic, strong) UIView *viewContent;

//发布日期
@property (nonatomic, strong) UILabel *labCreatTime;
//反对按钮
@property (nonatomic, strong) UIButton *btnZan;
//反对数
@property (nonatomic, strong) UILabel *labZanNum;
//点赞按钮
@property (nonatomic, strong) UIButton *btnNoZan;
//点赞数
@property (nonatomic, strong) UILabel *labNoZanNum;
//评论
@property (nonatomic, strong) UIButton *btnComment;
//评论数
@property (nonatomic, strong) UILabel *labConmmentNum;
//赢的情况
@property (nonatomic, strong) UIImageView *imageViewWin;

//推荐的状态
@property (nonatomic, strong) UILabel *labStatus;
//付费参看的费用
@property (nonatomic, strong) UILabel *labMoney;

@end
@implementation TuijianDatingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
    
    
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}
- (void)setModel:(TuijiandatingModel *)model
{
    _model = model;
    
    
    
    [self.contentView addSubview:self.basicView];

    if (!_didSetupConstraints) {
        _didSetupConstraints = YES;
        [self addAutoLayoutToCell];
    }

    
    [_headerUser setValueWithUserTitle:_model.nickname Pic:_model.pic ArrTitles:_model.medals Remark:_model.arrUsermark  Win:_model.win_rate Profite:_model.profit_rate Round:[NSString stringWithFormat:@"%ld",_model.recommend_count] Fans:[NSString stringWithFormat:@"%ld",_model.follower_count] Userid:_model.user_id colorType:1 cellType:_type readCount:[NSString stringWithFormat:@"%ld",_model.readCount] dayRange:_model.dayRange WithModel:_model];
    _teamView.model = _model;
    _buymView.model = _model;
    _peilvView.model = _model;
    _UserofMyBuy.model = _model;
    
    if (_type == typeTuijianCellMybuy) {
        _labContent.text = @"";
        
        _labCreatTime.text = @"";
        //    评论数
        [_btnComment setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _labConmmentNum.text = @"";
        //查看人数
        [_btnNoZan setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _labNoZanNum.text = @"";
        
        [_btnZan setBackgroundImage:[UIImage imageNamed:@""]forState:UIControlStateNormal];
        _labZanNum.text = @"";
        _labMoney.text = [NSString stringWithFormat:@" %ld球币 ",_model.amount/100];

    }else{
        _labContent.text = [NSString stringWithFormat:@"分析:  %@",_model.content];
        _labContent.attributedText = [Methods withContent:_labContent.text WithColorText:@"分析:" textColor:color33 strFont:font14];
        
//        _labCreatTime.text = [Methods timeToNowWith:_model.create_time];
        //    评论数
        [_btnComment setBackgroundImage:[UIImage imageNamed:@"commentNum"] forState:UIControlStateNormal];
        _labConmmentNum.text = [NSString stringWithFormat:@"%ld",(long)_model.comment_count];
        //查看人数
        [_btnNoZan setBackgroundImage:[UIImage imageNamed:@"hated"] forState:UIControlStateNormal];
        _labNoZanNum.text = [NSString stringWithFormat:@"%ld",(long)_model.readCount];
        
        
        
        [_btnZan setBackgroundImage:[UIImage imageNamed:@"clear"]forState:UIControlStateNormal];
        _labZanNum.text = @"";
        

    }
    _labStatus.text = @"";

    if (_type == typeTuijianCellUser) {
        
        if (_model.status == 2) {
            _labStatus.text = @"待审核";

        }else if (_model.status == 6){
        _labStatus.text = @"审核不通过";
        }
        _labStatus.textColor = redcolor;

    }else{
        _labStatus.text = @"";
        _labStatus.textColor = [UIColor whiteColor];

    }


    
    
    if (_model.result!= nil) {
        switch ([_model.result integerValue]) {
            case 0:
            {
                _imageViewWin.image = [UIImage imageNamed:@"wuxiao"];
            }
                break;
            case 1:
            {
                _imageViewWin.image = [UIImage imageNamed:@"winhalf"];
            }
                break;
                
            case 2:
            {
                _imageViewWin.image = [UIImage imageNamed:@"win"];
            }
                break;
                
            case -1:
            {
                _imageViewWin.image = [UIImage imageNamed:@"losehalf"];
            }
                break;
                
            case -2:
            {
                _imageViewWin.image = [UIImage imageNamed:@"lose"];
            }
                break;
            case -3:
            {
                _imageViewWin.image = [UIImage imageNamed:@"cheDan"];
            }
                break;

            case 10:
            {
                _imageViewWin.image = [UIImage imageNamed:@"wuxiaoNew"];
            }
                break;
                
            case -10:
            {
                _imageViewWin.image = [UIImage imageNamed:@""];
            }
                break;
                
            default:
                break;
        }
        
    }else{
        _imageViewWin.image = [UIImage imageNamed:@"clear"];
        
    }
//    _imageViewWin.image = [UIImage imageNamed:@"clear"];

    
}



- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
//        _basicView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTuijianDetail)];
        _basicView.opaque = YES;
        [_basicView addGestureRecognizer:tap];
        
        switch (_type) {
            case typeTuijianCellDating:
            {
                [_basicView addSubview:self.headerUser];
                [_basicView addSubview:self.teamView];
                [_basicView addSubview:self.peilvView];

            }
                break;
            case typeTuijianCellFenxi:
            {
                [_basicView addSubview:self.headerUser];
//                [_basicView addSubview:self.teamView];
                [_basicView addSubview:self.peilvView];

            }
                break;
            case typeTuijianCellUser:
            {
                [_basicView addSubview:self.teamView];
                [_basicView addSubview:self.peilvView];

            }
                break;
            case typeTuijianCellFirstPage:
            {
                [_basicView addSubview:self.headerUser];
                [_basicView addSubview:self.teamView];
                [_basicView addSubview:self.peilvView];

            }
                break;
            case typeTuijianCellMybuy:
            {
                [_basicView addSubview:self.UserofMyBuy];
                [_basicView addSubview:self.teamView];
                [_basicView addSubview:self.buymView];
                [_basicView addSubview:self.peilvView];
                [_basicView addSubview:self.labMoney];
            }
                break;

            default:
                break;
        }
        
        [_basicView addSubview:self.labStatus];
        [_basicView addSubview:self.imageViewWin];

        [_basicView addSubview:self.viewContent];
        [_basicView addSubview:self.labContent];
        
        [_basicView addSubview:self.labCreatTime];
        
        [_basicView addSubview:self.labConmmentNum];
        [_basicView addSubview:self.btnComment];
        [_basicView addSubview:self.labNoZanNum];
        [_basicView addSubview:self.btnNoZan];
        [_basicView addSubview:self.labZanNum];
        [_basicView addSubview:self.btnZan];
        
        
        
        
        
    }
    return _basicView;
}

- (UserViewOfTuijianCell *)headerUser
{
    if (!_headerUser) {
        _headerUser = [[UserViewOfTuijianCell alloc] init];
    }
    return _headerUser;
}
- (UserViewofMyBuyTuijian *)UserofMyBuy
{
    if (!_UserofMyBuy) {
        _UserofMyBuy = [[UserViewofMyBuyTuijian alloc] init];
    }
    return _UserofMyBuy;
}
- (TeamViewofTuijianCell *)teamView
{
    if (!_teamView) {
        _teamView = [[TeamViewofTuijianCell alloc] init];
    }
    return _teamView;
}

- (BuyViewofTuijianView *)buymView
{
    if (!_buymView) {
        _buymView = [[BuyViewofTuijianView alloc] init];
    }
    return _buymView;
}
- (PeilvViewOfTuijianCell *)peilvView
{
    if (!_peilvView) {
        _peilvView = [[PeilvViewOfTuijianCell alloc] init];
    }
    return _peilvView;
}
- (UILabel *)labMoney
{
    if (!_labMoney) {
        _labMoney = [[UILabel alloc] init];
        _labMoney.font = font14;
        _labMoney.textColor = yellowcolor;
        _labMoney.layer.borderColor = yellowcolor.CGColor;
        _labMoney.layer.borderWidth = 0.6;
        _labMoney.layer.cornerRadius = 3;
        _labMoney.layer.masksToBounds = YES;
    }
    return _labMoney;
}
- (UILabel *)labStatus
{
    if (!_labStatus) {
        _labStatus = [[UILabel alloc] init];
        _labStatus.font = font9;
    }
    return _labStatus;
}
- (UILabel *)labCreatTime
{
    if (!_labCreatTime) {
        _labCreatTime = [[UILabel alloc] init];
        _labCreatTime.font = font10;
        _labCreatTime.textColor = color99;
    }
    return _labCreatTime;
}

- (UILabel *)labConmmentNum
{
    if (!_labConmmentNum) {
        _labConmmentNum = [[UILabel alloc] init];
        _labConmmentNum.font = font10;
        _labConmmentNum.textColor = color99;
    }
    return _labConmmentNum;
}
- (UIButton *)btnComment
{
    if (!_btnComment) {
        _btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComment.titleLabel.font = font11;
        [_btnComment setTitleColor:color99 forState:UIControlStateNormal];
    }
    return _btnComment;
}
- (UILabel *)labNoZanNum
{
    if (!_labNoZanNum) {
        _labNoZanNum = [[UILabel alloc] init];
        _labNoZanNum.font = font10;
        _labNoZanNum.textColor = color99;
        
    }
    return _labNoZanNum;
}
- (UIButton *)btnNoZan
{
    if (!_btnNoZan) {
        _btnNoZan = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnNoZan.titleLabel.font = font11;
        [_btnNoZan setTitleColor:color99 forState:UIControlStateNormal];
        _btnNoZan.tag = 2;
//        [_btnNoZan addTarget:self action:@selector(addLikedHated:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnNoZan;
}

- (UILabel *)labZanNum
{
    if (!_labZanNum) {
        _labZanNum = [[UILabel alloc] init];
        _labZanNum.font = font10;
        _labZanNum.textColor = color99;
    }
    return _labZanNum;
}
- (UIButton *)btnZan
{
    if (!_btnZan) {
        _btnZan = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnZan.titleLabel.font = font11;
        [_btnZan setTitleColor:color99 forState:UIControlStateNormal];
        _btnZan.tag = 1;
//        [_btnZan addTarget:self action:@selector(addLikedHated:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnZan;
}
- (UIImageView *)imageViewWin
{
    if (!_imageViewWin) {
        _imageViewWin = [[UIImageView alloc] init];
    }
    return _imageViewWin;
}

- (UILabel *)labContent
{
    if (!_labContent) {
        _labContent = [[UILabel alloc] init];
        _labContent.font = font14;
        _labContent.textColor = color33;
        _labContent.numberOfLines = 1;
    }
    return _labContent;
}

- (UIView *)viewContent
{
    if (!_viewContent) {
        _viewContent = [[UIView alloc] init];
        _viewContent.backgroundColor = colorF5;
    }
    return _viewContent;
}
- (void)addAutoLayoutToCell
{
    
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0);
    } ];
    
    
    switch (_type) {
        case typeTuijianCellDating:
        {
            [self.headerUser mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.basicView.mas_top);
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.height.mas_equalTo(58);
            }];
            
            
            
            [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-40);
                make.top.equalTo(self.headerUser.mas_bottom).offset(8);
            }];
            
            [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.headerUser.mas_bottom).offset(5);
                make.size.mas_equalTo(CGSizeMake(Width, 45));
            }];
            
            [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.teamView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(Width, 18));

            }];
            [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.top.equalTo(self.peilvView.mas_bottom).offset(7.5);
                make.right.equalTo(self.contentView.mas_right).offset(200);
                
            }];
            
            [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.bottom.equalTo(self.basicView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(Width, 10));
            }];
            
            //计算cell的高度
            [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-21.5);
                make.top.equalTo(self.labContent.mas_bottom).offset(8.5);
            }];

        }
            break;
        case typeTuijianCellFirstPage:
        {
            [self.headerUser mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.basicView.mas_top);
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.height.mas_equalTo(58);
            }];
            
            
            
            [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-40);
                make.top.equalTo(self.headerUser.mas_bottom).offset(8);
            }];
            
            [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.headerUser.mas_bottom).offset(5);
                make.size.mas_equalTo(CGSizeMake(Width, 45));
            }];
            
            [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.teamView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(Width, 18));
                
            }];
            [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.top.equalTo(self.peilvView.mas_bottom).offset(7.5);
                make.right.equalTo(self.basicView.mas_right).offset(-15);
                
            }];
            [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.bottom.equalTo(self.basicView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(Width, 10));
            }];
            
            //计算cell的高度
            [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-21.5);
                make.top.equalTo(self.labContent.mas_bottom).offset(8.5);
            }];

        }
            break;

        case typeTuijianCellFenxi:
        {
            [self.headerUser mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.basicView.mas_top);
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.height.mas_equalTo(58);
            }];
            
            
            
            [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-40);
                make.top.equalTo(self.headerUser.mas_bottom).offset(-26);
            }];
            
//            [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.basicView.mas_left);
//                make.right.equalTo(self.basicView.mas_right);
//                make.top.equalTo(self.headerUser.mas_bottom).offset(5);
//                make.size.mas_equalTo(CGSizeMake(Width, 45));
//            }];
            
            [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.headerUser.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(Width, 18));
                
            }];
            [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.top.equalTo(self.peilvView.mas_bottom).offset(7.5);
                make.right.equalTo(self.basicView.mas_right).offset(-15);
                
            }];
            [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.bottom.equalTo(self.basicView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(Width, 10));
            }];
            
            //计算cell的高度
            [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-21.5);
                make.top.equalTo(self.labContent.mas_bottom).offset(8.5);
            }];

            
        }
            break;
        case typeTuijianCellUser:
        {
            
            
            
            [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-40);
                make.top.equalTo(self.basicView.mas_top).offset(10);
            }];
            
            [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.basicView.mas_top).offset(5);
                make.size.mas_equalTo(CGSizeMake(Width, 45));
            }];
            
            [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.teamView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(Width, 18));
                
            }];
            [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.top.equalTo(self.peilvView.mas_bottom).offset(7.5);
                make.right.equalTo(self.basicView.mas_right).offset(-15);
                
            }];
            [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.bottom.equalTo(self.basicView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(Width, 10));
            }];
            
            //计算cell的高度
            [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-21.5);
                make.top.equalTo(self.labContent.mas_bottom).offset(8.5);
            }];


        }
            break;
        case typeTuijianCellMybuy:
        {
            [self.UserofMyBuy mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.basicView.mas_top);
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.height.mas_equalTo(30);
            }];
            
            
            
            [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.labMoney.mas_left).offset(-5);
                make.top.equalTo(self.UserofMyBuy.mas_bottom).offset(8);
            }];
            
            [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.UserofMyBuy.mas_bottom).offset(5);
                make.size.mas_equalTo(CGSizeMake(Width, 45));
            }];
            
            [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.teamView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(Width, 18));
                
            }];
            
            [self.labMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-35);
                make.bottom.equalTo(self.peilvView.mas_top);
                make.height.mas_equalTo(18);
            }];
            [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.top.equalTo(self.peilvView.mas_bottom).offset(0);
                make.right.equalTo(self.basicView.mas_right).offset(-15);
                
            }];
            
            [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.bottom.equalTo(self.basicView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(Width, 10));
            }];
            
                      //计算cell的高度
            [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-20 - 25);
                make.top.equalTo(self.labContent.mas_bottom).offset(0);
            }];
            
            
            [self.buymView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-10);
                make.left.equalTo(self.basicView.mas_left).offset(0);
                make.size.mas_equalTo(CGSizeMake(Width, 30));
            }];

            

        }
            break;

        default:
            break;
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    [self.labStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-11);
        make.top.equalTo(self.imageViewWin.mas_top).offset(10);
    }];
    [self.labConmmentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnComment.mas_left).offset(-5);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
    }];
    
    [self.btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-18);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
    }];
    
    [self.labNoZanNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnNoZan.mas_left).offset(-5);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
    }];
    
    [self.btnNoZan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labConmmentNum.mas_left).offset(-23);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
    }];
    
    [self.labZanNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnNoZan.mas_left).offset(-9.5);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
    }];
    
    [self.btnZan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labZanNum.mas_left).offset(-4);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
    }];

    

    
    

}

- (void)toTuijianDetail

{
    NSLog(@"_model.idId=%ld",_model.idId);
    if (_type == typeTuijianCellMybuy) {
        
        if (_model.otype == 1) {
            TuijianDetailVC *infoVC = [[TuijianDetailVC alloc] init];
            infoVC.hidesBottomBarWhenPushed = YES;
            infoVC.status = _model.status;
            infoVC.modelId = _model.idId;
            
            [APPDELEGATE.customTabbar pushToViewController:infoVC animated:YES];

        }
 
    }else{
        TuijianDetailVC *infoVC = [[TuijianDetailVC alloc] init];
        infoVC.hidesBottomBarWhenPushed = YES;
        infoVC.status = _model.status;
        infoVC.modelId = _model.idId;
        [APPDELEGATE.customTabbar pushToViewController:infoVC animated:YES];

    }

}


- (void)addLikedHated:(UIButton *)btn
{
    
    //    param.put("type", "1"); //1 推荐曝料 2 评论
    //    param.put("targetId", "417"); ////点赞的对象id
    if (![Methods login]) {
        [Methods toLogin];
        return;
    }

    if (btn.tag == 1) {
        if (_model.liked == YES) {
            return;
        }
        if (_model.hated == YES) {
            return;
        }
    }else if (btn.tag == 2){
        if (_model.liked == YES) {
            return;
        }
        if (_model.hated == YES) {
            return;
        }
    }
    
    NSMutableDictionary *paremeter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [paremeter setObject:@"1" forKey:@"type"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)_model.idId] forKey:@"targetId"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)btn.tag] forKey:@"lclass"];
    
    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:paremeter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_likeAdd] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ((NSInteger)[[responseOrignal objectForKey:@"data"] integerValue] >0) {
                
                if (btn.tag == 1) {
                    _btnZan.selected = YES;
                    _model.like_count = _model.like_count + 1;
                    _model.liked = YES;
                    _labZanNum.text = [NSString stringWithFormat:@"%ld",(long)_model.like_count];
                }else{
                    _btnNoZan.selected = YES;
                    _model.hate_count = _model.hate_count+1;
                    _model.hated = YES;
                    _labNoZanNum.text = [NSString stringWithFormat:@"%ld",(long)_model.hate_count];
                    
                }
                
            }else{
//                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            }
        }else
        {
//            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        
    }];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
//    NSLog(@"%f",self.frame.size.height);
}



@end
