//
//  PanWangModel.m
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/21.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "PanWangModel.h"

@implementation PanWangModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sid":@"sid",
             @"teamname":@"teamname",
             @"wwresult":@"wwresult",
             @"league":@"league",
             @"type":@"type",
             };
}
@end
