//
//  InfoViewModel.h
//  newGQapp
//
//  Created by genglei on 2018/7/17.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestCallBack)(BOOL isSucess, id response);

@interface InfoViewModel : NSObject

- (void)fetchRecommendedReviewsWithParameter:(NSDictionary *)param
                                    callBack:(requestCallBack)response;

@end
