//
//  MatchListViewModel.m
//  newGQapp
//
//  Created by genglei on 2018/4/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "MatchListViewModel.h"
#import <YYModel/YYModel.h>

@implementation MatchListViewModel

- (void)fetchMatchDateInterfaceWithParameter:(id)parameter  callBack:(requestCallBack)response {
    NSMutableDictionary *baseParameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:baseParameter PathUrlL:[NSString stringWithFormat:@"http://api.live.gunqiu.com:88/radar?action=getDayData&day=%@",parameter] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        LiveListArrayModel *model = [LiveListArrayModel yy_modelWithDictionary:responseOrignal];
        if (response) {
            response(YES, model);
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        if (response) {
            response(false, errorDict);
        }
    }];
}

@end
