#import <UIKit/UIKit.h>
#import "ZBPanWangModel.h"
@interface ZBPanwangCell : UITableViewCell
@property (nonatomic, strong)UILabel *labGaiLv;
@property (nonatomic, strong)UILabel *labGaiLvTitle;
@property (nonatomic, assign)NSInteger rankNum;
@property (nonatomic, strong)ZBPanWangModel *model;
@end
