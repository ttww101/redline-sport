//
//  ZBUMStatisticsMgr.m
//  GQapp
//
//  Created by Marjoice on 23/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "ZBUMStatisticsMgr.h"

@implementation ZBUMStatisticsMgr

IMPLEMENTATION_SINGLETON(ZBUMStatisticsMgr)

#pragma mark - ViewStatics -
- (void)viewStaticsBeginWithMarkStr:(NSString *)markStr {
    
    [MobClick beginLogPageView:markStr];
}
- (void)viewStaticsEndWithMarkStr:(NSString *)markStr {
    
    [MobClick endLogPageView:markStr];
}


#pragma mark - ClickEvent -

@end
