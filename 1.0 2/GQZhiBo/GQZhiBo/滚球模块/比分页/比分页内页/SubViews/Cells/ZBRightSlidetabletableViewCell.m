//
//  ZBRightSlidetabletableViewCell.m
//  TestDemo
//
//  Created by Marjoice on 18/09/2017.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import "ZBRightSlidetabletableViewCell.h"
#import "UIView+SDAutoLayout.h"

@interface ZBRightSlidetabletableViewCell ()

@property (nonatomic,strong)UILabel                     * verticalLabel1; //竖线
@property (nonatomic,strong)UILabel                     * verticalLabel2; //竖线
@property (nonatomic,strong)UIButton                    * circleView;     // 圈
@property (nonatomic,strong)UILabel                     * titleLabel;     //标题
@property (nonatomic,strong)UILabel                     * detailLabel;    //描述
@property (nonatomic,strong)UILabel                     * timeLabel;      //时间
@end

@implementation ZBRightSlidetabletableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)initView{
    self.verticalLabel1 = [[UILabel alloc] init];
    self.verticalLabel1.backgroundColor = colorf5f5f5;
    [self.contentView addSubview:self.verticalLabel1];
    
    self.verticalLabel2 = [[UILabel alloc] init];
    self.verticalLabel2.backgroundColor = colorf5f5f5;
    [self.contentView addSubview:self.verticalLabel2];
    
    self.circleView = [UIButton buttonWithType:UIButtonTypeCustom];
    self.circleView.backgroundColor = redcolor;
    self.circleView.layer.borderColor = [UIColor redColor].CGColor;
    self.circleView.layer.cornerRadius = 5;
    self.circleView.layer.borderWidth = 4;
    [self.contentView addSubview:self.circleView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.textColor = color33;
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.timeLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.font = [UIFont systemFontOfSize:12];
    self.detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel];
    
    self.verticalLabel1.sd_layout
    .topEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,PADDING_OF_LEFT_STEP_LINE)
    .widthIs(2)
    .heightIs(10);
    self.verticalLabel2.sd_layout
    .topSpaceToView(self.contentView,10)
    .leftSpaceToView(self.contentView,PADDING_OF_LEFT_STEP_LINE)
    .widthIs(2)
    .bottomEqualToView(self.contentView);
    
    self.circleView.sd_layout
    .centerXEqualToView(self.verticalLabel1)
    .centerYIs(25)
    .heightIs(10)
    .widthIs(10);
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.verticalLabel1,PADDING_OF_LEFT_RIGHT)
    //    .topSpaceToView(self.contentView,3)
    .centerYEqualToView(self.circleView)
//    .heightIs(15)
//    .rightEqualToView(self.contentView);
    .autoHeightRatio(0)
    .rightSpaceToView(self.contentView, PADDING_OF_LEFT_RIGHT);
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.titleLabel,9)
    .leftSpaceToView(self.verticalLabel2,PADDING_OF_LEFT_RIGHT)
    .heightIs(11)
    .rightEqualToView(self.contentView);
    
    self.detailLabel.sd_layout
    .topSpaceToView(self.timeLabel,0)
    .leftSpaceToView(self.verticalLabel2,PADDING_OF_LEFT_RIGHT)
    .widthIs(WIDTH_OF_PROCESS_LABLE)
    .heightIs(30);
}

-(void)setModel:(ZBTimeModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
//    if (model.timeStr) {
//        
//        self.timeLabel.text = [NSString stringWithFormat:@"%@",model.timeStr];
//    }else{
//        
//        self.timeLabel.text = @"";
//    }
//    self.detailLabel.text = model.detailSrtr;
//    if (model.detailSrtr.length > 1) {
//        //描述lab隐藏
//        NSDictionary *fontDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
//        CGSize size1 = CGSizeMake(WIDTH_OF_PROCESS_LABLE,0);
//        CGSize detailStrSize = [model.detailSrtr boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   attributes:fontDic context:nil].size;
//        self.detailLabel.sd_layout
//        .topSpaceToView(self.timeLabel,5)
//        .leftSpaceToView(self.verticalLabel2,PADDING_OF_LEFT_RIGHT)
//        .widthIs(WIDTH_OF_PROCESS_LABLE)
//        .heightIs(detailStrSize.height + 12);
//    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
