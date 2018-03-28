//
//  ZhiboTableView.h
//  GQapp
//
//  Created by WQ on 2017/8/11.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "BasicTableView.h"
#import "LiveScoreModel.h"
#import "SRWebSocket.h"
@interface ZhiboTableView : UITableView
@property (nonatomic, strong) LiveScoreModel *model;
@property (nonatomic,strong) SRWebSocket*webSocket;
@property (nonatomic, assign) BOOL cellCanScroll;

- (void)addSegMent;

@end
