//
//  ZBNewRecommandVC.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/4/27.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "ZBBasicViewController.h"
typedef NS_ENUM(NSInteger, typeListNum)
{
    typeListOne = 1,//专家榜
    typeListTwo = 2,//人气榜
    typeListThree = 3,//明灯榜
    typeListFore = 4,//连红榜
    typeListFive = 5,//盈利榜
};


@interface ZBNewRecommandVC : ZBBasicViewController

@property (nonatomic, retain)NSString *titleStr;
@property (nonatomic, assign)typeListNum typeList;

@end
