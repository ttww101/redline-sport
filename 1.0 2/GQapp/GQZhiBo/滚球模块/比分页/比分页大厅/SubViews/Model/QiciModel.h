//
//  QiciModel.h
//  GunQiuLive
//
//  Created by WQ_h on 16/3/2.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "BasicModel.h"

@interface QiciModel : BasicModel
@property (nonatomic, assign) NSInteger iscurrent;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain)NSString *date;
@property (nonatomic, retain)NSString *week;
@property (nonatomic, retain)NSString *time;
@end
