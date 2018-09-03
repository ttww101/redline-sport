#import "ZBMatchListViewModel+Zbvalue.h"
@implementation ZBMatchListViewModel (Zbvalue)
+ (BOOL)fetchMatchDateInterfaceWithParameterCallbackZbvalue:(NSInteger)ZBValue {
    return ZBValue % 50 == 0;
}

@end
