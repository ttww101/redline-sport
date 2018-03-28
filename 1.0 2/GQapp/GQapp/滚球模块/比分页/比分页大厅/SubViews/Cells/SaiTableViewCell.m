//
//  SaiTableViewCell.m
//  GunQiuLive
//
//  Created by WQ_h on 16/1/28.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "SaiTableViewCell.h"
#import "DCHttpRequest.h"
#import "FenxiPageVC.h"
@interface SaiTableViewCell()
@property (nonatomic, assign) BOOL addLayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIView *viewline;

@property (nonatomic, strong) UIImageView *imageBg;
//角球的图片
@property (nonatomic, strong) UIImageView *imageJiaoqiu;

@property (nonatomic, strong) UILabel *timeLab;
//竞彩的编号
@property (nonatomic, strong) UILabel *sortLab;
//赛事
@property (nonatomic, strong) UILabel *eventLab;
//比分
@property (nonatomic, strong) UILabel *VSlab;
//半场比分
@property (nonatomic, strong) UILabel *halfScore;
//角球
@property (nonatomic, strong) UILabel *jiaoqiuScore;
//比赛的状态
@property (nonatomic, strong) UILabel *labstate;

//右边的赔率
@property (nonatomic, strong) UILabel *pankouLab;
@property (nonatomic, strong) UILabel *peiLvHomeLab;
@property (nonatomic, strong) UILabel *peilvAwayLab;
//左边的赔率
@property (nonatomic, strong) UILabel *pankouLableft;
@property (nonatomic, strong) UILabel *peiLvHomeLableft;
@property (nonatomic, strong) UILabel *peilvAwayLableft;

//显示时间的动画
@property (nonatomic, strong) UIImageView *imageAnimation;
@property (nonatomic, strong) UILabel *teamHomeLab;
@property (nonatomic, strong) UILabel *teamAwayLab;
@property (nonatomic, strong) UIButton *baoBtn;
@property (nonatomic, strong) UIButton *jianBtn;

@property (nonatomic, strong) UIButton *attentionBtn;


//红牌
@property (nonatomic, strong) UILabel *redHomeLab;
@property (nonatomic, strong) UILabel *redAwayLab;
//黄牌
@property (nonatomic, strong) UILabel *yellowHomeLab;
@property (nonatomic, strong) UILabel *yellowAwayLab;
//排名
@property (nonatomic, strong) UILabel *listHomeLab;
@property (nonatomic, strong) UILabel *listAwayLab;


@property (nonatomic, strong) UILabel *labRemark;

//情报
@property (nonatomic, strong) UILabel               *labQB;
@property (nonatomic, strong) UILabel               *labQBNum;

@property (nonatomic, strong) UIView                *viewLineR;
//推荐
@property (nonatomic, strong) UILabel               *labTJ;
@property (nonatomic, strong) UILabel               *labTJNum;

//防止重复点击
@property (nonatomic, assign) BOOL isToFenxi;
@end
@implementation SaiTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setScoreModel:(LiveScoreModel *)ScoreModel
{
    
    _ScoreModel = ScoreModel;
    
    [self.contentView addSubview:self.basicView];
    //    if ([_ScoreModel.hometeam isEqualToString:@"泽尼特"]) {SaishiType
    //
    //    }
    
//    if (ScoreModel.neutrality) {
//        NSLog(@"%@",ScoreModel);
//        self.basicView.backgroundColor = redcolor;
//    }else{
//        self.basicView.backgroundColor = [UIColor whiteColor];
//
//    }
    if (ScoreModel.bgIsRed) {
        _imageBg.image = [UIImage imageNamed:@"jinqiuYellowBg1"];
        
    }else{
        _imageBg.image = [UIImage imageNamed:@"clear"];
        
    }
    _timeLab.text =[[[_ScoreModel.matchtime componentsSeparatedByString:@" "] objectAtIndex:1] substringToIndex:5];
    
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"]);
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"]) {
////        _sortLab.text = @"" ;
//        _sortLab.text = [NSString stringWithFormat:@"%@",_ScoreModel.sort] ;
//        
//    }else{
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"bianhao"]) {
            _sortLab.text = [NSString stringWithFormat:@"%@",_ScoreModel.sort] ;
            
        }else{
            _sortLab.text = @"" ;
            
        }
        
//    }

    _eventLab.text = _ScoreModel.league;
    _eventLab.textColor = [Methods getColor:_ScoreModel.leagueColor];
    NSString *time = [Methods getDateByStyle:dateStyleFormatter withDate:[NSDate date]];
    
    // letgoal：让球盘（亚盘 8002），total：大小盘 8001，standard：欧盘 8000
    
    _peiLvHomeLab.text = @"";
    _peilvAwayLab.text = @"";
    _pankouLab.text =@"";
    _peiLvHomeLableft.text = @"";
    _peilvAwayLableft.text = @"";
    _pankouLableft.text =@"";
    
    
    NSArray *arrPeilv = [[NSUserDefaults standardUserDefaults] arrayForKey:@"befenSetingPeilv"];
    _peilvAwayLableft.text =@""; //-/-
    _peiLvHomeLab.text = @""; // -/-/-
    
    
    
//    //是否会显示亚盘，欧赔，大小球
//    BOOL isYaPan = NO;
//    BOOL isOuPei = NO;
//    BOOL isDaXiao = NO;
    
    
    
    if ([arrPeilv containsObject:@"8002"] && [arrPeilv containsObject:@"8001"]) {
        //亚盘
        NSArray *arrletgoal = [_ScoreModel.letgoal componentsSeparatedByString:@","];
        if (arrletgoal.count==3) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrletgoal];
            
            for (int i = 0; i<arr.count; i++) {
                if (i == 1) {
                    continue;
                }
                NSString *str = [arr objectAtIndex:i];
                if ([Methods isPureInt:str]) {
                    str = [NSString stringWithFormat:@"%d",[str intValue]];
                }else if ([Methods isPureFloat:str]){
                    str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                }
                [arr replaceObjectAtIndex:i withObject:str];
            }
            
            _peiLvHomeLableft.text = [arr objectAtIndex:0];
            _peilvAwayLableft.text =[arr objectAtIndex:2];
            _pankouLableft.text =[arr objectAtIndex:1];
//            isYaPan = YES;
        }
        
        
        //大小
        NSArray *arrstandard = [_ScoreModel.total componentsSeparatedByString:@","];
        if (arrstandard.count==3) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrstandard];
            
            for (int i = 0; i<arr.count; i++) {
                
                NSString *str = [arr objectAtIndex:i];
                if ([Methods isPureInt:str]) {
                    str = [NSString stringWithFormat:@"%d",[str intValue]];
                }else if ([Methods isPureFloat:str]){
                    str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                }
                [arr replaceObjectAtIndex:i withObject:str];
            }
            
            _peiLvHomeLab.text = [arr objectAtIndex:0];
            _peilvAwayLab.text =[arr objectAtIndex:2];
            _pankouLab.text =[arr objectAtIndex:1];
//            isDaXiao = YES;
        }

        
    }

    
    
    
    
    if ([arrPeilv containsObject:@"8002"] && [arrPeilv containsObject:@"8000"]) {
        //亚盘
        NSArray *arrletgoal = [_ScoreModel.letgoal componentsSeparatedByString:@","];
        if (arrletgoal.count==3) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrletgoal];
            
            for (int i = 0; i<arr.count; i++) {
                if (i == 1) {
                    continue;
                }
                NSString *str = [arr objectAtIndex:i];
                if ([Methods isPureInt:str]) {
                    str = [NSString stringWithFormat:@"%d",[str intValue]];
                }else if ([Methods isPureFloat:str]){
                    str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                }
                [arr replaceObjectAtIndex:i withObject:str];
            }
            
            _peiLvHomeLableft.text = [arr objectAtIndex:0];
            _peilvAwayLableft.text =[arr objectAtIndex:2];
            _pankouLableft.text =[arr objectAtIndex:1];
