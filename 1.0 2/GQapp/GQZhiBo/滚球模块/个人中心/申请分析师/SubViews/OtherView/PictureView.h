//
//  PictureView.h
//  GQapp
//
//  Created by WQ on 2017/7/25.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureView : UIView
@property (nonatomic, strong) NSString *detailText;
//传到服务器上的图片
@property (nonatomic, strong) UIImage *imageSave;
//页面上的图片
@property (nonatomic, strong) NSString *imagePicUrl;

@end
