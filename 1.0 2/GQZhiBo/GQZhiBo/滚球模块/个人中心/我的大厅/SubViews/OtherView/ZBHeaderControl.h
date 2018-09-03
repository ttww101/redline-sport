#import <UIKit/UIKit.h>
@interface ZBHeaderControl : UIControl
@property (nonatomic , copy) NSString *content;
- (instancetype)initWithFrame:(CGRect)frame
                      content:(NSString *)content
                showRightLine:(BOOL)show;
@end
