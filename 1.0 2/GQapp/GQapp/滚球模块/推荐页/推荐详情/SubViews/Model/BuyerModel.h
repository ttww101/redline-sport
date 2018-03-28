//
//  BuyerModel.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/7/26.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface BuyerModel : BasicModel

@property (nonatomic, strong)NSString *extension2;
@property (nonatomic, strong)NSString *created;
@property (nonatomic, assign)NSInteger userId;
@property (nonatomic, strong)NSString *nickname;

@end
