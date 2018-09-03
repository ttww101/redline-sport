#import "ZBPanwangCollectCell.h"
#import "ZBPanwangZhishuTable.h"
@interface ZBPanwangCollectCell()
@property (nonatomic, strong) ZBPanwangZhishuTable *table;
@end
@implementation ZBPanwangCollectCell
- (void)setType:(NSString *)type
{
    _type = type;
    [self.contentView addSubview:self.table];
    _table.type = _type;
}
- (ZBPanwangZhishuTable *)table
{
    if (!_table) {
        _table = [[ZBPanwangZhishuTable alloc] initWithFrame:CGRectMake(0, 0, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44) style:UITableViewStylePlain];
    }
    return _table;
}
@end
