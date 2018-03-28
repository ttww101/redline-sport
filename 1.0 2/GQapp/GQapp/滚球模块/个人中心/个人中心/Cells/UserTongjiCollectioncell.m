//
//  UserTongjiCollectioncell.m
//  GQapp
//
//  Created by WQ on 2017/8/18.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "SymbolsValueFormatter.h"
#import "DateValueFormatter.h"
#import "SetValueFormatter.h"


#import "UserTuijianNumView.h"
#import "RoundUserView.h"
#import "UserTongjiCollectioncell.h"
@interface UserTongjiCollectioncell ()<ChartViewDelegate>
@property (nonatomic,strong) LineChartView * lineView;
@property (nonatomic,strong) UILabel * markY;

@end
@implementation UserTongjiCollectioncell
- (void)setModel:(UserTongjiModel *)model
{
    _model = model;
    
    [self.contentView removeAllSubViews];
    
    CGFloat scaleRoundWidth = 1.0;
    if (isOniPhone4 || isOniPhone5) {
        scaleRoundWidth = 0.9;
    }
    
    RoundUserView *roundWin = [[RoundUserView alloc] initWithFrame:CGRectMake(15, 10, 100*scaleRoundWidth, 100*scaleRoundWidth)];
    roundWin.backgroundColor = [UIColor clearColor];
    roundWin.scaleRound = [_model.winRate floatValue]/100;
    [self.contentView addSubview:roundWin];
    
        
    RoundUserView *roundProfit = [[RoundUserView alloc] initWithFrame:CGRectMake(roundWin.right + 10, 10, 100*scaleRoundWidth, 100*scaleRoundWidth)];
    roundProfit.backgroundColor = [UIColor clearColor];
    roundProfit.scaleRound = [_model.profitRate floatValue]/100;
    [self.contentView addSubview:roundProfit];
    
    
    
    
    
    
    
    
    
    
    UILabel *labWinNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 27*scaleRoundWidth, 90*scaleRoundWidth, 23)];
    labWinNum.center = CGPointMake(roundWin.center.x, labWinNum.center.y);
    if ([_model.winRate floatValue]>0) {
        labWinNum.textColor = redcolor;

    }else{
        labWinNum.textColor = color99;

    }
    labWinNum.textAlignment = NSTextAlignmentCenter;
    labWinNum.font = font25;
    labWinNum.text = [NSString stringWithFormat:@"%@%%",_model.winRate] ;
    [self.contentView addSubview:labWinNum];
    
    UILabel *labWinTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 + 50*scaleRoundWidth + 5, 90, 20)];
    labWinTitle.center = CGPointMake(roundWin.center.x, labWinTitle.center.y);
    labWinTitle.textColor = color99;
    labWinTitle.textAlignment = NSTextAlignmentCenter;
    labWinTitle.font = font17;
    labWinTitle.text = @"胜率";
    [self.contentView addSubview:labWinTitle];

    
    
    UILabel *labProfitNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 27*scaleRoundWidth, 90*scaleRoundWidth, 23)];
    labProfitNum.center = CGPointMake(roundProfit.center.x, labProfitNum.center.y);
    if ([_model.profitRate floatValue]>0) {
        labProfitNum.textColor = redcolor;
        
    }else{
        labProfitNum.textColor = color99;
        
    }
    labProfitNum.textAlignment = NSTextAlignmentCenter;
    labProfitNum.font = font25;
    labProfitNum.text =[NSString stringWithFormat:@"%@%%",_model.profitRate] ;
    [self.contentView addSubview:labProfitNum];
    
    UILabel *labProfitTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10 + 50*scaleRoundWidth + 5, 90*scaleRoundWidth, 20)];
    labProfitTitle.center = CGPointMake(roundProfit.center.x, labProfitTitle.center.y);
    labProfitTitle.textColor = color99;
    labProfitTitle.textAlignment = NSTextAlignmentCenter;
    labProfitTitle.font = font17;
    labProfitTitle.text = @"盈利率";
    [self.contentView addSubview:labProfitTitle];

    
    
    UserTuijianNumView *numV = [[UserTuijianNumView alloc] initWithFrame:CGRectMake(Width - 15 - 100*scaleRoundWidth, 0, 100*scaleRoundWidth, 96)];