//            isYaPan = YES;
        }
        
        
        //欧盘
        NSArray *arrstandard = [_ScoreModel.standard componentsSeparatedByString:@","];
        if (arrstandard.count==3) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrstandard];
            
            for (int i = 0; i<arr.count; i++) {
                
                NSString *str = [arr objectAtIndex:i];
                if ([Methods isPureInt:str]) {
                    str = [NSString stringWithFormat:@"%d",[str intValue]];
                }else if ([Methods isPureFloat:str]){
                    str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                }
                [arr replaceObjectAtIndex:i withObject:str];
            }
            
            _peiLvHomeLab.text = [arr objectAtIndex:0];
            _peilvAwayLab.text =[arr objectAtIndex:2];
            _pankouLab.text =[arr objectAtIndex:1];
//            isOuPei = YES;
        }

    }
    
    
    
    
    
    if ([arrPeilv containsObject:@"8000"] && [arrPeilv containsObject:@"8001"]) {
        //欧盘
        NSArray *arrstandard = [_ScoreModel.standard componentsSeparatedByString:@","];
        if (arrstandard.count==3) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrstandard];
            
            for (int i = 0; i<arr.count; i++) {
                
                NSString *str = [arr objectAtIndex:i];
                if ([Methods isPureInt:str]) {
                    str = [NSString stringWithFormat:@"%d",[str intValue]];
                }else if ([Methods isPureFloat:str]){
                    str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                }
                [arr replaceObjectAtIndex:i withObject:str];
            }
            
            _peiLvHomeLab.text = [arr objectAtIndex:0];
            _peilvAwayLab.text =[arr objectAtIndex:2];
            _pankouLab.text =[arr objectAtIndex:1];
//            isOuPei = YES;
        }
        
        
        //大小
        NSArray *arrtotal = [_ScoreModel.total componentsSeparatedByString:@","];
        if (arrtotal.count==3) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrtotal];
            
            for (int i = 0; i<arr.count; i++) {
                
                NSString *str = [arr objectAtIndex:i];
                if ([Methods isPureInt:str]) {
                    str = [NSString stringWithFormat:@"%d",[str intValue]];
                }else if ([Methods isPureFloat:str]){
                    str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                }
                [arr replaceObjectAtIndex:i withObject:str];
            }
            
            _peiLvHomeLableft.text = [arr objectAtIndex:0];
            _peilvAwayLableft.text =[arr objectAtIndex:2];
            _pankouLableft.text =[arr objectAtIndex:1];
//            isDaXiao = YES;
        }

        
    }
    
    
    
    

    
    
    
    
    
    
    
    
    /*
    
    
    
    
    
    
    
    
    if ([arrPeilv containsObject:@"8002"]) {
        //亚盘
        NSArray *arrletgoal = [_ScoreModel.letgoal componentsSeparatedByString:@","];
        if (arrletgoal.count==3) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrletgoal];
            
            for (int i = 0; i<arr.count; i++) {
                if (i == 1) {
                    continue;
                }
                NSString *str = [arr objectAtIndex:i];
                if ([Methods isPureInt:str]) {
                    str = [NSString stringWithFormat:@"%d",[str intValue]];
                }else if ([Methods isPureFloat:str]){
                    str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                }
                [arr replaceObjectAtIndex:i withObject:str];
            }
            
            _peiLvHomeLableft.text = [arr objectAtIndex:0];
            _peilvAwayLableft.text =[arr objectAtIndex:2];
            _pankouLableft.text =[arr objectAtIndex:1];
            isYaPan = YES;
        }
        
    }
    
    
    
    if ([arrPeilv containsObject:@"8000"]) {
        //欧盘
        NSArray *arrstandard = [_ScoreModel.standard componentsSeparatedByString:@","];
        if (arrstandard.count==3) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrstandard];
            
            for (int i = 0; i<arr.count; i++) {
                
                NSString *str = [arr objectAtIndex:i];
                if ([Methods isPureInt:str]) {
                    str = [NSString stringWithFormat:@"%d",[str intValue]];
                }else if ([Methods isPureFloat:str]){
                    str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                }
                [arr replaceObjectAtIndex:i withObject:str];
            }
            
            _peiLvHomeLab.text = [arr objectAtIndex:0];
            _peilvAwayLab.text =[arr objectAtIndex:2];
            _pankouLab.text =[arr objectAtIndex:1];
            isOuPei = YES;
        }
        
    }
    
    
    
    if ([arrPeilv containsObject:@"8001"]) {
        //大小
        NSArray *arrstandard = [_ScoreModel.total componentsSeparatedByString:@","];
        if (arrstandard.count==3) {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrstandard];
            
            for (int i = 0; i<arr.count; i++) {
                
                NSString *str = [arr objectAtIndex:i];
                if ([Methods isPureInt:str]) {
                    str = [NSString stringWithFormat:@"%d",[str intValue]];
                }else if ([Methods isPureFloat:str]){
                    str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                }
                [arr replaceObjectAtIndex:i withObject:str];
            }
            
            _peiLvHomeLab.text = [arr objectAtIndex:0];
            _peilvAwayLab.text =[arr objectAtIndex:2];
            _pankouLab.text =[arr objectAtIndex:1];
            isDaXiao = YES;
        }
        
    }
     
    
    
    
    if (isYaPan && isOuPei) {
        
    }else if (isYaPan && !isOuPei){
        
        if ([arrPeilv containsObject:@"8001"]) {
            //大小球
            NSArray *arrtotal = [_ScoreModel.total componentsSeparatedByString:@","];
            if (arrtotal.count==3) {
                NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrtotal];
                
                for (int i = 0; i<arr.count; i++) {
                    if (i == 1) {
                        continue;
                    }
                    NSString *str = [arr objectAtIndex:i];
                    if ([Methods isPureInt:str]) {
                        str = [NSString stringWithFormat:@"%d",[str intValue]];
                    }else if ([Methods isPureFloat:str]){
                        str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                    }
                    [arr replaceObjectAtIndex:i withObject:str];
                }
                
                _peiLvHomeLab.text = [arr objectAtIndex:0];
                _peilvAwayLab.text =[arr objectAtIndex:2];
                _pankouLab.text =[arr objectAtIndex:1];
                isDaXiao = YES;
            }
            
        }else{
            
        }
        
        
    }else if (isOuPei && !isYaPan){
        
        if (([arrPeilv containsObject:@"8001"])) {
            //大小球
            NSArray *arrtotal = [_ScoreModel.total componentsSeparatedByString:@","];
            if (arrtotal.count==3) {
                NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrtotal];
                
                for (int i = 0; i<arr.count; i++) {
                    if (i == 1) {
                        continue;
                    }
                    NSString *str = [arr objectAtIndex:i];
                    if ([Methods isPureInt:str]) {
                        str = [NSString stringWithFormat:@"%d",[str intValue]];
                    }else if ([Methods isPureFloat:str]){
                        str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                    }
                    [arr replaceObjectAtIndex:i withObject:str];
                }
                
                _peiLvHomeLableft.text = [arr objectAtIndex:0];
                _peilvAwayLableft.text =[arr objectAtIndex:2];
                _pankouLableft.text =[arr objectAtIndex:1];
                isDaXiao = YES;
            }
            
            if ([arrPeilv containsObject:@"8000"]) {
                //欧盘
                NSArray *arrstandard = [_ScoreModel.standard componentsSeparatedByString:@","];
                if (arrstandard.count==3) {
                    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrstandard];
                    
                    for (int i = 0; i<arr.count; i++) {
                        
                        NSString *str = [arr objectAtIndex:i];
                        if ([Methods isPureInt:str]) {
                            str = [NSString stringWithFormat:@"%d",[str intValue]];
                        }else if ([Methods isPureFloat:str]){
                            str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                        }
                        [arr replaceObjectAtIndex:i withObject:str];
                    }
                    
                    _peiLvHomeLab.text = [arr objectAtIndex:0];
                    _peilvAwayLab.text =[arr objectAtIndex:2];
                    _pankouLab.text =[arr objectAtIndex:1];
                    isOuPei = YES;
                }
                
            }
            
            
        }else{
            
        }
        
        
    }else if (!isYaPan && !isYaPan){
        
        if ([arrPeilv containsObject:@"8001"]) {
            //大小球
            NSArray *arrtotal = [_ScoreModel.total componentsSeparatedByString:@","];
            if (arrtotal.count==3) {
                NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:arrtotal];
                
                for (int i = 0; i<arr.count; i++) {
                    if (i == 1) {
                        continue;
                    }
                    NSString *str = [arr objectAtIndex:i];
                    if ([Methods isPureInt:str]) {
                        str = [NSString stringWithFormat:@"%d",[str intValue]];
                    }else if ([Methods isPureFloat:str]){
                        str = [NSString stringWithFormat:@"%.2f",[str floatValue]];
                    }
                    [arr replaceObjectAtIndex:i withObject:str];
                }
                
                _peiLvHomeLableft.text = [arr objectAtIndex:0];
                _peilvAwayLableft.text =[arr objectAtIndex:2];
                _pankouLableft.text =[arr objectAtIndex:1];
            }
            
        }else{
            
        }
        
    }else{
        
    }

    */
