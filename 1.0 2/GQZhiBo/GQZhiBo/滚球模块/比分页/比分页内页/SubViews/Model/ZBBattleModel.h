//
//  ZBBattleModel.h
//  GQapp
//
//  Created by Marjoice on 10/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"

@interface ZBBattleModel : ZBBasicModel
@property (nonatomic, strong) NSString          *homenumber;
@property (nonatomic, strong) NSString          *guestnumber;
@property (nonatomic, strong) NSString          *homename;
@property (nonatomic, strong) NSString          *guestname;
@property (nonatomic, strong) NSString          *homeplace;
@property (nonatomic, assign) NSInteger         homeplayerid;

@end
