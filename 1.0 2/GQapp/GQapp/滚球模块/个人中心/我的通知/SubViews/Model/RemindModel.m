//
//  RemindModel.m
//  GQapp
//
//  Created by WQ on 16/10/10.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "RemindModel.h"

@implementation RemindModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"time" : @"time" ,
             @"nickname" : @"nickname" ,
             @"mtime" : @"mtime" ,
             @"league" : @"league" ,
             @"hometeam" : @"hometeam" ,
             @"guestteam" : @"guestteam" ,
             @"mid" : @"mid" ,
             @"newsid" : @"newsid" ,
             @"iread" : @"iread" ,
             @"type" : @"type" ,

             };
}
@end
