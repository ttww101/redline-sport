//
//  ZBTongpeiHistoryCell.m
//  GQapp
//
//  Created by WQ on 2017/8/8.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBTongpeiHistoryCell.h"
@interface ZBTongpeiHistoryCell()

@end
@implementation ZBTongpeiHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setData:(NSString *)data
{
    _data = data;
    
    [self.contentView removeAllSubViews];
    
    for (int i = 0; i<4; i++) {
        
        UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width/4*i, 5, Width/4, 16)];
        labTitle.font = font12;
        labTitle.textColor = color33;
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.text = @"全赛事";
        [self.contentView addSubview:labTitle];
        
        UILabel *labWin = [[UILabel alloc] initWithFrame:CGRectMake(Width/4*i, 17 + 7, Width/4, 12)];
        labWin.font = font12;
        labWin.textColor = color99;
        labWin.textAlignment = NSTextAlignmentCenter;
        labWin.text = @"近10场";
        [self.contentView addSubview:labWin];
        
        
        
        
        
    }

}



















@end
