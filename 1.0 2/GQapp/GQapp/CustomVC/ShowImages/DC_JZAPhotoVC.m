//
//  DC_JZAPhotoVC.m
//  GQapp
//
//  Created by WQ on 16/9/23.
//  Copyright © 2016年 GQXX. All rights reserved.
//

#import "DC_JZAPhotoVC.h"
#import "UIImageView+WebCache.h"
#import "DCPhotoView.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
@interface DC_JZAPhotoVC ()<UIScrollViewDelegate,PhotoViewDelegate>
{
    CGFloat lastScale;
    NSMutableArray *_subViewList;
}
@end

@implementation DC_JZAPhotoVC


- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle

{
    return UIStatusBarStyleLightContent;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _subViewList = [[NSMutableArray alloc] init];

    lastScale = 1.0;
    self.view.backgroundColor = [UIColor blackColor];
    
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapView)];
    //    [self.view addGestureRecognizer:tap];
    
    [self initScrollView];
    [self addLabels];
    [self setPicCurrentIndex:self.currentIndex];
}


-(void)initScrollView{
    //    [[SDImageCache sharedImageCache] cleanDisk];
    //    [[SDImageCache sharedImageCache] clearMemory];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*screen_width, screen_height);
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    //设置放大缩小的最大，最小倍数
    //    self.scrollView.minimumZoomScale = 1;
    //    self.scrollView.maximumZoomScale = 2;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < self.imgArr.count; i++) {
        [_subViewList addObject:[NSNull class]];
    }
    
}

-(void)addLabels{
    self.sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, screen_height-64-49, 60, 30)];
    self.sliderLabel.backgroundColor = [UIColor clearColor];
    self.sliderLabel.textColor = [UIColor whiteColor];
    self.sliderLabel.text = [NSString stringWithFormat:@"%ld/%lu",self.currentIndex+1,(unsigned long)self.imgArr.count];
    [self.view addSubview:self.sliderLabel];
}

-(void)setPicCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.scrollView.contentOffset = CGPointMake(screen_width*currentIndex, 0);
    [self loadPhote:_currentIndex];
    [self loadPhote:_currentIndex+1];
    [self loadPhote:_currentIndex-1];
}

-(void)loadPhote:(NSInteger)index{
    if (index<0 || index >=self.imgArr.count) {
        return;
    }
    
    id currentPhotoView = [_subViewList objectAtIndex:index];
    if (![currentPhotoView isKindOfClass:[DCPhotoView class]]) {
        //url数组
        CGRect frame = CGRectMake(index*_scrollView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        DCPhotoView *photoV = [[DCPhotoView alloc] initWithFrame:frame withPhotoUrl:[self.imgArr objectAtIndex:index]];
        photoV.delegate = self;
        [self.scrollView insertSubview:photoV atIndex:0];
        [_subViewList replaceObjectAtIndex:index withObject:photoV];
    }else{
//        DCPhotoView *photoV = (DCPhotoView *)currentPhotoView;
    }
    
}

#pragma mark - PhotoViewDelegate
-(void)TapHiddenPhotoView{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)OnTapView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//手势
-(void)pinGes:(UIPinchGestureRecognizer *)sender{
    if ([sender state] == UIGestureRecognizerStateBegan) {
        lastScale = 1.0;
    }
    CGFloat scale = 1.0 - (lastScale -[sender scale]);
    lastScale = [sender scale];
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*screen_width, screen_height*lastScale);
    NSLog(@"scale:%f   lastScale:%f",scale,lastScale);
    CATransform3D newTransform = CATransform3DScale(sender.view.layer.transform, scale, scale, 1);
    
    sender.view.layer.transform = newTransform;
    if ([sender state] == UIGestureRecognizerStateEnded) {
        //
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    int i = scrollView.contentOffset.x/screen_width+1;
    [self loadPhote:i-1];
    self.sliderLabel.text = [NSString stringWithFormat:@"%d/%lu",i,(unsigned long)self.imgArr.count];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