//    NSLog(@"_currentflag -----%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"_currentflag"]);

    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"]) {
        
        if (_ScoreModel.neutrality) {
            _peiLvHomeLab.text = @"";
            _peilvAwayLab.text = @"";
            _pankouLab.text =@"";
            _peiLvHomeLableft.text = @"";
            _peilvAwayLableft.text = @"";
            _pankouLableft.text =@"";
            
            
            _peilvAwayLableft.text =@""; //-/-
            _peiLvHomeLab.text = @"";  //-/-/-
            
            
        }
    }
    
    
    
    
    _jiaoqiuScore.text = @"";
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jiaoqiu"]) {
        
        if (ScoreModel.matchstate == 1 || ScoreModel.matchstate == 2 || ScoreModel.matchstate == 3|| ScoreModel.matchstate == 4|| ScoreModel.matchstate == -1) {
            _jiaoqiuScore.text = [NSString stringWithFormat:@"%@:%@",_ScoreModel.homeCorner,_ScoreModel.guestCorner];
            _imageJiaoqiu.image= [UIImage imageNamed:@"jiaoqiu"];
            
//            _peiLvHomeLab.text = @"";
//            _peilvAwayLab.text =@"";
//            _pankouLab.text =@"";

            
        }else{
            _jiaoqiuScore.text = @"";
            _imageJiaoqiu.image= [UIImage imageNamed:@"clear"];
            
        }
        
    }else{
        _jiaoqiuScore.text = @"";
        _imageJiaoqiu.image= [UIImage imageNamed:@"clear"];
        
    }
    //只在中场或者下半场的时候显示半场比分
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"banchang"]) {
        //下半场
        if ( _ScoreModel.matchstate == 3) {
            _halfScore.text = [NSString stringWithFormat:@"%ld:%ld",(long)self.ScoreModel.homehalfscore,(long)self.ScoreModel.guesthalfscore];
            
        }else if(_ScoreModel.matchstate == 2){
            _halfScore.text = [NSString stringWithFormat:@"%ld:%ld",(long)self.ScoreModel.homehalfscore,(long)self.ScoreModel.guesthalfscore];
            _peilvAwayLab.textAlignment = NSTextAlignmentRight;
            
        }else if(_ScoreModel.matchstate == 4){
            _halfScore.text = [NSString stringWithFormat:@"%ld:%ld",(long)self.ScoreModel.homehalfscore,(long)self.ScoreModel.guesthalfscore];
            _peilvAwayLab.textAlignment = NSTextAlignmentRight;
            
        }else if(_ScoreModel.matchstate == -1){
            _halfScore.text = [NSString stringWithFormat:@"%ld:%ld",(long)self.ScoreModel.homehalfscore,(long)self.ScoreModel.guesthalfscore];
            _peilvAwayLab.textAlignment = NSTextAlignmentRight;
            
        }
        else{
            _halfScore.text = @"";
            
        }
        
    }else{
        
        _halfScore.text = @"";
        
    }
    
    //    只在比赛的时候显示时间动画
    if (_ScoreModel.matchstate == 1 || _ScoreModel.matchstate == 3) {
        [_imageAnimation startAnimating];
        
    }else{
        if ([_imageAnimation isAnimating]) {
            [_imageAnimation stopAnimating];
        }
    }
    
    
    if (_ScoreModel.recommand== 0 && _ScoreModel.info == 0 ) {

        _labQBNum.text = @"";
        _labTJNum.text = @"";
        _labTJ.text = @"推荐";
        _labQB.text = @"情报";
        _labQB.hidden = YES;
        _viewLineR.hidden = YES;
        _labTJ.hidden = YES;
        _labQB.alpha = 1;
        _labTJ.alpha = 1;
    }else if(_ScoreModel.recommand!= 0  && _ScoreModel.info == 0 ) {
        _labQBNum.text = @"";
        _labTJNum.text = @"";
        _labTJNum.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.recommand];
        _viewLineR.hidden = YES;
        _labTJ.text = @"推荐";
        _labQB.text = @"情报";
        _labQB.hidden = NO;
        _labTJ.hidden = NO;
        _labQB.alpha = 0.02;
        _labTJ.alpha = 1;
    }else if (_ScoreModel.recommand  == 0 &&  _ScoreModel.info != 0) {
        _labQBNum.text = @"";
        _labTJNum.text = @"";
        _labQBNum.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.info];
        _labQB.text = @"情报";
        _labTJ.text = @"推荐";
        _labQB.hidden = NO;
        _labTJ.hidden = NO;
        _viewLineR.hidden = YES;
        _labTJ.alpha = 0.02;
        _labQB.alpha = 1;
    }else{
        _labQBNum.text = @"";
        _labTJNum.text = @"";
        _labTJNum.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.recommand];
        _labQBNum.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.info];
        _viewLineR.hidden = NO;
        _labQB.text = @"情报";
        _labTJ.text = @"推荐";
        _labQB.hidden = NO;
        _labTJ.hidden = NO;
        _labQB.alpha = 1;
        _labTJ.alpha = 1;
    }




    /*
    
    if (_ScoreModel.recommand) {
        //如果有推荐
//        [_jianBtn setTitle:[NSString stringWithFormat:@"荐%ld",(long)_ScoreModel.recommand] forState:UIControlStateNormal];
//        _jianBtn.layer.borderColor = colorFEE3E1.CGColor;
//        [_jianBtn setTitleColor:redcolor forState:UIControlStateNormal];
        
        _labTJNum.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.recommand];
        
        if (_ScoreModel.info) {
//            [_baoBtn  setTitle:[NSString stringWithFormat:@"报%ld",(long)_ScoreModel.info] forState:UIControlStateNormal];
//            _baoBtn.layer.borderColor = colorE4EEFB.CGColor;
//            [_baoBtn setTitleColor:color4A90E2 forState:UIControlStateNormal];
        
            _labQBNum.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.info];
            
        }else{
//            [_baoBtn  setTitle:@"" forState:UIControlStateNormal];
//            _baoBtn.layer.borderColor = [UIColor clearColor].CGColor;
         
            _labQB.text = @"";
        }
        
        
    }else{
        //没有推荐
        
        if (_ScoreModel.info) {
            [_jianBtn  setTitle:[NSString stringWithFormat:@"报%ld",(long)_ScoreModel.info] forState:UIControlStateNormal];
            _jianBtn.layer.borderColor = colorE4EEFB.CGColor;
            [_jianBtn setTitleColor:color4A90E2 forState:UIControlStateNormal];
            _baoBtn.layer.borderColor = [UIColor clearColor].CGColor;
            [_baoBtn  setTitle:@"" forState:UIControlStateNormal];
            
        }else{
            [_baoBtn  setTitle:@"" forState:UIControlStateNormal];
            _baoBtn.layer.borderColor = [UIColor clearColor].CGColor;
            [_jianBtn setTitle:@"" forState:UIControlStateNormal];
            _jianBtn.layer.borderColor = [UIColor clearColor].CGColor;
            
        }
        
        
        
    }
     
     */
    
    //vs 和 状态
    switch (_ScoreModel.matchstate) {
        case 0:
        {
            _VSlab.text = @"vs";
            _VSlab.textColor = colorCC;
            _labstate.text = @"";
            _VSlab.font = font17;
            
        }
            break;
        case 1:
        {
            //上半场
            NSString *timeCha =[Methods intervalFromLastDate:_ScoreModel.matchtime2 toTheDate:time];
            
            if ([timeCha isEqualToString:@"0"]) {
                _labstate.text = @"1";
            }else{
                if ([timeCha intValue]>45) {
                    _labstate.text =@"45+";
                    
                }else{
                    
                    _labstate.text =timeCha;
                }
            }
            _VSlab.text = [NSString stringWithFormat:@"%ld:%ld",(long)self.ScoreModel.homescore,(long)self.ScoreModel.guestscore];
            _labstate.textColor = redcolor;
            _VSlab.textColor = greencolor;
            _VSlab.font = [UIFont boldSystemFontOfSize:fontSize17];
            
        }
            break;
        case 2:
        {
            //中场
            _labstate.text = @"中场";
            _VSlab.text = [NSString stringWithFormat:@"%ld:%ld",(long)self.ScoreModel.homescore,(long)self.ScoreModel.guestscore];
            _labstate.textColor = bluecolor;
            _VSlab.textColor = bluecolor;
            _VSlab.font = [UIFont boldSystemFontOfSize:fontSize17];
            
        }
            break;
        case 3:
        {
            //下半场
            NSString *timeCha = [Methods intervalFromLastDateAnd45:_ScoreModel.matchtime2 toTheDate:time];
            if ([timeCha intValue]>90) {
                _labstate.text = @"90+";
            }else if ([timeCha intValue] == 45){
                _labstate.text = @"46";
            }
            else{
                _labstate.text = timeCha;
            }
            _VSlab.text = [NSString stringWithFormat:@"%ld:%ld",(long)self.ScoreModel.homescore,(long)self.ScoreModel.guestscore];
            _labstate.textColor = redcolor;
            _VSlab.textColor = greencolor;
            _VSlab.font = [UIFont boldSystemFontOfSize:fontSize17];
            
            
        }
            break;
        case 4:
        {
            _labstate.text = @"加时";
            _VSlab.text = [NSString stringWithFormat:@"%ld:%ld",(long)self.ScoreModel.homescore,(long)self.ScoreModel.guestscore];
            _labstate.textColor = redcolor;
            _VSlab.textColor = greencolor;
            _VSlab.font = [UIFont boldSystemFontOfSize:fontSize17];
            
        }
            break;
        case -1:
        {
            _labstate.text = @"完场";
            _VSlab.text = [NSString stringWithFormat:@"%ld:%ld",(long)self.ScoreModel.homescore,(long)self.ScoreModel.guestscore];
            _VSlab.textColor = redcolor;
            _labstate.textColor = redcolor;
            _VSlab.font = [UIFont boldSystemFontOfSize:fontSize17];
            
        }
            break;
        case -11:
        {
            _labstate.text = @"待定";
            _VSlab.text = @"vs";
            _VSlab.textColor = redcolor;
            _labstate.textColor = redcolor;
            _VSlab.font = font17;
            
        }
            break;
        case -12:
        {
            _labstate.text = @"腰斩";
            _VSlab.text = @"vs";
            _VSlab.textColor = redcolor;
            _labstate.textColor = redcolor;
            _VSlab.font = font17;
            
        }
            break;
        case -13:
        {
            _labstate.text = @"中断";
            _VSlab.text = @"vs";
            _VSlab.textColor = redcolor;
            _labstate.textColor = redcolor;
            _VSlab.font = font17;
            
        }
            break;
        case -14:
        {
            _labstate.text = @"推迟";
            _VSlab.text = @"vs";
            _VSlab.textColor = redcolor;
            _labstate.textColor = redcolor;
            _VSlab.font = font17;
            
        }
            break;
        case -10:
        {
            _labstate.text = @"取消";
            _VSlab.text = @"vs";
            _VSlab.textColor = redcolor;
            _labstate.textColor = redcolor;
            _VSlab.font = font17;
            
        }
            break;
            
        default:
        {
            _labstate.text = [NSString stringWithFormat:@"%ld", (long)_ScoreModel.matchstate];
            _VSlab.text = @"vs";
            _VSlab.textColor = redcolor;
            _labstate.textColor = redcolor;
            _VSlab.font = font17;
            
            
        }
            break;
    }
    
    //队名最长7个字符 要根据每次的名字长度来计算lab宽度
    NSString *home;
    if (_ScoreModel.hometeam.length>6) {
        home = [NSString stringWithFormat:@"%@…",[_ScoreModel.hometeam substringToIndex:6]];
    }else{
        home = _ScoreModel.hometeam;
    }
    _teamHomeLab.text = home;
    NSString *away;
    if (_ScoreModel.guestteam.length>6) {
        away = [NSString stringWithFormat:@"%@…",[_ScoreModel.guestteam substringToIndex:6]];
        
        //        away = [_ScoreModel.guestteam substringToIndex:6];
    }else{
        away = _ScoreModel.guestteam;
    }
    _teamAwayLab.text = away;
    
    
    
    _listHomeLab.text = @"";
    _listAwayLab.text = @"";

    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"qiuduipaiming"]) {
        
        //排名
        if ((_ScoreModel.homeOrderNum!= nil && ![_ScoreModel.homeOrderNum isEqualToString:@""])) {
            
            NSString *listHome = [NSString stringWithFormat:@"[%@]",_ScoreModel.homeOrderNum] ; //homeOrder

//            for (int i = 0; i < listHome.length; i++) {
//                int a = [listHome characterAtIndex:i];
//                if (a > 0x4e00 && a < 0x9fff) {
//                    a = 0;
//                }
//            }
            _listHomeLab.text = listHome;
            
            NSString *searchText = [NSString stringWithFormat:@"[%@]",_ScoreModel.homeOrderNum];
            NSError *error = NULL;
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*$" options:NSRegularExpressionCaseInsensitive error:&error];
            NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
            if (result) {
                NSLog(@"%@\n", [searchText substringWithRange:result.range]);
            
            }
            
        }else{
            _listHomeLab.text = @"";
            
        }
        
        if ((_ScoreModel.guestOrderNum!= nil && ![_ScoreModel.guestOrderNum isEqualToString:@""])) {
            
            _listAwayLab.text = [NSString stringWithFormat:@"[%@]",_ScoreModel.guestOrderNum]; //guestOrder
            
        }else{
            _listHomeLab.text = @"";
            
        }
    }else{
    
        _listHomeLab.text = @"";
        _listAwayLab.text = @"";
        
        [_listHomeLab mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.width.mas_equalTo(0);
        }];
        [_listAwayLab mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(0);
        }];
        
    }
    
    
    

    
    NSString *documentsPath = [Methods getDocumentsPath];
    NSString *arrayPath = [documentsPath stringByAppendingPathComponent:BifenPageAttentionArray];
    NSMutableArray *attentionArray = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:arrayPath]];
    //为了避免重用,先赋值为NO(图片为clear)
    _attentionBtn.selected = NO;
    for (int i = 0; i<attentionArray.count; i++) {
        
        NSInteger LmodelMid = [[attentionArray objectAtIndex:i] integerValue];
        
        if (LmodelMid == _ScoreModel.mid) {
            _attentionBtn.selected = YES;
            break;
        }else{
            _attentionBtn.selected = NO;
        }
        
    }
    
    
    
    if (!_addLayout) {
        _addLayout = YES;
        [self addAutoLayoutToCell];
    }
    //又没有标记栏
    if (_ScoreModel.remark!= nil && ![_ScoreModel.remark isEqualToString:@""]) {
        
        [self.labRemark mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(28).priority(750);
            
        }];
        self.labRemark.text = _ScoreModel.remark;
    }else{
        [self.labRemark mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0).priority(750);
            
        }];
        
        self.labRemark.text = @"";
    }
    
    
