//
//  DependetNetMethods.m
//  GQapp
//
//  Created by Marjoice on 7/19/17.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "DependetNetMethods.h"
#import "PictureModel.h"

@implementation DependetNetMethods

IMPLEMENTATION_SINGLETON(DependetNetMethods)

#pragma mark -- 截屏分享依赖 (先上传图片)
- (void)uploadImageWithImageArr:(NSArray *)arrImage completion:(void(^)(BOOL finished,NSArray*arrUrl)) completion {

    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:@(3) forKey:@"flag"];
    
    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",@"http://mobile.gunqiu.com/interface",url_ZiXunUrl] ArrayFile:arrImage Start:^(id requestOrignal) {
   
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {

            NSArray *arr = [responseOrignal objectForKey:@"data"];
            NSMutableArray *arrPic = [NSMutableArray array];
            
            for (int i = 0; i < arr.count; i ++) {

                PictureModel *photoModel = [[PictureModel alloc] init];
                photoModel.imgthumburl = responseOrignal[@"data"][i][@"thumb"];
                photoModel.imageurl = responseOrignal[@"data"][i][@"image"];
                [arrPic addObject:photoModel];
            }
            
            completion(YES,arrPic);
        }else{
           
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            completion(NO,[NSArray array]);
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {

        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        completion(NO,[NSArray array]);
        
    }];
}


- (void)loadUserInfocompletion:(void(^)(UserModel *userback))userBack errorMessage:(void(^)(NSString * msg)) errormsg
{
    
    
   UserModel *userModel = [Methods getUserModel];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)userModel.idId] forKey:@"id"];
    
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_userinfo] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        [APPDELEGATE.customTabbar loadUreadNotificationNum];
        
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            
          UserModel  *user = [UserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            
            [Methods updateUsetModel:user];
            userBack(user);
            
        }else{
            errormsg([responseOrignal objectForKey:@"msg"]);
        }
        
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        errormsg(errorDict);

    }];
}

- (void)requestSameOdd_indexStart:(requestStart)start
                              End:(requestEnd)end
                          Success:(requestSuccess)success
                          Failure:(requestFailure)failure
{
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:[HttpString getCommenParemeter] PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_sameOdd_index] Start:start End:end Success:success Failure:failure];
    
}
- (void)requestSameOdd_detailWithscheduleId:(NSString *)scheduleId
                               WithsclassId:(NSString *)sclassId
                                      Start:(requestStart)start
                                        End:(requestEnd)end
                                    Success:(requestSuccess)success
                                    Failure:(requestFailure)failure
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:scheduleId forKey:@"scheduleId"];
    [parameter setObject:sclassId forKey:@"sclassId"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_sameOdd_detail] Start:start End:end Success:success Failure:failure];
}



//爆冷指数
- (void)requeSurprisestatisWithType:(NSString *)type
                              Start:(requestStart)start
                                End:(requestEnd)end
                            Success:(requestSuccess)success
                            Failure:(requestFailure)failure;
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:type forKey:@"mtype"];

    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_surprisestatis] Start:start End:end Success:success Failure:failure];
}

- (void)requestSurpriseWithType:(NSString *)idId
                          Start:(requestStart)start
                            End:(requestEnd)end
                        Success:(requestSuccess)success
                        Failure:(requestFailure)failure
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
    [parameter setObject:idId forKey:@"id"];
    [[DCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_surprise] Start:start End:end Success:success Failure:failure];

}














@end
