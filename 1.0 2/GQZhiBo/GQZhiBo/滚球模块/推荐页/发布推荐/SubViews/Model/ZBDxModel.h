//
//  ZBDxModel.h
//  GunQiuLive
//
//  Created by WQ_h on 16/3/10.
//  Copyright © 2016年 WQ_h. All rights reserved.
//

#import "ZBBasicModel.h"
//大小球
@interface ZBDxModel : ZBBasicModel
//下盘2
@property (nonatomic, strong) NSString *DownOdds;
//上盘0
@property (nonatomic, strong) NSString *UpOdds;
//中间1
@property (nonatomic, strong) NSString *Goal;

//rq
@property (nonatomic, strong) NSString *homeDesc;
@property (nonatomic, strong) NSString *guestDesc;

@property (nonatomic, copy) NSString *company;
@property (nonatomic, strong)NSString *odds;
@end
