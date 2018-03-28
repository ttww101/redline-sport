//
//  SuccessfulView.h
//  GQapp
//
//  Created by 叶忠阳 on 2017/5/4.
//  Copyright © 2017年 GQXX. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol SuccessfulViewDelegate <NSObject>

-(void)backView;

@end


@interface SuccessfulView : UIView

@property (nonatomic, strong)UIImageView *img;
@property (nonatomic, retain)NSString *imgStr;//图片名称
@property (nonatomic, strong)UILabel *labSucc;//申请成功
@property (nonatomic, strong)UILabel *labContent;//描述
@property (nonatomic, assign)NSInteger type;//1:分析师
@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)UILabel *labContentTwo;

@property (nonatomic, assign)id<SuccessfulViewDelegate> delegate;

@end
