//
//  ZBBasicTableView.h
//  GQapp
//
//  Created by WQ_h on 16/5/10.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, defaultPage)
{
    defaultPageZero = 0,
    defaultPageFirst = 1,
    defaultPageSecond = 2,
    defaultPageThird = 3,
    defaultPageForth =4,
    defaultPageFifth = 5
};
@interface ZBBasicTableView : UITableView
@property (nonatomic, assign)defaultPage defaultPage;
@property (nonatomic, assign) NSString *defaultTitle;

@end
