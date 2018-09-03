//
//  ZBRecommandListModel.h
//  GQapp
//
//  Created by WQ_h on 16/7/6.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "ZBBasicModel.h"

@interface ZBRecommandListModel : ZBBasicModel
//名次
@property (nonatomic, copy) NSString *rank;
//昵称
@property (nonatomic, copy) NSString *nickname;
//发布场数
@property (nonatomic, copy) NSString *realnums;
//盈利率
@property (nonatomic, copy) NSString *casua;
@property (nonatomic, copy)NSString *casuatwo;//胜率
@property (nonatomic, copy) NSString *createtime;
//时间
@property (nonatomic, copy) NSString *datestr;
//头像
@property (nonatomic, copy) NSString *extension2;

//是否关注0-关注  1-关注
@property (nonatomic, assign) NSInteger extension1;
//唯一标识,
@property (nonatomic, assign) NSInteger idId;
//玩法
@property (nonatomic, assign) NSInteger play;
//业务类型
@property (nonatomic, assign) NSInteger ranktype;
//用户id
@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, assign) NSInteger sclassid;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *usertitle;
//头衔
@property (nonatomic, strong) NSArray *medals;


@property (nonatomic, assign) NSInteger winNum;
@property (nonatomic, assign) NSInteger goNum;
@property (nonatomic, assign) NSInteger loseNum;



@end
