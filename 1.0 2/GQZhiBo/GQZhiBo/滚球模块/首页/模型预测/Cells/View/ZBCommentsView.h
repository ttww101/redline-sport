//
//  ZBCommentsView.h
//  newGQapp
//
//  Created by genglei on 2018/7/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZBCommentsView;

@protocol CommentsViewDelegate <NSObject>

- (void)commentViewDidSelectCommnetList:(ZBCommentsView *)commentView;

- (void)commentViewDidSelectReply:(ZBCommentsView *)commentView;

- (void)commentViewDidSelectShare:(ZBCommentsView *)commentView;

@end

@interface ZBCommentsView : UIView

@property (nonatomic , copy) NSString *newsID;

@property (nonatomic , copy) NSString *module;

- (void)loadData;

@property (nonatomic, weak) id <CommentsViewDelegate> delegate;


@end
