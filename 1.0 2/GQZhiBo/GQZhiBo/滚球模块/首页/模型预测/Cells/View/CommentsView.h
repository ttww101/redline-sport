//
//  CommentsView.h
//  newGQapp
//
//  Created by genglei on 2018/7/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentsView;

@protocol CommentsViewDelegate <NSObject>

- (void)commentViewDidSelectCommnetList:(CommentsView *)commentView;

- (void)commentViewDidSelectReply:(CommentsView *)commentView;

- (void)commentViewDidSelectShare:(CommentsView *)commentView;

@end

@interface CommentsView : UIView

@property (nonatomic , copy) NSString *newsID;

@property (nonatomic , copy) NSString *module;

- (void)loadData;

@property (nonatomic, weak) id <CommentsViewDelegate> delegate;


@end
