//
//  ZBUMStatisticsMgr.h
//  GQapp
//
//  Created by Marjoice on 23/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBUMStatisticsMgr : NSObject

INTERFACE_SINGLETON(ZBUMStatisticsMgr)
- (void)viewStaticsBeginWithMarkStr:(NSString *)markStr;
- (void)viewStaticsEndWithMarkStr:(NSString *)markStr;
@end
