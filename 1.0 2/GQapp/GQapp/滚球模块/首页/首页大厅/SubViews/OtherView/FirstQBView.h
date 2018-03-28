//
//  FirstQBView.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/7/3.
//  Copyright © 2017年 GQXX. All rights reserved.
//
//@protocol FirstQBViewDelegate <NSObject>
//
//
//@end

#import <UIKit/UIKit.h>
#import "FirstPInfoListModel.h"


@interface FirstQBView : UICollectionViewCell
@property (nonatomic, strong) FirstPInfoListModel *model;

@end
