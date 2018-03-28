//
//  PanProcessModel.h
//  GQapp
//
//  Created by WQ on 2017/10/13.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface PanProcessModel : BasicModel
@property (nonatomic, strong) NSString *downodds;
@property (nonatomic, strong) NSString *goal;
@property (nonatomic, strong) NSString *upodds;
@property (nonatomic, assign) NSTimeInterval modifyTime;
@end
