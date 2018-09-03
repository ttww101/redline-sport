//
//  ZBJiShiPeiLvDetailModel.h
//  GQapp
//
//  Created by Marjoice on 11/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"

//除去第一个cell 的model
@interface ZBJiShiPeiLvDetailModel : ZBBasicModel
@property (nonatomic, strong) NSString           *miniTime;
@property (nonatomic, strong) NSString           *score;
@property (nonatomic, strong) NSString           *homeOdds0;
@property (nonatomic, strong) NSString           *panKou0;
@property (nonatomic, strong) NSString           *awayOdds0;
@property (nonatomic, strong) NSString           *homeOdds;
@property (nonatomic, strong) NSString           *panKou;
@property (nonatomic, strong) NSString           *awayOdds;

@end
