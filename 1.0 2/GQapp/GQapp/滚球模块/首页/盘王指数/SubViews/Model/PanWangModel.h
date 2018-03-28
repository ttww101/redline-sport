//
//  PanWangModel.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/6/21.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface PanWangModel : BasicModel

@property (nonatomic, assign)NSInteger sid;
@property (nonatomic, retain)NSString *teamname;
@property (nonatomic, retain)NSString *league;
@property (nonatomic, retain)NSString *wwresult;
@property (nonatomic, assign)NSInteger type;


@end
