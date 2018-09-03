//
//  ZBInfoViewModel.m
//  newGQapp
//
//  Created by genglei on 2018/7/17.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ZBInfoViewModel.h"


@implementation ZBInfoViewModel

- (void)fetchRecommendedReviewsWithParameter:(NSDictionary *)param
                                    callBack:(requestCallBack)response {
    [[ZBDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:param PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,info_url] Start:^(id requestOrignal) {
        
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
