//
//  ZBQingBaoFPTwoModel.m
//  GQapp
//
//  Created by 叶忠阳 on 16/8/17.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBQingBaoFPTwoModel.h"
@implementation ZBQingBaoFPTwoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"sid" : @"sid",
             @"league" : @"league",
             @"leagueId" : @"leagueId",
             @"mtime" : @"mtime",
             @"matchstate" : @"matchstate",
             @"guestteam" : @"guestteam",
             @"guestteamid" : @"guestteamid",
             @"hometeam" : @"hometeam",
             @"hometeamid" : @"hometeamid",
             @"homescore" : @"homescore",
             @"guestscore" : @"guestscore",
             @"newsid" : @"newsid",
             @"choice" : @"choice",
             @"tag" : @"tag",
             @"title" : @"title",
             @"content" : @"content",
             @"upodds":@"upodds",
             @"goals":@"goals",
             @"downodds":@"downodds",
             @"infoCount":@"infoCount",
             @"sort":@"sort",
             @"leagueColor":@"leagueColor",
//             @"matchintro":@"matchintro",
             @"color":@"color",
             @"createtime":@"createtime",
             @"weekDayName":@"weekDayName",
             @"mark":@"mark"
             };
}
//+ (NSValueTransformer *)GuestScoreJSONTransformer
//{
//    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
//        return [NSString stringWithFormat:@"%@",number];
//    }];
//}
//+ (NSValueTransformer *)HomeScoreJSONTransformer
//{
//    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *number) {
//        return [NSString stringWithFormat:@"%@",number];
//    }];
//}
//+ (NSValueTransformer *)arrNewsJSONTransformer
//{
//    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[NewsModel class]];
//    
//}
//+ (NSValueTransformer *)MatchTimeJSONTransformer
//{
//    return [MTLValueTransformer reversibleTransformerWithBlock:^id(NSNumber *nunber) {
//        return [ZBMethods getDateByStyle:dateStyleFormatter withDate:[NSDate dateWithTimeIntervalSince1970:[nunber doubleValue]/1000]];
//    }];
//}


@end
