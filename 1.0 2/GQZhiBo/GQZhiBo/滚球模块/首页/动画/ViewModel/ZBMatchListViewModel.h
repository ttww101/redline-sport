//
//  ZBMatchListViewModel.h
//  newGQapp
//
//  Created by genglei on 2018/4/2.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBLiveListModel.h"

typedef void (^requestCallBack)(BOOL isSuccess, id response);

@interface ZBMatchListViewModel : NSObject

- (void)fetchMatchDateInterfaceWithParameter:(id)parameter  callBack:(requestCallBack)response;

@end
