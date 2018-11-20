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
    if (self.message) {
         NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
        muStyle.alignment = NSTextAlignmentLeft;
        [muStyle setLineSpacing:3];
        NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc]initWithString:self.message];
        [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[self.message rangeOfString:self.message]];
        [messageAtt addAttribute:NSForegroundColorAttributeName value:UIColorHex(#828282) range:[self.message rangeOfString:self.message]];
        [messageAtt addAttribute:NSParagraphStyleAttributeName value:muStyle range:[self.message rangeOfString:self.message]];
        self.messageAtt = messageAtt;
        self.messageAttHeight = [self.messageAtt.string boundingRectWithSize:CGSizeMake(Width - 30, CGFLOAT_MAX) font:[UIFont systemFontOfSize:14] lineSpacing:3.0].height + 0.5;
    } else {
        self.messageAttHeight = 0;
    }

    if (self.pics) {
        self.picLayout.height = 85;
    } else {
        self.picLayout.height = 0;
    }
    
    self.headerHeight = 135 + self.messageAttHeight + self.picLayout.height;
    
}

@end
