//
//  CommentsDetailViewController.h
//  newGQapp
//
//  Created by genglei on 2018/7/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "BasicViewController.h"
#import "InfoModel.h"

@interface CommentsDetailViewController : BasicViewController

@property (nonatomic , strong) InfoGroupModel *dataModel;

@property (nonatomic , strong) NSString *ID;

@property (nonatomic , copy) NSString *commentsID;

@property (nonatomic , strong) NSString *module;


@end
