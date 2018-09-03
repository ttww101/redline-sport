//
//  ZBCommentsDetailViewModel.h
//  newGQapp
//
//  Created by genglei on 2018/7/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestCallBack)(BOOL isSucess, id response);

@interface ZBCommentsDetailViewModel : NSObject

- (void)fetchCommentsListWithParams:(NSDictionary *)params callBack:(requestCallBack)response;

@end
