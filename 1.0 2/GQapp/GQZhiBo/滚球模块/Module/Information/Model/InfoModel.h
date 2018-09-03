//
//  InfoModel.h
//  newGQapp
//
//  Created by genglei on 2018/7/17.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class InfoGroupModel;

@interface InfoModel : NSObject

@property (nonatomic , strong) NSMutableArray<InfoGroupModel *> *data;

@end

@interface InfoGroupModel : NSObject

@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, copy) NSString *commentId;

@property (nonatomic , copy) NSString *content;

@property (nonatomic , copy) NSString *date;

@property (nonatomic, assign) NSInteger likeCount;

@property (nonatomic , copy) NSString *nickname;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) BOOL liked;

@property (nonatomic , copy) NSString *newsId;

@end



