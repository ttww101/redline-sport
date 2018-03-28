//
//  LaunchView.m
//  CCAV5
//
//  Created by WQ on 2017/3/29.
//  Copyright © 2017年 Gunqiu. All rights reserved.
//

#import "LaunchView.h"
@interface LaunchView()
//背景图片
@property (nonatomic, strong) UIImageView *imageB;
//中间的图片
@property (nonatomic, strong) UIImageView *imageV;

@end
@implementation LaunchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageB];
        [self addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    [_imageV setImage:[UIImage imageNamed:_imageName]];
    [UIView animateWithDuration:2 delay:1 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        _imageV.alpha = 0;
        _imageB.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];

    
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:_imageUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image) {
            
            
        }else{
            
        }
        
    }];
    

    [UIView animateWithDuration:2 delay:1 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        _imageV.alpha = 0;
        _imageB.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];

    
}

- (UIImageView *)imageB
{
    if (!_imageB) {
        _imageB = [[UIImageView alloc] initWithFrame:self.bounds];
        if (isOniPhone4) {
            _imageB.image = [UIImage imageNamed:@"4"];
            
        }
        else if(isOniPhone5){
            _imageB.image = [UIImage imageNamed:@"5"];
            
        }
        else if(isOniphone6){
            _imageB.image = [UIImage imageNamed:@"6"];
            
        }
        else if(isOniphone6p){
            _imageB.image = [UIImage imageNamed:@"6+"];
            
        }

    }
    return _imageB;
}


- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    return _imageV;
}













@end
