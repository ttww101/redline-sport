//
//  ZBDataModelViewofFP.h
//  GQapp
//
//  Created by WQ on 2017/10/24.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DataModelViewofFPDelegate <NSObject>
@optional
- (void)dataModelViewofFPDidSelectedAtIndex:(NSInteger)index;
@end
@interface ZBDataModelViewofFP : UIView
@property (nonatomic, weak) id<DataModelViewofFPDelegate> delagate;
@end
