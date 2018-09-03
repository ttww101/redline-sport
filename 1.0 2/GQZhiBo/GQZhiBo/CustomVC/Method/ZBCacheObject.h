//
//  ZBCacheObject.h
//  HuanCunDome
//
//  Created by 叶忠阳 on 16/7/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBCacheObject : NSObject
+(id)judge_In_MemoryToUrlKey:(NSString *)urlKey;//判断数据是否存在
+(void)storage_Memory_UrlKey:(NSString *)urlKey data:(id)Data hour:(NSInteger)hour;//存数据
+ (void)delete_Data_urlKey:(NSString *)urlKey;
@end
