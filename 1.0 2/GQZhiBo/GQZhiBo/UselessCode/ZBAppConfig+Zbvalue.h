#import <Foundation/Foundation.h>
#import "ZBAppConfig.h"
#import "ArchiveFile.h"
#import <AdSupport/AdSupport.h>
#import <WebKit/WebKit.h>

@interface ZBAppConfig (Zbvalue)
+ (BOOL)shareInstanceZbvalue:(NSInteger)ZBValue;
+ (BOOL)initializeZbvalue:(NSInteger)ZBValue;

@end
