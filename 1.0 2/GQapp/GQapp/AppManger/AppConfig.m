//
//  AppConfig.m
//  newGQapp
//
//  Created by genglei on 2018/4/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "AppConfig.h"
#import "ArchiveFile.h"

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
    NSLog(@"----SandBox%@",[ArchiveFile PreferencePanesDirectory]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
        NSInteger configVerson = [[NSUserDefaults standardUserDefaults]integerForKey:Config_Version];
        [parameter setObject:@"1" forKey:@"platform"];
        [parameter setObject:@(configVerson) forKey:Config_Version];
        [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_ConfigjSon] Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            NSMutableArray *array = responseOrignal[@"pay"];
            NSMutableArray *tabBarArray = responseOrignal[@"tabBar"];
            NSUInteger ver = [responseOrignal[@"ver"] integerValue];
            if (ver > configVerson) {
                [[NSUserDefaults standardUserDefaults]setInteger:ver forKey:Config_Version];
                [[NSUserDefaults standardUserDefaults]synchronize];
                // 配置支付
                if (array) {
                    if (array.count == 0) {
                        [ArchiveFile clearCachesWithFilePath:Buy_Type_Path];
                    } else {
                        [ArchiveFile saveDataWithPath:Buy_Type_Path data:array];
                    }
                }
                
                // 配置tableBar
                if (tabBarArray) {
                    if (tabBarArray.count == 0) {
                        [ArchiveFile clearCachesWithFilePath:TableConfig];
                    } else {
                        [tabBarArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            NSString *imageUrl = obj[@"defaultImage"];
                            NSString *selectImageUrl = obj[@"selectImage"];
                            [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:imageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                
                            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
                            }];
                            [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:selectImageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                
                            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        
                            }];
                            
                        }];
                        [ArchiveFile saveDataWithPath:TableConfig data:tabBarArray];
                    }
                }
            } else {
                
            }
    
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
           
        }];
    });
}


@end
