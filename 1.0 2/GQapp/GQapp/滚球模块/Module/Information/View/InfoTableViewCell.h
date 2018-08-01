//
//  InfoTableViewCell.h
//  newGQapp
//
//  Created by genglei on 2018/7/17.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoModel.h"

@class InfoTableViewCell;

@protocol InfoTableViewCellDelegate <NSObject>

- (void)tableViewCell:(InfoTableViewCell *)cell likeComment:(UIButton *)comment;

- (void)tableViewCell:(InfoTableViewCell *)cell moreComments:(id)moreComments;

@end

@interface InfoTableViewCell : UITableViewCell

@property (nonatomic, weak) id <InfoTableViewCellDelegate> delegate;

@property (nonatomic , strong) InfoGroupModel *model;

+ (InfoTableViewCell *)cellForTableView:(UITableView *)tableView;

+ (CGFloat)heightForCell;

// 隐藏更多回复
- (void)hideMoreReply;

@end
