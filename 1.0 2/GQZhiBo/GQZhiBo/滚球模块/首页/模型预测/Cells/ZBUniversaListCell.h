#import <UIKit/UIKit.h>
@interface UniversaListCellModel : NSObject
@property (nonatomic , copy) NSString *leftIconImageName;
@property (nonatomic , copy) NSString *content;
@property (nonatomic , assign) NSInteger index;
@end
@interface ZBUniversaListCell : UITableViewCell
+ (ZBUniversaListCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForCell;
- (void)refreshContentData:(UniversaListCellModel *)model;
@end