//    if (isNUll(_sortLab.text)) {
//        [self.eventLab mas_remakeConstraints:^(MASConstraintMaker *make) {
////            make.left.equalTo(self.basicView.mas_left).offset(10);
//            make.leading.equalTo(self.timeLab.mas_trailing).offset(4);
////            make.top.equalTo(self.basicView.mas_top).offset(14);
//            make.centerX.equalTo(self.timeLab);
//        }];
//
//    }else{
//        [self.eventLab mas_remakeConstraints:^(MASConstraintMaker *make) {
////            make.left.equalTo(self.basicView.mas_left).offset(10);
//            make.leading.equalTo(self.timeLab.mas_trailing).offset(10);
//            make.top.equalTo(self.sortLab.mas_bottom).offset(2);
//        }];
//    }
//    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"hongpai"]) {
        //红牌
        if (_ScoreModel.homeRed >0) {
            _redHomeLab.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.homeRed];
            [_redHomeLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(8);
                make.right.equalTo(self.listHomeLab.mas_left).offset(-1);

            }];
        }else{
            _redHomeLab.text = @"";
            [_redHomeLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
                make.right.equalTo(self.listHomeLab.mas_left).offset(0);

            }];

        }
        if (_ScoreModel.guestRed>0) {
            _redAwayLab.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.guestRed];
            [_redAwayLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(8);
                make.left.equalTo(self.listAwayLab.mas_right).offset(1);

            }];

        }else{
            _redAwayLab.text = @"";
            [_redAwayLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
                make.left.equalTo(self.listAwayLab.mas_right).offset(0);

            }];

        }
        
        
        //黄牌
        if (_ScoreModel.homeYellow>0) {
            _yellowHomeLab.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.homeYellow];
            [_yellowHomeLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(8);
            }];
            
        }else{
            _yellowHomeLab.text = @"";
            [_yellowHomeLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
            
        }
        if (_ScoreModel.guestYellow>0) {
            _yellowAwayLab.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.guestYellow];
            [_yellowAwayLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(8);
            }];
            
        }else{
            _yellowAwayLab.text = @"";
            [_yellowAwayLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];
            
        }
        
    }else{
        [_redHomeLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
            make.right.equalTo(self.listHomeLab.mas_left).offset(0);

        }];
        [_redAwayLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
            make.left.equalTo(self.listAwayLab.mas_right).offset(0);

        }];

        _redHomeLab.text = @"";
        _redHomeLab.text = @"";
        
        
        [_yellowAwayLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        [_yellowHomeLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        
        _yellowHomeLab.text = @"";
        _yellowAwayLab.text = @"";

    }
    
    /*
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"huangpai"]) {
        //黄牌
        if (_ScoreModel.homeYellow>0) {
            _yellowHomeLab.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.homeYellow];
            [_yellowHomeLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(8);
            }];

        }else{
            _yellowHomeLab.text = @"";
            [_yellowHomeLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];

        }
        if (_ScoreModel.guestYellow>0) {
            _yellowAwayLab.text = [NSString stringWithFormat:@"%ld",(long)_ScoreModel.guestYellow];
            [_yellowAwayLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(8);
            }];

        }else{
            _yellowAwayLab.text = @"";
            [_yellowAwayLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0);
            }];

        }
        
    }else{
        [_yellowAwayLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        [_yellowHomeLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];

        _yellowHomeLab.text = @"";
        _yellowAwayLab.text = @"";
        
    }
     
     */
    if (isNUll(_listHomeLab.text)) {
        _listHomeLab.text = @""; //[-]
    }
    if (isNUll(_listAwayLab.text)) {
        _listAwayLab.text = @""; //[-]
    }

    
    
    
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
//        _basicView.backgroundColor = [UIColor whiteColor];
//        _basicView.layer.borderColor = colorDD.CGColor;
//        _basicView.layer.borderWidth = 0.2;
        //        _basicView.layer.cornerRadius = 2;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toFenxiye)];
        [_basicView addGestureRecognizer:tap];
        
        
        
        [_basicView addSubview:self.imageBg];
        [_basicView addSubview:self.timeLab];
        [_basicView addSubview:self.eventLab];
        [_basicView addSubview:self.imageAnimation];
        [_basicView addSubview:self.VSlab];
        [_basicView addSubview:self.labstate];
        [_basicView addSubview:self.teamHomeLab];
        [_basicView addSubview:self.teamAwayLab];
        [_basicView addSubview:self.pankouLab];
        [_basicView addSubview:self.peiLvHomeLab];
        [_basicView addSubview:self.peilvAwayLab];
        [_basicView addSubview:self.pankouLableft];
        [_basicView addSubview:self.peiLvHomeLableft];
        [_basicView addSubview:self.peilvAwayLableft];
        
        [_basicView addSubview:self.halfScore];
        [_basicView addSubview:self.jiaoqiuScore];
        
//        [_basicView addSubview:self.jianBtn];
//        [_basicView addSubview:self.baoBtn];
        [_basicView addSubview:self.attentionBtn];
        [_basicView addSubview:self.sortLab];
        [_basicView addSubview:self.redHomeLab];
        [_basicView addSubview:self.redAwayLab];
        [_basicView addSubview:self.yellowHomeLab];
        [_basicView addSubview:self.yellowAwayLab];
        [_basicView addSubview:self.listHomeLab];
        [_basicView addSubview:self.listAwayLab];
        [_basicView addSubview:self.labRemark];
        [_basicView addSubview:self.imageJiaoqiu];
        [_basicView addSubview:self.viewline];
        [_basicView addSubview:self.labTJ];
        [_basicView addSubview:self.labTJNum];
        [_basicView addSubview:self.viewLineR];
        [_basicView addSubview:self.labQB];
        [_basicView addSubview:self.labQBNum];
        
        
    }
    return _basicView;
}
- (UIView *)viewline
{
    if (!_viewline) {
        _viewline = [[UIView alloc] init];
        _viewline.backgroundColor = colorDD;
    }
    return _viewline;
}
- (UIImageView *)imageBg
{
    if (!_imageBg) {
        _imageBg = [[UIImageView alloc] init];
        _imageBg.image= [UIImage imageNamed:@"bifenCellbg"];
        
    }
    return _imageBg;
}
- (UIImageView *)imageJiaoqiu
{
    if (!_imageJiaoqiu) {
        _imageJiaoqiu = [[UIImageView alloc] init];
        _imageJiaoqiu.image= [UIImage imageNamed:@"jiaoqiu"];
    }
    return _imageJiaoqiu;
}
- (UILabel *)labQB {
    
    if (!_labQB) {
        _labQB = [[UILabel alloc] init];
        _labQB.text = @"情报";
        _labQB.textColor = color34AAF2;
        _labQB.font = font10;
    }
    return _labQB;
}
- (UILabel *)labQBNum {
    
    if (!_labQBNum) {
        _labQBNum = [[UILabel alloc] init];
        _labQBNum.textColor = color34AAF2;
        _labQBNum.font = font9;
    }
    return _labQBNum;
}
-(UIView *)viewLineR {
    
    if (!_viewLineR) {
        _viewLineR = [[UIView alloc] init];
        _viewline.hidden = YES;
        _viewLineR.backgroundColor = color99;
    }
    return _viewLineR;
}
- (UILabel *)labTJ {
    
    if (!_labTJ) {
        _labTJ = [[UILabel alloc] init];
        _labTJ.text = @"推荐";
        _labTJ.textColor = redcolor;
        _labTJ.font = font10;
    }
    return _labTJ;
}
- (UILabel *)labTJNum {
    
    if (!_labTJNum) {
        _labTJNum = [[UILabel alloc] init];
        _labTJNum.textColor = redcolor;
        _labTJNum.font = font9;
    }
    return _labTJNum;
}
- (UILabel *)sortLab
{
    if (!_sortLab) {
        _sortLab = [[UILabel alloc] init];
        _sortLab.textColor = color66;
        _sortLab.font = font10;
        
    }
    return _sortLab;
}
- (UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.font = font10;
        _timeLab.textColor = color66;
        //        _timeLab.adjustsFontSizeToFitWidth = YES;
    }
    return _timeLab;
}
- (UILabel *)eventLab
{
    if (!_eventLab) {
        _eventLab = [[UILabel alloc] init];
        _eventLab.font = font10;
        _eventLab.textColor = color6C9E1E;
        
        //        _eventLab.adjustsFontSizeToFitWidth = YES;
    }
    return _eventLab;
}

