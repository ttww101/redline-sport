//
//  ZBAppleIAPService.h
//  newGQapp
//
//  Created by genglei on 2018/3/29.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IAPPurchaseStatus)
{
    IAPPurchaseFailed,      // Indicates that the purchase was unsuccessful
    IAPPurchaseSucceeded,   // Indicates that the purchase was successful
    IAPRestoredFailed,      // Indicates that restoring products was unsuccessful
    IAPRestoredSucceeded,   // Indicates that restoring products was successful
};

typedef void(^MsgBlock)(NSString *message, NSError *error);

@protocol AppleIAPServiceDelegate <NSObject>

-(void)IAPFailedWithWrongInfor:(NSString *)informationStr;

-(void)IAPPaySuccessFunctionWithBase64:(NSString *)base64Str;

@end

@interface ZBAppleIAPService : NSObject

@property(nonatomic ,weak) id<AppleIAPServiceDelegate> IAPDelegate;

+ (instancetype)sharedInstance;

/**
 *  @brief     检查本地是否具有未成功校验的IAP订单
 *
 *  @parameter 无
 *
 *  @returning 无
 */
+ (void)checkTheIAPStatusFunction;

/**
 *  @brief     添加IAP观察者
 *
 *  @parameter 无
 *
 *  @returning 无
 */
-(void)addTheIAPObserver;

/**
 *  @brief     删除IAP观察者
 *
 *  @parameter 无
 *
 *  @returning 无
 */
-(void)removeTheIAPOberver;

/**
 *  @brief     从appleStore获取商品信息
 *
 *  @parameter productIdentifier  商品编号（服务器获取）
 *
 *  @returning 无
 */
- (void)getProductInfo:(NSString *)productIdentifier;

-(void)purchase:(id)parameter resultBlock:(MsgBlock)resultBlock;

- (void)VerifyingLocalCredentialsWithBlock:(MsgBlock)resultBlock;



@end
