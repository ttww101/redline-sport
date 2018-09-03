#import <UIKit/UIKit.h>
@protocol DataModelViewDelegate<NSObject>
@optional
- (void)didSelectedDataModelViewIndex:(NSInteger)index;
@end
@interface ZBDataModelView : UIView
@property (nonatomic, weak) id<DataModelViewDelegate> delegate;
@end
