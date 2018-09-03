//
//  ZhumaViewOfFabuTuijian.h
//  GQapp
//
//  Created by WQ on 16/11/22.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceListModel.h"
@protocol ZhumaViewOfFabuTuijianDelegate<NSObject>
@optional
- (void)didselectedZhumaAtIndex:(NSInteger)index;
- (void)didselectedPriceViewWithModel:(PriceListModel *)price;

@end
@interface ZhumaViewOfFabuTuijian : UIView
@property (nonatomic, weak) id<ZhumaViewOfFabuTuijianDelegate> delegate;
@property (nonatomic, strong) NSArray *priceList;
@end
