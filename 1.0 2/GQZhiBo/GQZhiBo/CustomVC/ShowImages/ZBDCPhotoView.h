#import <UIKit/UIKit.h>
@protocol PhotoViewDelegate <NSObject>
-(void)TapHiddenPhotoView;
@end
@interface ZBDCPhotoView : UIView
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, assign) id<PhotoViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame withPhotoUrl:(NSString *)photoUrl;
-(id)initWithFrame:(CGRect)frame withPhotoImage:(UIImage *)image;
@end
