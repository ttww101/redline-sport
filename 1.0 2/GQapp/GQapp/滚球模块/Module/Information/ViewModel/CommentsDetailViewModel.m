//
//  CommentsDetailViewModel.m
//  newGQapp
//
//  Created by genglei on 2018/7/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "CommentsDetailViewModel.h"

@implementation CommentsDetailViewModel

- (void)fetchCommentsListWithParams:(NSDictionary *)params callBack:(requestCallBack)response {
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:params PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,info_url] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            response(true, responseOrignal);
        } else {
            response(false, responseOrignal);
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        response(false, responseOrignal);
    }];
}

@end
