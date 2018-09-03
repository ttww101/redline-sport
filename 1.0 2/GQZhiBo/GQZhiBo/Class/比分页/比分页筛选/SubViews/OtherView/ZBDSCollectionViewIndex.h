#import <UIKit/UIKit.h>
@class ZBDSCollectionViewIndex;
@protocol DSCollectionViewIndexDelegate <NSObject>
-(void)collectionViewIndex:(ZBDSCollectionViewIndex *)collectionViewIndex didselectionAtIndex:(NSInteger)index withTitle:(NSString *)title;
- (void)collectionViewIndexTouchesBegan:(ZBDSCollectionViewIndex *)collectionViewIndex;
- (void)collectionViewIndexTouchesEnd:(ZBDSCollectionViewIndex *)collectionViewIndex;
@end
@interface ZBDSCollectionViewIndex : UIView
@property(nonatomic, assign)BOOL isFrameLayer;
@property(nonatomic, strong)NSArray *titleIndexes;
@property(nonatomic, weak)id<DSCollectionViewIndexDelegate>collectionDelegate;
@end
