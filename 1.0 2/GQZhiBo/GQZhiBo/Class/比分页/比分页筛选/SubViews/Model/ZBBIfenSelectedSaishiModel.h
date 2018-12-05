#import "ZBBasicModel.h"
@interface ZBBIfenSelectedSaishiModel : ZBBasicModel
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) BOOL isSelected;
@end

@interface FilterModel: NSObject

@property (nonatomic , copy) NSArray<ZBBIfenSelectedSaishiModel *> *hot_items;
@property (nonatomic , copy) NSArray<ZBBIfenSelectedSaishiModel *> *other_items;
@property (nonatomic , copy) NSArray<ZBBIfenSelectedSaishiModel *> *items;

@end

@interface FilterData: NSObject

@property (nonatomic, copy) NSArray<ZBBIfenSelectedSaishiModel *> *dataList;
@property (nonatomic , copy) NSString *title;

@end
