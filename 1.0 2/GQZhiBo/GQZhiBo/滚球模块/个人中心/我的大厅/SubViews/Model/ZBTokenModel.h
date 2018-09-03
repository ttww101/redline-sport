#import <Foundation/Foundation.h>
@interface ZBTokenModel : ZBBasicModel
@property (nonatomic, strong)NSString *token;
@property (nonatomic, strong)NSString *refreshToken;
@end
