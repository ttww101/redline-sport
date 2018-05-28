//
//  TabbarButton.m
//  newGQapp
//
//  Created by genglei on 2018/5/28.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#define SPACE 3

#import "TabbarButton.h"
#import "ArchiveFile.h"

@interface TabbarButton ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic , copy) NSString *normalImageStr;

@property (nonatomic , copy) NSString *selectedImageStr;

@end

static CGFloat const defultImageSize = 36;
static CGFloat const selectImageSzie = 50;

@implementation TabbarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat imageViewWidth= frame.size.height/2;
        _iconImageView =[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-imageViewWidth)/2, SPACE, imageViewWidth, imageViewWidth)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 25, frame.size.width, 15)];
        self.textLabel.bottom = self.height - 10;
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
        self.textLabel.font=[UIFont systemFontOfSize:10];
        
        [self addSubview:_iconImageView];
        [self addSubview:self.textLabel];
        
        self.flag                    = [CALayer new];
        self.flag.backgroundColor    = [UIColor colorWithRed:255.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1.0].CGColor;
        self.flag.frame              = CGRectMake(self.frame.size.width - 30,
                                                  5,
                                                  7,
                                                  7);
        self.flag.cornerRadius       = 3.5;
        self.flag.hidden             = YES;
        [self.layer addSublayer:self.flag];
    }
    return self;
}

#pragma mark - System Method

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        
        if (self.isLoad) {
            [self setImageWithUrl:_selectedImageStr placeholdImage:self.select];
        } else {
            _iconImageView.image=[UIImage imageNamed:_selectedImageStr];
        }
        self.textLabel.textColor= [UIColor colorWithRed:255.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1.0];
    }
    else
    {
        if (self.isLoad) {
            [self setImageWithUrl:_normalImageStr placeholdImage:self.deflut];
        } else {
            _iconImageView.image = [UIImage imageNamed:_normalImageStr];
        }
        self.textLabel.textColor     = [UIColor darkGrayColor];
    }
    
    [self reloadImageViewSize:selected];
}

- (void)reloadImageViewSize:(BOOL)select {
    
    NSMutableArray *activityArray = [ArchiveFile getDataWithPath:Activity_Path];
    for (NSDictionary *dic in activityArray) {
        if (dic[@"main"]) {
            _iconImageView.frame = CGRectMake((self.width - selectImageSzie) / 2, 0, selectImageSzie, selectImageSzie);
        } else {
             _iconImageView.frame = CGRectMake((self.width - defultImageSize) / 2, 0, defultImageSize, defultImageSize);
        }
    }
    _iconImageView.bottom = self.textLabel.top;

}

- (void)setTabbarImage:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)titleStr
{
    _normalImageStr=image;
    _selectedImageStr=selectedImage;
    if (self.isLoad) {
        [self setImageWithUrl:image placeholdImage:self.select];
    } else {
        _iconImageView.image=[UIImage imageNamed:image];
    }
    self.textLabel.text=titleStr;
}

- (void)setImageWithUrl:(NSString *)url placeholdImage:(NSString *)defuatImage {
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
    if (image) {
        [_iconImageView setImage:image];
    } else {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:defuatImage]];
    }
}

- (NSMutableAttributedString *)mutableAttributedStringWithText:(NSString *)tt textSize:(float)ts color:(UIColor *)cl
{
    NSMutableAttributedString *strAttribude = [[NSMutableAttributedString alloc] initWithString:tt];
    [strAttribude addAttribute:NSForegroundColorAttributeName value:cl range:NSMakeRange(0, tt.length)];
    [strAttribude addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, tt.length)];
    return strAttribude;
}

@end
