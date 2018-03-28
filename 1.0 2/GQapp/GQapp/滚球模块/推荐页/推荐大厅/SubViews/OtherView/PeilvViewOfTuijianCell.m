//
//  PeilvViewOfTuijianCell.m
//  GQapp
//
//  Created by WQ on 2017/8/25.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "PeilvViewOfTuijianCell.h"
@interface PeilvViewOfTuijianCell()
@property (nonatomic, assign) BOOL isAddlayout;

@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labPankou;
@property (nonatomic, strong) UILabel *labchoice;
@property (nonatomic, strong) UILabel *labPeilv;
@property (nonatomic, strong) UILabel *labZhuma;

@end
@implementation PeilvViewOfTuijianCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}


- (void)setModel:(TuijiandatingModel *)model
{
    _model = model;
    if (!_isAddlayout) {
        _isAddlayout = YES;
        [self addLayout];
    }
    
    _labPankou.text = @"";
    _labchoice.text = @"";
    _labPeilv.text = @"";
    _labZhuma.text = @"";
    
    NSLog(@"ya.count=%ld",_model.ya.count);
    if (_model.see) {//11111
    
        if (_model.spf.count>0) {//欧赔
            _labPankou.text = @"胜平负:";
            NSArray* arr = _model.spf;
            switch (_model.choice) {
                case 3:
                {
                    [_labchoice setText:@"胜" ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                    
                }
                    break;
                case 1:
                {
                    [_labchoice setText:@"平局" ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                    
                }
                    break;
                case 0:
                {
                    [_labchoice setText:@"负" ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                    
                }
                    break;
                    
                default:
                    break;
            }
            _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
            
        }else if (_model.ya.count>0){//亚盘
            _labPankou.text = @"让球:";
            NSArray* arr = _model.ya;
            [_labchoice setText:[NSString stringWithFormat:@"主%@",[arr objectAtIndex:1]] ];
            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
            
            switch (_model.choice) {
                case 3:
                {
                    [_labchoice setText:[NSString stringWithFormat:@"主%@",[arr objectAtIndex:1]] ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                    
                }
                    break;
                case 1:
                {
                    [_labchoice setText:@"主队" ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                    
                }
                    break;
                case 0:
                {
                    [_labchoice setText:[NSString stringWithFormat:@"客%@",[arr objectAtIndex:1]] ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                    
                }
                    break;
                    
                default:
                    break;
            }
            
            _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
            
        }else if (_model.dx.count>0){//判断大小球
            _labPankou.text = @"大小球:";
            NSArray* arr = _model.dx;
            switch (_model.choice) {
                case 3:
                {
                    [_labchoice setText:[NSString stringWithFormat:@"大%@",[arr objectAtIndex:1]] ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                    
                }
                    break;
                case 1:
                {
                    [_labchoice setText:@"大小球" ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                    
                }
                    break;
                case 0:
                {
                    [_labchoice setText:[NSString stringWithFormat:@"小%@",[arr objectAtIndex:1]] ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                    
                }
                    break;
                    
                default:
                    break;
            }
            
            
            _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
            
        }
        
        
        
        
        
        
        
        if (_model.multiple == 0 || _model.multiple == 1) {
            _labZhuma.text = @"均注";
            
        }else{
            _labZhuma.text = [NSString stringWithFormat:@"%ld倍",(long)_model.multiple];
        }
        

    }else{//11111
        _labPankou.text = @"付费查看";
        _labchoice.text = [NSString stringWithFormat:@"%ld球币",(long)_model.amount/100];
    }
    /*
    if (_model.otype == 1) {
        
        if (_model.see) {
            
            
            if (_model.spf.count>0) {//欧赔
                _labPankou.text = @"胜平负:";
                NSArray* arr = _model.spf;
                switch (_model.choice) {
                    case 3:
                    {
                        [_labchoice setText:@"胜" ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                        
                    }
                        break;
                    case 1:
                    {
                        [_labchoice setText:@"平局" ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                        
                    }
                        break;
                    case 0:
                    {
                        [_labchoice setText:@"负" ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                        
                    }
                        break;
                        
                    default:
                        break;
                }
                _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                
            }else if (_model.ya.count>0){//亚盘
                _labPankou.text = @"让球:";
                NSArray* arr = _model.ya;
                [_labchoice setText:[NSString stringWithFormat:@"主%@",[arr objectAtIndex:1]] ];
                [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                
                switch (_model.choice) {
                    case 3:
                    {
                        [_labchoice setText:[NSString stringWithFormat:@"主%@",[arr objectAtIndex:1]] ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                        
                    }
                        break;
                    case 1:
                    {
                        [_labchoice setText:@"主队" ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                        
                    }
                        break;
                    case 0:
                    {
                        [_labchoice setText:[NSString stringWithFormat:@"客%@",[arr objectAtIndex:1]] ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                        
                    }
                        break;
                        
                    default:
                        break;
                }
                
                _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                
            }else if (_model.dx.count>0){//判断大小球
                _labPankou.text = @"大小球:";
                NSArray* arr = _model.dx;
                switch (_model.choice) {
                    case 3:
                    {
                        [_labchoice setText:[NSString stringWithFormat:@"大%@",[arr objectAtIndex:1]] ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                        
                    }
                        break;
                    case 1:
                    {
                        [_labchoice setText:@"大小球" ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                        
                    }
                        break;
                    case 0:
                    {
                        [_labchoice setText:[NSString stringWithFormat:@"小%@",[arr objectAtIndex:1]] ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                        
                    }
                        break;
                        
                    default:
                        break;
                }
                
                
                _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                
            }
            
            
            
            
            
            
            
            if (_model.multiple == 0 || _model.multiple == 1) {
                _labZhuma.text = @"均注";
                
            }else{
                _labZhuma.text = [NSString stringWithFormat:@"%ld倍",(long)_model.multiple];
            }
            
            
            
            
        }else{
            if (_model.choice == -1) {
                
                _labPankou.text = @"付费查看";
                _labchoice.text = [NSString stringWithFormat:@"%ld球币",(long)_model.amount/100];
                
            }else{
                
                if (_model.spf.count>0) {//欧赔
                    _labPankou.text = @"胜平负:";
                    NSArray* arr = _model.spf;
                    switch (_model.choice) {
                        case 3:
                        {
                            [_labchoice setText:@"胜" ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                            
                        }
                            break;
                        case 1:
                        {
                            [_labchoice setText:@"平局" ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                            
                        }
                            break;
                        case 0:
                        {
                            [_labchoice setText:@"负" ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                            
                        }
                            break;
                            
                        default:
                            break;
                    }
                    _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                    
                }else if (_model.ya.count>0){//亚盘
                    _labPankou.text = @"让球:";
                    NSArray* arr = _model.ya;
                    switch (_model.choice) {
                        case 3:
                        {
                            [_labchoice setText:[NSString stringWithFormat:@"主%@",[arr objectAtIndex:1]] ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                            
                        }
                            break;
                        case 1:
                        {
                            [_labchoice setText:@"主队" ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                            
                        }
                            break;
                        case 0:
                        {
                            [_labchoice setText:[NSString stringWithFormat:@"客%@",[arr objectAtIndex:1]] ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                            
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                    _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                    
                }else if (_model.dx.count>0){//判断大小球
                    _labPankou.text = @"大小球:";
                    NSArray* arr = _model.dx;
                    switch (_model.choice) {
                        case 3:
                        {
                            [_labchoice setText:[NSString stringWithFormat:@"大%@",[arr objectAtIndex:1]] ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                            
                        }
                            break;
                        case 1:
                        {
                            [_labchoice setText:@"大小球" ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                            
                        }
                            break;
                        case 0:
                        {
                            [_labchoice setText:[NSString stringWithFormat:@"小%@",[arr objectAtIndex:1]] ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                            
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                    
                    _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                    
                }
                
                
                
                
                
                
                
                if (_model.multiple == 0 || _model.multiple == 1) {
                    _labZhuma.text = @"均注";
                    
                }else{
                    _labZhuma.text = [NSString stringWithFormat:@"%ld倍",(long)_model.multiple];
                }
                
            }
            
        }

    }else{
    
        if (_model.see) {
            
            
            if (_model.playtype == 1) {//欧赔
                _labPankou.text = @"胜平负:";
                NSArray* arr = _model.spf;
                switch (_model.choice) {
                    case 3:
                    {
                        [_labchoice setText:@"胜" ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                        
                    }
                        break;
                    case 1:
                    {
                        [_labchoice setText:@"平局" ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                        
                    }
                        break;
                    case 0:
                    {
                        [_labchoice setText:@"负" ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                        
                    }
                        break;
                        
                    default:
                        break;
                }
                _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                
            }else if (_model.playtype == 2){//亚盘
                _labPankou.text = @"让球:";
                NSArray* arr = _model.ya;
                switch (_model.choice) {
                    case 3:
                    {
                        [_labchoice setText:[NSString stringWithFormat:@"主%@",[arr objectAtIndex:1]] ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                        
                    }
                        break;
                    case 1:
                    {
                        [_labchoice setText:@"主队" ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                        
                    }
                        break;
                    case 0:
                    {
                        [_labchoice setText:[NSString stringWithFormat:@"客%@",[arr objectAtIndex:1]] ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                        
                    }
                        break;
                        
                    default:
                        break;
                }
                
                _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                
            }else if (_model.playtype == 3){//判断大小球
                _labPankou.text = @"大小球:";
                NSArray* arr = _model.dx;
                switch (_model.choice) {
                    case 3:
                    {
                        [_labchoice setText:[NSString stringWithFormat:@"大%@",[arr objectAtIndex:1]] ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                        
                    }
                        break;
                    case 1:
                    {
                        [_labchoice setText:@"大小球" ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                        
                    }
                        break;
                    case 0:
                    {
                        [_labchoice setText:[NSString stringWithFormat:@"小%@",[arr objectAtIndex:1]] ];
                        [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                        
                    }
                        break;
                        
                    default:
                        break;
                }
                
                
                _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                
            }else{
#pragma mark--推荐大厅的列表
                
                //dfvdfvdfvdfvdfv
                _labPankou.text = @"让球:";
                NSArray* arr = _model.ya;
                [_labchoice setText:[NSString stringWithFormat:@"主%@",[arr objectAtIndex:1]] ];
                [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];

            }
            
            
            
            
            
            
            
            if (_model.multiple == 0 || _model.multiple == 1) {
                _labZhuma.text = @"均注";
                
            }else{
                _labZhuma.text = [NSString stringWithFormat:@"%ld倍",(long)_model.multiple];
            }
            
            
            
            
        }else{
            if (_model.choice == -1) {
                
                _labPankou.text = @"付费查看";
                _labchoice.text = [NSString stringWithFormat:@"%ld球币",(long)_model.amount/100];
                
            }else{
                
                if (_model.playtype == 1) {//欧赔
                    _labPankou.text = @"胜平负:";
                    NSArray* arr = _model.spf;
                    switch (_model.choice) {
                        case 3:
                        {
                            [_labchoice setText:@"胜" ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                            
                        }
                            break;
                        case 1:
                        {
                            [_labchoice setText:@"平局" ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                            
                        }
                            break;
                        case 0:
                        {
                            [_labchoice setText:@"负" ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                            
                        }
                            break;
                            
                        default:
                            break;
                    }
                    _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                    
                }else if (_model.playtype == 2){//亚盘
                    _labPankou.text = @"让球:";
                    NSArray* arr = _model.ya;
                    switch (_model.choice) {
                        case 3:
                        {
                            [_labchoice setText:[NSString stringWithFormat:@"主%@",[arr objectAtIndex:1]] ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                            
                        }
                            break;
                        case 1:
                        {
                            [_labchoice setText:@"主队" ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                            
                        }
                            break;
                        case 0:
                        {
                            [_labchoice setText:[NSString stringWithFormat:@"客%@",[arr objectAtIndex:1]] ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                            
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                    _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                    
                }else if (_model.playtype == 3){//判断大小球
                    _labPankou.text = @"大小球:";
                    NSArray* arr = _model.dx;
                    switch (_model.choice) {
                        case 3:
                        {
                            [_labchoice setText:[NSString stringWithFormat:@"大%@",[arr objectAtIndex:1]] ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                            
                        }
                            break;
                        case 1:
                        {
                            [_labchoice setText:@"大小球" ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                            
                        }
                            break;
                        case 0:
                        {
                            [_labchoice setText:[NSString stringWithFormat:@"小%@",[arr objectAtIndex:1]] ];
                            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                            
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                    
                    _labPeilv.attributedText = [Methods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
                    
                }
                
                
                
                
                
                
                
                if (_model.multiple == 0 || _model.multiple == 1) {
                    _labZhuma.text = @"均注";
                    
                }else{
                    _labZhuma.text = [NSString stringWithFormat:@"%ld倍",(long)_model.multiple];
                }
                
            }
            
        }

    }
    
    */
   
}

- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        
//        [_basicView addSubview:self.labPankou];
//        [_basicView addSubview:self.labchoice];
        
        
        [_basicView addSubview:self.labPeilv];
        [_basicView addSubview:self.labZhuma];
    }
    return _basicView;
}
- (UILabel *)labPankou
{
    if (!_labPankou) {
        _labPankou = [[UILabel alloc] init];
        _labPankou.textColor = color33;
        _labPankou.font = font14;
    }
    return _labPankou;
}


- (UILabel *)labchoice
{
    if (!_labchoice) {
        _labchoice = [[UILabel alloc] init];
        _labchoice.textColor = redcolor;
        _labchoice.font = font14;
    }
    return _labchoice;
}
- (UILabel *)labPeilv
{
    if (!_labPeilv) {
        _labPeilv = [[UILabel alloc] init];
        _labPeilv.textColor = redcolor;
        _labPeilv.font = font14;
    }
    return _labPeilv;
}
- (UILabel *)labZhuma
{
    if (!_labZhuma) {
        _labZhuma = [[UILabel alloc] init];
        _labZhuma.textColor = redcolor;
        _labZhuma.font = font14;
    }
    return _labZhuma;
}

- (void)addLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
//    [self.labPankou mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.basicView.mas_left).offset(15);
//        make.centerY.equalTo(self.basicView.mas_centerY);
//    }];
    
//    [self.labchoice mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.labPankou.mas_right).offset(10);
//        make.centerY.equalTo(self.basicView.mas_centerY);
//    }];

    [self.labPeilv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];

    [self.labZhuma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labPeilv.mas_right).offset(12);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];

}















@end
