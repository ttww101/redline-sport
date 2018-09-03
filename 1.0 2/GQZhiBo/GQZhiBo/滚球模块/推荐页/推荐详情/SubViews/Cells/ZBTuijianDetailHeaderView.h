//
//  ZBTuijianDetailHeaderView.h
//  GQapp
//
//  Created by WQ_h on 16/8/3.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBTuijiandatingModel.h"
typedef NS_ENUM(NSInteger,TuijianDetailHeaderViewtype)
{
    TuijianDetailHeaderViewShowContent = 1,
    TuijianDetailHeaderViewHideContent = 0,

};
@interface ZBTuijianDetailHeaderView : UITableViewCell
@property (nonatomic, assign) CGFloat webViewHight;
@property (nonatomic) TuijianDetailHeaderViewtype type;
@property (nonatomic, strong) ZBTuijiandatingModel *model;
@end
