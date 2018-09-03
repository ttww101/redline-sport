//
//  ZBDCPhotoView.h
//  GQapp
//
//  Created by WQ on 16/9/23.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoViewDelegate <NSObject>

//点击图片时，隐藏图片浏览器
-(void)TapHiddenPhotoView;

@end
@interface ZBDCPhotoView : UIView

/**
 *  添加的图片
 */
@property(nonatomic, strong) UIImageView *imageView;
//2.
/**
 *  代理
 */
@property(nonatomic, assign) id<PhotoViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame withPhotoUrl:(NSString *)photoUrl;

-(id)initWithFrame:(CGRect)frame withPhotoImage:(UIImage *)image;


@end
