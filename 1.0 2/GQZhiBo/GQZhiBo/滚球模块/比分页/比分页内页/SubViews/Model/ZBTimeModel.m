//
//  ZBTimeModel.m
///  TestDemo
//
//  Created by Marjoice on 18/09/2017.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import "ZBTimeModel.h"

@implementation ZBTimeModel

//-(instancetype)initData:(NSDictionary *)dic{
//    if (self=[super init]) {
//        self.timeStr=[dic objectForKey:@"timeStr"];
//        self.titleStr=[dic objectForKey:@"titleStr"];
//        self.detailSrtr=[dic objectForKey:@"detailSrtr"];
//    }
//    return self;
//}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"title" : @"title",
             };
}




@end