//    numV.backgroundColor = colorTableViewBackgroundColor;
    numV.model = _model;
    [self.contentView addSubview:numV];
    
    
    UILabel *labProfitLine = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 100, 35)];
    labProfitLine.text = @"盈利走势";
    labProfitLine.textColor = color66;
    labProfitLine.font = font12;
    [self.contentView addSubview:labProfitLine];
    
    
    
    [self.contentView addSubview:self.lineView];
    
    if (_model.groupTimeStatis.count>0) {
        [self.lineView clearValues];
        self.lineView.data = [self setData];

    }

    
}






- (UILabel *)markY{
    if (!_markY) {
        _markY = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 15)];
        _markY.font = font10;
        _markY.adjustsFontSizeToFitWidth = YES;
        _markY.textAlignment = NSTextAlignmentCenter;
        _markY.text =@"";
        _markY.textColor = redcolor;
        //        _markY.backgroundColor = colorBE;
    }
    return _markY;
}

- (LineChartView *)lineView {
    if (!_lineView) {
        _lineView = [[LineChartView alloc] initWithFrame:CGRectMake(15, 120 + 35, Width - 30, 125)];
        _lineView.delegate = self;//设置代理
//        _lineView.descriptionText = @"描述文字";
        _lineView.chartDescription.text = @"描述文字";
        //        _lineView.backgroundColor =  [UIColor groupTableViewBackgroundColor];
        _lineView.noDataText = @"暂无数据";
        _lineView.legend.enabled = YES; //显示图例说明
        _lineView.chartDescription.enabled = YES;
        _lineView.scaleXEnabled = YES;
        _lineView.scaleYEnabled = NO;//取消Y轴缩放
        _lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _lineView.dragEnabled = YES;//启用拖拽图标
        _lineView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _lineView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        //设置滑动时候标签
        ChartMarkerView *markerY = [[ChartMarkerView alloc]init];
        
        markerY.offset = CGPointMake(-15, -15);
        markerY.chartView = _lineView;
        _lineView.marker = markerY;
        [markerY addSubview:self.markY];
        
        
        
        
        
        _lineView.rightAxis.enabled = NO;//不绘制右边轴
        //        _lineView.rightAxis.drawZeroLineEnabled = YES;
        //        _lineView.rightAxis.zeroLineColor = redcolor;
        ChartYAxis *leftAxis = _lineView.leftAxis;//获取左边Y轴
        leftAxis.drawZeroLineEnabled = NO;
        //        leftAxis.zeroLineColor = color99;
        
        leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
        // leftAxis.axisMinValue = 0;//设置Y轴的最小值
        //leftAxis.axisMaxValue = 105;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor clearColor];//Y轴颜色
        leftAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = color99;//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        leftAxis.gridColor = colorEE;//网格线颜色 横线
        leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
        
        ChartXAxis *xAxis = _lineView.xAxis;
        xAxis.granularityEnabled = NO;//设置重复的值不显示
        xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        xAxis.gridColor = [UIColor clearColor];////网格线颜色 竖线
        xAxis.labelTextColor = color99;//文字颜色
        xAxis.axisLineColor = [UIColor clearColor]; //横轴的颜色
        xAxis.granularity = 1;// 间隔为1
        
        _lineView.maxVisibleCount = 999;//
        //描述及图例样式
//        [_lineView setDescriptionText:@""];
        _lineView.chartDescription.text = @"";
        
        _lineView.legend.enabled = NO;
        
        [_lineView animateWithXAxisDuration:1.0f];
        
    }
    return _lineView;
}


