//
//  CommentModel.h
//  GunQiuLive
//
//  Created by WQ_h on 16/3/17.
//  Copyright © 2016年 WQ_h. All rights reserved.
//
//评论
#import "BasicModel.h"

@interface CommentModel : BasicModel
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, copy) NSString *userpic;
@property (nonatomic, assign) NSInteger Idid;
@property (nonatomic, assign) NSInteger news_id;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, strong) NSArray *child;
@property (nonatomic, assign) BOOL showMoreCommentChild;
@property (nonatomic, assign) NSInteger ilike;


@end
