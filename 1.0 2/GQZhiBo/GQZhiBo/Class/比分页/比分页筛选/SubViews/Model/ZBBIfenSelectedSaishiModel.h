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
