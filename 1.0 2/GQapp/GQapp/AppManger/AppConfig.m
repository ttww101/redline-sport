//
//  AppConfig.m
//  newGQapp
//
//  Created by genglei on 2018/4/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "AppConfig.h"
#import "ArchiveFile.h"
#import <AdSupport/AdSupport.h>

#define Config_Version @"configVersion"

@implementation AppConfig

+ (instancetype)shareInstance {
    static AppConfig *manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[self alloc]init];
    });
    return manger;
}

- (void)initialize {
    NSLog(@"----SandBox     %@",[ArchiveFile LibraryDirectory]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[HttpString getCommenParemeter]];
        [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveQuiz] Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            NSString *code = responseOrignal[@"code"];
            if ([code isEqualToString:@"200"]) {
                NSMutableArray *dataArray = responseOrignal[@"data"];
                if (dataArray.count == 0) {
                    [ArchiveFile clearCachesWithFilePath:Activity_Path];
                } else {
                   [ArchiveFile saveDataWithPath:Activity_Path data:dataArray];
                }
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    
        }];
        
        
        [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_update] Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            NSString *code = responseOrignal[@"code"];
            if ([code isEqualToString:@"200"]) {
                NSDictionary *dic = responseOrignal[@"data"];
                NSString *messageTitle = dic[@"title"];
                NSString *content = dic[@"content"];
                NSString *url = dic[@"downloadurl"];
                NSInteger isforced = [dic[@"isforced"] integerValue];
                NSString *version = dic[@"version"];
                NSString *localVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
                if (![version isEqualToString:localVersion]) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:messageTitle message:content preferredStyle:UIAlertControllerStyleAlert];
                    if (isforced == 0) {
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                        }];
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        [alertController addAction:okAction];           // A
                        [alertController addAction:cancelAction];
                    } else {
                        
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                            
                        }];
                        [alertController addAction:okAction];
                    }
                    [APPDELEGATE.customTabbar presentViewController:alertController animated:YES completion:nil];
                }
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
        }];
        

        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        [parameter setObject:idfa forKey:@"idfa"];
        [[DCHttpRequest shareInstance]sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_idfa] ArrayFile:nil Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            NSLog(@"sucess");
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            NSLog(@"failure");
        }];
        
    });
    

    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *agent = [NSString stringWithFormat:@"newGQapp/%@",version];
    NSString *newAgent = [oldAgent stringByAppendingString:agent];
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    
}

@end
