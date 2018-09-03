//
//  ZBMineModel.h
//  newGQapp
//
//  Created by genglei on 2018/4/27.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBMineModel : NSObject

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString *leftContent;

@property (nonatomic, copy) NSString *rightContent;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString *leftImageName;

/**
 <#Description#>
 */
@property (nonatomic, copy) NSString *rightImageName;

@end

@interface GQMineGroupModel : NSObject

@property (nonatomic, strong) NSMutableArray *groupArray;

@end