- (UIImageView *)imageAnimation
{
    if (!_imageAnimation) {
        _imageAnimation = [[UIImageView alloc] init];
        _imageAnimation.animationImages = [NSArray arrayWithObjects:[[UIImage imageNamed:@"clear"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],[UIImage imageNamed:@"redRound"], nil];
        _imageAnimation.animationDuration = 1;
        _imageAnimation.animationRepeatCount = MAXFLOAT;
        
    }
    return _imageAnimation;
}
- (UILabel *)VSlab
{
    if (!_VSlab) {
        _VSlab = [[UILabel alloc] init];
        _VSlab.font = font17;
        _VSlab.textAlignment = NSTextAlignmentCenter;
    }
    return _VSlab;
}
- (UILabel *)teamHomeLab
{
    if (!_teamHomeLab) {
        _teamHomeLab = [[UILabel alloc] init];
        _teamHomeLab.textColor = color33;
        _teamHomeLab.font = [UIFont boldSystemFontOfSize:fontSize14];
    }
    
    return _teamHomeLab;
}
- (UILabel *)teamAwayLab
{
    if (!_teamAwayLab) {
        _teamAwayLab = [[UILabel alloc] init];
        _teamAwayLab.textColor = color33;
        _teamAwayLab.font = [UIFont boldSystemFontOfSize:fontSize14];
        
    }
    
    return _teamAwayLab;
}
- (UILabel *)pankouLab
{
    if (!_pankouLab) {
        _pankouLab = [[UILabel alloc] init];
        _pankouLab.textColor = color66;
        _pankouLab.font = font10;
    }
    return _pankouLab;
}
- (UILabel *)peiLvHomeLab
{
    if (!_peiLvHomeLab) {
        _peiLvHomeLab = [[UILabel alloc] init];
        _peiLvHomeLab.textColor = color66;
        _peiLvHomeLab.font = font10;
        
    }
    return _peiLvHomeLab;
}
- (UILabel *)peilvAwayLab
{
    if (!_peilvAwayLab) {
        _peilvAwayLab = [[UILabel alloc] init];
        _peilvAwayLab.textColor = color66;
        _peilvAwayLab.font = font10;
        
    }
    return _peilvAwayLab;
}
- (UILabel *)pankouLableft
{
    if (!_pankouLableft) {
        _pankouLableft = [[UILabel alloc] init];
        _pankouLableft.textColor = color66;
        _pankouLableft.font = font10;
        
    }
    return _pankouLableft;
}
- (UILabel *)peiLvHomeLableft
{
    if (!_peiLvHomeLableft) {
        _peiLvHomeLableft = [[UILabel alloc] init];
        _peiLvHomeLableft.textColor = color66;
        _peiLvHomeLableft.font = font10;
        
    }
    return _peiLvHomeLableft;
}
- (UILabel *)peilvAwayLableft
{
    if (!_peilvAwayLableft) {
        _peilvAwayLableft = [[UILabel alloc] init];
        _peilvAwayLableft.textColor = color66;
        _peilvAwayLableft.font = font10;
        
    }
    return _peilvAwayLableft;
}


- (UILabel *)halfScore
{
    if (!_halfScore) {
        _halfScore = [[UILabel alloc] init];
        _halfScore.textColor = color33;
        _halfScore.font = font10;
    }
    return _halfScore;
}
- (UILabel *)jiaoqiuScore
{
    if (!_jiaoqiuScore) {
        _jiaoqiuScore = [[UILabel alloc] init];
        _jiaoqiuScore.textColor = color99;
        _jiaoqiuScore.font = font10;
        
    }
    return _jiaoqiuScore;
}
- (UILabel *)labstate
{
    if (!_labstate) {
        _labstate = [[UILabel alloc] init];
        _labstate.textColor = color33;
        _labstate.font = font10;
    }
    return _labstate;
}
- (UIButton *)jianBtn
{
    if (!_jianBtn) {
        _jianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _jianBtn.layer.borderColor = colorFEE3E1.CGColor;
        _jianBtn.layer.borderWidth = 0.7;
//        _jianBtn.layer.cornerRadius = 2;
        _jianBtn.titleLabel.font = font10;
        [_jianBtn setTitleColor:redcolor forState:UIControlStateNormal];
        
        //        _jianBtn.layer.masksToBounds = YES;
    }
    return _jianBtn;
}
- (UIButton *)baoBtn
{
    if (!_baoBtn) {
        _baoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _baoBtn.layer.borderColor = colorE4EEFB.CGColor;
        _baoBtn.layer.borderWidth = 0.7;
//        _baoBtn.layer.cornerRadius = 2;
        _baoBtn.titleLabel.font = font10;
        [_baoBtn setTitleColor:color4A90E2 forState:UIControlStateNormal];
        
        //        _baoBtn.layer.masksToBounds = YES;
    }
    return _baoBtn;
}

- (UIButton *)attentionBtn
{
    if (!_attentionBtn) {
        _attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _attentionBtn.selected = NO;
        [_attentionBtn setBackgroundImage:[UIImage imageNamed:@"attentionNew"] forState:UIControlStateSelected];
        [_attentionBtn setBackgroundImage:[UIImage imageNamed:@"noAttentionNew"] forState:UIControlStateNormal];
        
        [_attentionBtn addTarget:self action:@selector(attention:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _attentionBtn;
}



- (UILabel *)redHomeLab
{
    if (!_redHomeLab) {
        _redHomeLab = [[UILabel alloc] init];
//        _redHomeLab.layer.cornerRadius = 1;
//        _redHomeLab.layer.masksToBounds = YES;
        _redHomeLab.font         = font10;
        _redHomeLab.textColor = [UIColor whiteColor];
        _redHomeLab.backgroundColor = redcolor;
        _redHomeLab.textAlignment = NSTextAlignmentCenter;

    }
    return _redHomeLab;
}
- (UILabel *)redAwayLab
{
    if (!_redAwayLab) {
        _redAwayLab = [[UILabel alloc] init];
//        _redAwayLab.layer.cornerRadius = 1;
//        _redAwayLab.layer.masksToBounds = YES;
        _redAwayLab.font         = font10;
        _redAwayLab.backgroundColor = redcolor;
        _redAwayLab.textColor = [UIColor whiteColor];
        _redAwayLab.textAlignment = NSTextAlignmentCenter;
    }
    return _redAwayLab;
}
- (UILabel *)yellowHomeLab
{
    if (!_yellowHomeLab) {
        _yellowHomeLab = [[UILabel alloc] init];
//        _yellowHomeLab.layer.cornerRadius = 1;
//        _yellowHomeLab.layer.masksToBounds = YES;
        _yellowHomeLab.font         = font10;
        _yellowHomeLab.textColor = [UIColor whiteColor];
        _yellowHomeLab.backgroundColor = colorFEC231;
        _yellowHomeLab.textAlignment = NSTextAlignmentCenter;

    }
    return _yellowHomeLab;
}
- (UILabel *)yellowAwayLab
{
    if (!_yellowAwayLab) {
        _yellowAwayLab = [[UILabel alloc] init];
//        _yellowAwayLab.layer.cornerRadius = 1;
//        _yellowAwayLab.layer.masksToBounds = YES;
        _yellowAwayLab.font = font10;
        _yellowAwayLab.textColor = [UIColor whiteColor];
        _yellowAwayLab.backgroundColor = colorFEC231;
        _yellowAwayLab.textAlignment = NSTextAlignmentCenter;

    }
    return _yellowAwayLab;
}
- (UILabel *)listHomeLab
{
    if (!_listHomeLab) {
        _listHomeLab = [[UILabel alloc] init];
        _listHomeLab.font = font10;
        _listHomeLab.textColor= color99;
        //        _listHomeLab.backgroundColor = grayColor3;
    }
    return _listHomeLab;
}
- (UILabel *)listAwayLab
{
    if (!_listAwayLab) {
        _listAwayLab = [[UILabel alloc] init];
        _listAwayLab.textColor = color99;
        _listAwayLab.font = font10;
        //        _listAwayLab.backgroundColor = grayColor3;
        
    }
    return _listAwayLab;
}

- (UILabel *)labRemark
{
    if (!_labRemark) {
        _labRemark = [[UILabel alloc] init];
        _labRemark.textColor = redcolor;
        _labRemark.textAlignment = NSTextAlignmentCenter;
        _labRemark.font = font12;
        _labRemark.backgroundColor= colorFEF1F0;
    }
    return _labRemark;
}


- (void)addAutoLayoutToCell
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    //黄色底图
    [self.imageBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top);
        make.left.equalTo(self.basicView.mas_left);
        make.right.equalTo(self.basicView.mas_right);
        make.bottom.equalTo(self.basicView.mas_bottom);
    }];
    

    //时间
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(10);
//        make.top.equalTo(self.eventLab.mas_bottom).offset(2);
        make.top.equalTo(self.labstate);
    }];
    
    //赛事
    [self.eventLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.timeLab.mas_trailing).offset(4);
