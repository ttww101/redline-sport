//
//  ZBStartViewController.m
//  newGQapp
//
//  Created by genglei on 2018/5/3.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ZBStartViewController.h"

@interface ZBStartViewController ()

@property (nonatomic, strong)  UIImageView *launchImageView;


@end

@implementation ZBStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.launchImageView];
    [self.launchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//通过便利沙盒获得启动图，也可以直接用启动图名字
-(UIImage *)launchImage{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";//横屏
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict){
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){
            launchImageName = dict[@"UILaunchImageName"];
            UIImage *image = [UIImage imageNamed:launchImageName];
            return image;
        }
    }
    return nil;
}

#pragma mark - Setter

- (UIImageView *)launchImageView {
    if (_launchImageView == nil) {
        _launchImageView = [UIImageView new];
        _launchImageView.image = [self launchImage];
        _launchImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _launchImageView;
}

@end
