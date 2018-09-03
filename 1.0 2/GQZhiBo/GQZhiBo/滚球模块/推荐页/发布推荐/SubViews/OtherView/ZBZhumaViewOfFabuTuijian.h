//
//  ZBZhumaViewOfFabuTuijian.h
//  GQapp
//
//  Created by WQ on 16/11/22.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBPriceListModel.h"
@protocol ZhumaViewOfFabuTuijianDelegate<NSObject>
@optional
- (void)didselectedZhumaAtIndex:(NSInteger)index;
- (void)didselectedPriceViewWithModel:(ZBPriceListModel *)price;

@end
@interface ZBZhumaViewOfFabuTuijian : UIView
@property (nonatomic, weak) id<ZhumaViewOfFabuTuijianDelegate> delegate;
@property (nonatomic, strong) NSArray *priceList;
@end
