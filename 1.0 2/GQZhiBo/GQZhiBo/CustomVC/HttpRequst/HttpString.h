//
//  HttpString.h
//  GunQiuLive
//
//  Created by WQ_h on 16/1/27.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpString : NSObject

+ (NSString *)getBackStringByCode:(NSString *)code;
+ (NSDictionary *)getCommenParemeter;
@end
