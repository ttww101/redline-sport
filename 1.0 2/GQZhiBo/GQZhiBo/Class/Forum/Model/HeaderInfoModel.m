//
//  HeaderInfoModel.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "HeaderInfoModel.h"

@implementation HeaderInfoModel

- (Layout *)picLayout {
    if (_picLayout == nil) {
        _picLayout = [[Layout alloc]init];
    }
    return _picLayout;
}


- (void)setupInfo {
    if (self.headerHeight > 0) {
        return;
    }
    if (self.content) {
         NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
        muStyle.alignment = NSTextAlignmentLeft;
        [muStyle setLineSpacing:3];
        NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc]initWithString:self.content];
        [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[self.content rangeOfString:self.content]];
        [messageAtt addAttribute:NSForegroundColorAttributeName value:UIColorHex(#828282) range:[self.content rangeOfString:self.content]];
        [messageAtt addAttribute:NSParagraphStyleAttributeName value:muStyle range:[self.content rangeOfString:self.content]];
        self.messageAtt = messageAtt;
        self.messageAttHeight = [self.messageAtt.string boundingRectWithSize:CGSizeMake(Width - 30, CGFLOAT_MAX) font:[UIFont systemFontOfSize:14] lineSpacing:3.0].height + 0.5;
         self.messageAttHeight = 40;
    } else {
        self.messageAttHeight = 0;
    }

    if (self.images) {
        self.picLayout.height = 85;
    } else {
        self.picLayout.height = 0;
    }
    
    self.dateStr = [ZBMethods compareCurrentTime:self.publishTime];
    self.avaterUrl = [NSString stringWithFormat:@"http://mobile.gunqiu.com/avatar/%@",self.userId];
    self.headerHeight = 135 + self.messageAttHeight + self.picLayout.height;
    
}

@end