//        make.top.equalTo(self.timeLab);
        make.centerY.equalTo(self.timeLab.mas_centerY);
    }];
    
    // 关注
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.jianBtn.mas_top).offset(0);
//        make.centerX.equalTo(self.jianBtn.mas_centerX).offset(-0);
        make.centerX.equalTo(self.timeLab.mas_centerX);
        make.top.equalTo(self.timeLab.mas_bottom).offset(-2);
    }];
    
    //竞彩编号
    [self.sortLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.basicView.mas_top).offset(15);
//        make.left.equalTo(self.basicView.mas_left).offset(10);
        make.centerX.equalTo(self.attentionBtn.mas_centerX);
//        make.left.equalTo(self.timeLab.mas_left);
        make.top.equalTo(self.attentionBtn.mas_bottom).offset(-2);
    }];
    
    //比赛状态
    [self.labstate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(15);
        make.centerX.equalTo(self.basicView.mas_centerX).offset(0);
    }];
    //小红点
    [self.imageAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labstate.mas_right).offset(2);
        make.top.equalTo(self.labstate.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(3, 3));
    }];

    
    

    //VS
    [self.VSlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.teamHomeLab.mas_centerY);
        make.centerX.equalTo(self.basicView.mas_centerX).offset(0);
        make.width.mas_equalTo(38);
    }];
    
    //主队
    [self.teamHomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.VSlab.mas_left).offset(0);
        make.top.equalTo(self.basicView.mas_top).offset(33);
    }];
    //客队
    [self.teamAwayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.VSlab.mas_right).offset(0);
        make.centerY.equalTo(self.teamHomeLab.mas_centerY);
        
    }];

    
    //赔率 ：主队
    [self.peiLvHomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teamAwayLab.mas_left).offset(0);
