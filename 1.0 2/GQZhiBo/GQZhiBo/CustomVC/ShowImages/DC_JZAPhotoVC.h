//
//  DC_JZAPhotoVC.h
//  GQapp
//
//  Created by WQ on 16/9/23.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DC_JZAPhotoVC : UIViewController

/**
 *  接收图片数组，数组类型可以是url数组，image数组
 */
@property(nonatomic, strong) NSMutableArray *imgArr;
/**
 *  显示scrollView
 */
@property(nonatomic, strong) UIScrollView *scrollView;
/**
 *  显示下标
 */
@property(nonatomic, strong) UILabel *sliderLabel;
/**
 *  接收当前图片的序号,默认的是0
 */
@property(nonatomic, assign) NSInteger currentIndex;

@end
