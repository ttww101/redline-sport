//
//  NoticeModel.h
//  GQapp
//
//  Created by WQ_h on 16/4/15.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "BasicModel.h"

@interface NoticeModel : BasicModel
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) BOOL iread;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;

@end
