//
//  ZBDCHttpRequest.h
//  GunQiuLive
//
//  Created by WQ_h on 15/12/11.
//  Copyright (c) 2015年 WQ_h. All rights reserved.
//
typedef NS_ENUM(NSInteger, loadDataType)
{
    loadDataFirst = 1,
    loadDataByindex = 2,
    loadDataByorderindex = 3,
    loadDataMoredata =4,
    loadDataHeaderRefesh = 5,
    loadDataReload = 6,
};
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "MBProgressHUD.h"
typedef void(^requestStart)(id requestOrignal);
typedef void(^requestEnd)(id responseOrignal);
typedef void(^requestSuccess)(id responseResult,id responseOrignal);
typedef void(^requestFailure)(NSError *error, NSString *errorDict,id responseOrignal);
@interface ZBDCHttpRequest : NSObject
@property (nonatomic, copy) NSString        *contentType;
+ (ZBDCHttpRequest *)shareInstance;
//post 请求
- (void)sendRequestByMethod:(NSString *)post
             WithParamaters:(NSDictionary *)parameters
                   PathUrlL:(NSString *)pathUrl
                  ArrayFile:(NSArray *)arrayFile
                      Start:(requestStart)start
                        End:(requestEnd)end
                    Success:(requestSuccess)success
                    Failure:(requestFailure)failure;
//get请求
- (void)sendGetRequestByMethod:(NSString *)post
                WithParamaters:(NSDictionary *)parameters
                      PathUrlL:(NSString *)pathUrl
                         Start:(requestStart)start
                           End:(requestEnd)end
                       Success:(requestSuccess)success
                       Failure:(requestFailure)failure;

- (void)sendHtmlGetRequestByMethod:(NSString *)post
                WithParamaters:(NSDictionary *)parameters
                      PathUrlL:(NSString *)pathUrl
                         Start:(requestStart)start
                           End:(requestEnd)end
                       Success:(requestSuccess)success
                       Failure:(requestFailure)failure;

//上传图片
- (void)sendRequestByMethod:(NSString *)post
             WithParamaters:(NSDictionary *)parameters
                   PathUrlL:(NSString *)pathUrl
                  ArrayFile:(NSArray *)arrayFile
                   FileName:(NSString *)filename
                      Start:(requestStart)start
                        End:(requestEnd)end
                    Success:(requestSuccess)success
                    Failure:(requestFailure)failure;

@end


























