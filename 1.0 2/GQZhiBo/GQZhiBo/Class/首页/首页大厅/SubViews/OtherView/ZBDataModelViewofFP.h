#import <UIKit/UIKit.h>
@protocol DataModelViewofFPDelegate <NSObject>
@optional
- (void)dataModelViewofFPDidSelectedAtIndex:(NSInteger)index;
@end
@interface ZBDataModelViewofFP : UIView
@property (nonatomic, weak) id<DataModelViewofFPDelegate> delagate;
@end
