//
//  CommentChildModel.h
//  GQapp
//
//  Created by WQ on 16/10/26.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface CommentChildModel : BasicModel
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, assign) NSInteger toUserid;
@property (nonatomic, copy) NSString *toUsername;
@property (nonatomic, assign) NSInteger Idid;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, assign) NSInteger ilike;


@end
