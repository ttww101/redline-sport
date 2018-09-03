//
//  ZBTokenModel.h
//  GQapp
//
//  Created by Marjoice on 13/09/2017.
//  Copyright © 2017 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBTokenModel : ZBBasicModel
@property (nonatomic, strong)NSString *token;
@property (nonatomic, strong)NSString *refreshToken;

@end
