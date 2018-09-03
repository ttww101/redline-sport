//
//  ZBToAnalystsVC.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/4/26.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBasicViewController.h"

@interface ZBToAnalystsVC : ZBBasicViewController


@property (nonatomic, strong)ZBUserModel *model;
@property (nonatomic, assign)NSInteger type;//判断分析师的状态  0:不是      5：是        2：正在审核       3：拒绝默认    1:以前的分析师

@end
