//
//  ZBFeedBackModel.h
//  GQapp
//
//  Created by Marjoice on 21/09/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"

@interface ZBFeedBackModel : ZBBasicModel
@property (nonatomic, strong) NSString                  *time;
@property (nonatomic, strong) NSString                  *title;
@property (nonatomic, strong) NSString                  *content;
@property (nonatomic, strong) NSString                  *reply;

@end
