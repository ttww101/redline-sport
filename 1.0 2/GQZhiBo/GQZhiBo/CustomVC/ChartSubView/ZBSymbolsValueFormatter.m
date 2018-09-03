#import "ZBSymbolsValueFormatter.h"
@implementation ZBSymbolsValueFormatter
-(id)init{
    if (self = [super init]) {
    }
    return self;
}
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    return [NSString stringWithFormat:@"%ld%%",(NSInteger)value];
}
@end
