//
//  PivView.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "PicView.h"
#import "YYPhotoGroupView.h"

@implementation PicView

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self removeAllSubviews];
    CGFloat imageWidth = 0;
    CGFloat viewWidth = Width - 30;
    if (_dataSource.count == 1) {
        imageWidth = viewWidth;
    } else if (_dataSource.count == 2) {
        imageWidth = (viewWidth - 10) / 2;
    } else if (_dataSource.count == 3) {
        imageWidth = (viewWidth - 20) / 3;
    }
    
    for (NSInteger i = 0; i < _dataSource.count; i ++) {
        BaseImageView *imageView = [[BaseImageView alloc]init];
        [imageView setImageWithUrl:[NSURL URLWithString:_dataSource[i]] placeholder:[UIImage imageNamed:@""]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = true;
        imageView.userInteractionEnabled = true;
        imageView.tag = i;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.mas_equalTo(imageWidth);
            make.left.equalTo(self.mas_left).offset(i * (imageWidth + 10));
        }];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
        [imageView addGestureRecognizer:singleTap];
    }
    
    
}

-(void)tapImageAction:(UITapGestureRecognizer *)tap{
     BaseImageView *tapView = (BaseImageView *)tap.view;
    NSArray *imageViews = self.subviews;
     UIView *fromView = nil;
     NSMutableArray *items = [NSMutableArray new];
    for (NSInteger i = 0; i < self.dataSource.count; i ++ ) {
        BaseImageView *imgView = imageViews[i];
        YYPhotoGroupItem *item = [YYPhotoGroupItem new];
        item.thumbView = imgView;
        item.largeImageURL = [NSURL URLWithString:self.dataSource[i]];
        [items addObject:item];
        if (tapView.tag == i) {
            fromView = tapView;
        }
    }
    YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:items];
    [v presentFromImageView:fromView toContainer:[ZBMethods help_getCurrentVC].navigationController.view animated:YES completion:nil];
   
}

@end
