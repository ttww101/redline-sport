#import <UIKit/UIKit.h>
@interface ZBItemControl : UIControl
- (instancetype)initWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
                        title:(NSString *)title
                       amount:(NSString *)amount;
@end