//        make.top.equalTo(self.basicView.mas_top).offset(15);
        make.top.equalTo(self.teamAwayLab.mas_bottom).offset(3);
    }];
    
    //盘口
    [self.pankouLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.peiLvHomeLab.mas_right).offset(5);
        make.centerY.equalTo(self.peiLvHomeLab.mas_centerY);
    }];
    
    
    //赔率 : 客队
    [self.peilvAwayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pankouLab.mas_right).offset(5);
        make.centerY.equalTo(self.peiLvHomeLab.mas_centerY);
    }];
    
    //赔率 : 左侧 客队
    [self.peilvAwayLableft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.teamHomeLab.mas_right).offset(0);
//        make.top.equalTo(self.basicView.mas_top).offset(15);
//        make.centerY.equalTo(self.peilvAwayLab.mas_centerY);
        make.top.equalTo(self.teamHomeLab.mas_bottom).offset(3);
    }];
    
    //盘口
    [self.pankouLableft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.peilvAwayLableft.mas_left).offset(-5);
        make.centerY.equalTo(self.peilvAwayLableft.mas_centerY);
    }];
    
    //赔率 : 主队 左边
    [self.peiLvHomeLableft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pankouLableft.mas_left).offset(-5);
        make.centerY.equalTo(self.peilvAwayLableft.mas_centerY);
    }];
    
    
    //   []: 主队
    [self.listHomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.teamHomeLab.mas_right);
