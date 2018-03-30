//
//  NullTableViewCell.m
//  newGQapp
//
//  Created by genglei on 2018/3/30.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "NullTableViewCell.h"

@implementation NullTableViewCell

static CGFloat cell_Height = 5;

static NSString *identifier = @"nullCell";

static CGFloat imageHeight = 40;

+ (NullTableViewCell *)cellForTableView:(UITableView *)tableView {
    NullTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NullTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

#pragma mark - Config UI

- (void)configUI {
    self.contentView.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
}

@end