- (LineChartData *)setData{
    
    //每个点的数据
    NSMutableArray *arrValueProfit = [NSMutableArray array];
    //     x轴的数据
    NSMutableArray *arrXlabs = [NSMutableArray array];
    
//    arrXlabs = [NSMutableArray arrayWithArray:@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月",]] ;
//    
//   NSArray *arrValueY  = [NSMutableArray arrayWithArray:@[@"20%",@"40%",@"-20%",@"0%",@"80%",@"20%",@"-20%",@"-40%",@"-20%",@"-20%",@"40%",@"60%",]];
//
//    for (int i = 0; i<arrValueY.count; i++) {
//        
//        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:[[arrValueY objectAtIndex:i] doubleValue]];
//                [arrValueProfit addObject:entry];
//
//    }
    
    
    for (int i = 0; i<_model.groupTimeStatis.count; i++) {
        TotalrateModel *model = [_model.groupTimeStatis objectAtIndex:i];
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:[model.profitRate doubleValue]];
        [arrValueProfit addObject:entry];
        
        if (!model.unitstr) {
            model.unitstr = @"";
        }
        [arrXlabs addObject:model.unitstr];
    }
    _lineView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:arrXlabs];
    
    
    //对应Y轴上面需要显示的数据
    
    
    LineChartDataSet *set1 = nil;
    if (_lineView.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)_lineView.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        set1.values = arrValueProfit;
        set1.valueFormatter = [[SetValueFormatter alloc]initWithArr:arrValueProfit];
        return data;
    }else{
        //创建LineChartDataSet对象
        set1 = [[LineChartDataSet alloc]initWithValues:arrValueProfit label:nil];
        //设置折线的样式
        
        set1.lineWidth = 2.0/[UIScreen mainScreen].scale;//折线宽度
        
        set1.drawValuesEnabled = YES;//是否在拐点处显示数据
        
        
        if (arrValueProfit.count>0) {
            set1.valueFormatter = [[SetValueFormatter alloc]initWithArr:arrValueProfit];
            
        }
        
        
        set1.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
        
        [set1 setColor:redcolor];//折线颜色
        set1.highlightColor = redcolor;
        set1.highlightEnabled = YES; ////选中拐点,是否开启高亮效果(显示十字线)
//        set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        
        //折线拐点样式
        set1.drawCirclesEnabled = YES;//是否绘制拐点
        set1.drawCircleHoleEnabled = YES;
        set1.circleColors = @[redcolor];
        set1.circleRadius = 2;
        //        set1.drawFilledEnabled = YES;//是否填充颜色
        set1.mode = LineChartModeHorizontalBezier;//直线还是曲线
        //        set1.fillColor = redcolorAlpha;
        //        set1.fillAlpha = 1.0;
        
        NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,(id)redcolorAlpha.CGColor];
        CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        set1.fillAlpha = 1.0f;//透明度
        set1.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
        CGGradientRelease(gradientRef);//释放gradientRef
        
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        //添加第二个LineChartDataSet对象
        
        //        NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
        //        for (int i = 0; i <  xVals_count; i++) {
        //            int a = arc4random() % 80;
        //            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:a];
        //            [yVals2 addObject:entry];
        //        }
        //        LineChartDataSet *set2 = [set1 copy];
        //        set2.values = yVals2;
        //        set2.drawValuesEnabled = NO;
        //        [set2 setColor:[UIColor blueColor]];
        //
        //        [dataSets addObject:set2];
        
        
        
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
        
        
        //        最大值的字体和颜色
        [data setValueFont:font11];//文字字体
        [data setValueTextColor:[UIColor clearColor]];//文字颜色
        
        
        return data;
    }
    
}
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    
    _markY.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)entry.y];
    //将点击的数据滑动到中间
    [_lineView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_lineView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
    
    
}
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView {
    
    
}












@end