//        make.top.equalTo(self.teamHomeLab.mas_bottom).offset(3);
        make.trailing.equalTo(self.teamHomeLab.mas_leading);
        make.centerY.equalTo(self.teamHomeLab);
        
    }];

    // 红牌 : 主队
    [self.redHomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.listHomeLab.mas_left).offset(0);
//        make.top.equalTo(self.teamHomeLab.mas_bottom).offset(3);
        make.centerY.equalTo(self.listHomeLab);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(0);
    }];
    //黄牌 : 主队
    [self.yellowHomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.redHomeLab.mas_left).offset(-1);
//        make.top.equalTo(self.teamHomeLab.mas_bottom).offset(3);
        make.centerY.equalTo(self.redHomeLab);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(0);

    }];
    
    //  [] : 客队
    [self.listAwayLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.teamAwayLab.mas_left);
        make.leading.equalTo(self.teamAwayLab.mas_trailing);
//        make.top.equalTo(self.teamHomeLab.mas_bottom).offset(3);
        make.centerY.equalTo(self.teamHomeLab);
    }];

    //红牌 : 客队
    [self.redAwayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.listAwayLab.mas_right).offset(0);
//        make.top.equalTo(self.teamHomeLab.mas_bottom).offset(3);
        make.centerY.equalTo(self.listAwayLab);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(0);

    }];
    //黄牌 : 客队
    [self.yellowAwayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redAwayLab.mas_right).offset(1);
//        make.top.equalTo(self.teamHomeLab.mas_bottom).offset(3);
        make.centerY.equalTo(self.redAwayLab);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(0);

    }];
    
    
    
   /*
    [self.jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-10);
        make.top.equalTo(self.teamHomeLab.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(24, 13));
    }];
    
    [self.baoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.jianBtn.mas_left).offset(-2);
        make.top.equalTo(self.teamHomeLab.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(24, 13));
    }];
    */
   
    
    //半场比分
    [self.halfScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX).offset(0);
        make.top.equalTo(self.teamHomeLab.mas_bottom).offset(3);
        
    }];
    
    //角球的图片
    [self.imageJiaoqiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teamAwayLab.mas_left).offset(0);
        make.centerY.equalTo(self.jiaoqiuScore.mas_centerY);
    }];
    
    //角球
    [self.jiaoqiuScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageJiaoqiu.mas_right).offset(4);
        make.top.equalTo(self.basicView.mas_top).offset(15);
        
    }];
    
    
    //cell 底线
    [self.viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.left.equalTo(self.basicView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 0.6));
    }];
    
    
    //推荐
    [self.labTJ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.basicView).offset(-10);
        make.centerY.equalTo(self.labstate.mas_centerY).offset(2.5);
    }];
    [self.labTJNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.labTJ.mas_centerX);
        make.bottom.equalTo(self.labTJ.mas_top);
    }];
    
    
    [self.viewLineR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.labTJ.mas_leading).offset(-1);
        make.height.mas_equalTo(self.labTJ.mas_height).offset(-4);
        make.centerY.equalTo(self.labTJ);
        make.width.mas_equalTo(1);
    }];
    
    
    //情报
    [self.labQB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.viewLineR.mas_leading).offset(-1);
        make.centerY.equalTo(self.viewLineR);
    }];
    [self.labQBNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.labQB);
        make.bottom.equalTo(self.labQB.mas_top);
    }];
    
    
  
    
    
    //计算cell的高度
    [self.labRemark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(0);
        make.right.equalTo(self.basicView.mas_right).offset(0);
        make.bottom.equalTo(self.basicView.mas_bottom).offset(0);
        make.height.mas_equalTo(0).priority(750);
    }];
}


- (void)attention:(UIButton *)btn
{
    
//    if (![Methods login]) {
//        [Methods toLogin];
//        return;
//    }
    
    //    [NSKeyedArchiver archiveRootObject:_ScoreModel toFile:<#(nonnull NSString *)#>]
    //    本地应该提前存储一个数组,在appdelegate里面存储
    NSString *documentsPath = [Methods getDocumentsPath];
    NSString *arrayPath = [documentsPath stringByAppendingPathComponent:BifenPageAttentionArray];
    NSMutableArray *attentionArray = [[NSMutableArray alloc] initWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:arrayPath]];
    //    NSLog(@"%@",attentionArray);
    if (!btn.selected) {
        
        [attentionArray addObject:[NSString stringWithFormat:@"%ld",_ScoreModel.mid]];
        NSString *info = @"关注成功";//@"关注已取消"
        
//        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:info];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:info];
    }else{
        for (int i = 0; i<attentionArray.count; i++) {
            NSInteger LmodelMid = [[attentionArray objectAtIndex:i] integerValue];
            if (LmodelMid == _ScoreModel.mid) {
                [attentionArray removeObjectAtIndex:i];
                NSString *info = @"关注已取消";
//                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:info];
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:info];

                break;
            }
        }
        
    }
    [NSKeyedArchiver archiveRootObject:attentionArray toFile:arrayPath];
    btn.selected = !btn.selected;
    
    
    
    
    
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"attentionClick" object:nil userInfo:nil];
    
    //    if (_ScoreModel.matchstate == -1) {
    //        return;
    //    }
    //
    
    [self UpdateAttentionWithId:_ScoreModel.mid whetherSelected:btn.selected];
}

- (void)UpdateAttentionWithId:(NSInteger )scheduleId whetherSelected:(BOOL)selected
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)scheduleId] forKey:@"scheduleId"];


    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server, selected? url_attentionSchedule_add :url_attentionSchedule_del] ArrayFile:nil Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {

    } Success:^(id responseResult, id responseOrignal) {
        
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    
    }];
    
}




//- (void)layoutSubviews{
//    [super layoutSubviews];
//    
//    NSLog(@"%f",self.contentView.height);
//}


- (void)toFenxiye
{
    //分析页不显示进球动画
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showJinqiuAnimation"];
    
    
    
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"_currentflag"] isEqualToString:@"0"]) {
//        <#statements#>
//    }
//    
    
//    请求接口进分析页，分析页可以不考虑反转问题
    
    
    NSInteger fenxiIndex = 0;
    
    if (self.ScoreModel.matchstate == 1 || self.ScoreModel.matchstate == 2 ||self.ScoreModel.matchstate == 3 ||self.ScoreModel.matchstate == 4 ||self.ScoreModel.matchstate == -1 ) {
        fenxiIndex = 4;
    }
    
    [self toFenxiWithMatchId:[NSString stringWithFormat:@"%ld",self.ScoreModel.mid] toPageindex:fenxiIndex toItemIndex:0];
}


//loop 跳转分析页
- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    //index 1 基本面 2 情报面 3 推荐
    
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
    }else{
        return;
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    if (idID== nil) {
        idID = @"";
    }
    [parameter setObject:@"3" forKey:@"flag"];
    [parameter setObject:idID forKey:@"sid"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            
            LiveScoreModel *model = [LiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            //从首页跳转分析页的时候不用反转
            model.neutrality = NO;
            FenxiPageVC *fenxiVC = [[FenxiPageVC alloc] init];
            fenxiVC.model = model;
            fenxiVC.currentIndex = pageIndex;
            fenxiVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
            
        }
        _isToFenxi = NO;
        
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _isToFenxi = NO;
        
    }];
    
}





@end
