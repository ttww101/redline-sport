//
//  ZBJiShiPeiLvCell.h
//  GQapp
//
//  Created by Marjoice on 11/08/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBJiShiPeiLvDetailModel.h"

@interface ZBJiShiPeiLvCell : UITableViewCell
@property (nonatomic, strong) ZBJiShiPeiLvDetailModel         *jiShiPeiLvDetailModel;
@property (nonatomic, strong) NSMutableArray               *jsplArr;
@property (nonatomic, strong) NSMutableArray               *jsplTwoArr;

@end
