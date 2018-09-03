#import "ZBBasicViewController.h"
@interface ZBBasicViewController ()<UIGestureRecognizerDelegate>
@end
@implementation ZBBasicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
