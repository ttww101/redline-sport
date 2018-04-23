//
//  AppConfig.m
//  newGQapp
//
//  Created by genglei on 2018/4/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "AppConfig.h"
#import "ArchiveFile.h"

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
        [parameter setObject:@"1" forKey:@"paltform"];
        [[DCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_ConfigjSon] Start:^(id requestOrignal) {
            
        } End:^(id responseOrignal) {
            
        } Success:^(id responseResult, id responseOrignal) {
            NSMutableArray *array = responseOrignal[@"pay"];
            if (array.count == 0) {
                [ArchiveFile clearCachesWithFilePath:Buy_Type_Path];
            } else {
                [ArchiveFile saveDataWithPath:Buy_Type_Path data:array];
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
           
        }];
    });
}


@end