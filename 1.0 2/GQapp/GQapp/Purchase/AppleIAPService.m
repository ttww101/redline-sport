//
//  AppleIAPService.m
//  newGQapp
//
//  Created by genglei on 2018/3/29.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "AppleIAPService.h"
#import <StoreKit/StoreKit.h>
#import "ArchiveFile.h"

@interface AppleIAPService () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, copy) MsgBlock resultBlock;

@property (nonatomic, copy) MsgBlock verifyingResultBlock;

@property (nonatomic , copy) NSString *selectProductID;

@end

@implementation AppleIAPService

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static AppleIAPService *service = nil;
    dispatch_once(&onceToken, ^{
        service = [[AppleIAPService alloc]init];
    });
    return service;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

-(void)purchase:(NSString *)product_id resultBlock:(MsgBlock)resultBlock{
    
    self.resultBlock = resultBlock;
    self.selectProductID = product_id;
    if ([SKPaymentQueue canMakePayments]) {//用户允许支付
        NSSet *set = [NSSet setWithObjects:product_id, nil];
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        request.delegate = self;
        [request start];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showInfoWithStatus:@"正在获取商品信息"];
        
    } else {
        NSError *error = [NSError errorWithDomain:@"IAP"
                                             code:-1
                                         userInfo:@{ NSLocalizedDescriptionKey : @"检查是否允许支付功能或者该设备是否支持支付." }];
        if(self.resultBlock) self.resultBlock(nil,error);
    }
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    NSArray *products = response.products;
    if (products.count == 0) {
        NSError *error = [NSError errorWithDomain:@"IAP"
                                             code:-2
                                         userInfo:@{ NSLocalizedDescriptionKey : @"商品信息无效，请联系客服。" }];
        if(self.resultBlock) self.resultBlock(nil,error);
        return;
    }
    
    
    for (SKProduct *sKProduct in products) {
        
        NSLog(@"pro info");
        NSLog(@"SKProduct 描述信息：%@", sKProduct.description);
        NSLog(@"localizedTitle 产品标题：%@", sKProduct.localizedTitle);
        NSLog(@"localizedDescription 产品描述信息：%@",sKProduct.localizedDescription);
        NSLog(@"price 价格：%@",sKProduct.price);
        NSLog(@"productIdentifier Product id：%@",sKProduct.productIdentifier);
        
        if([sKProduct.productIdentifier isEqualToString: self.selectProductID]){
            [self buyProduct:sKProduct];
            break;
            
        }else{
            NSError *error = [NSError errorWithDomain:@"IAP"
                                                 code:-2
                                             userInfo:@{ NSLocalizedDescriptionKey : @"商品信息无效，请联系客服。" }];
            if(self.resultBlock) self.resultBlock(nil,error);
            return;
        }
    }
}

#pragma mark 内购的代码调用
-(void)buyProduct:(SKProduct *)product{
    // 1.创建票据
    SKPayment *skpayment = [SKPayment paymentWithProduct:product];
    // 2.将票据加入到交易队列
    [[SKPaymentQueue defaultQueue] addPayment:skpayment];
    [SVProgressHUD showInfoWithStatus:@"生成订单中..."];
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"%s",__FUNCTION__);
}
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"%s:%@",__FUNCTION__,error.localizedDescription);
    if(self.resultBlock) self.resultBlock(nil,error);
}

#pragma mark - SKPaymentTransactionObserver
//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing: // 0 购买事务进行中
                break;
            case SKPaymentTransactionStatePurchased:  // 1 交易完成
                [self completeTransaction:transaction forStatus:IAPPurchaseSucceeded];
                break;
            case SKPaymentTransactionStateFailed:     // 2 交易失败
                [self completeTransaction:transaction forStatus:IAPPurchaseFailed];
                break;
            case SKPaymentTransactionStateRestored:   // 3 恢复交易成功:从用户的购买历史中恢复了交易
                [self completeTransaction:transaction forStatus:IAPRestoredSucceeded];
                break;
            default:
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];//结束支付事务
                break;
        }
    }
}

#pragma mark Complete transaction
-(void)completeTransaction:(SKPaymentTransaction *)transaction forStatus:(IAPPurchaseStatus)status
{
   
    if (transaction.error.code != SKErrorPaymentCancelled){
        switch (status) {
            case IAPPurchaseSucceeded:
            case IAPRestoredSucceeded:
            {
                [self uploadReceipt:transaction];
            }
                break;
            case IAPPurchaseFailed:
            case IAPRestoredFailed:
            {
                if(self.resultBlock) self.resultBlock(nil,transaction.error);
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];//结束支付事务
            }
                
                
            default:
            {
                if(self.resultBlock) self.resultBlock(nil,transaction.error);
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];//结束支付事务
            }
                break;
        }
    }else{
        
        NSError *error = [NSError errorWithDomain:@"IAP"
                                             code:-3
                                         userInfo:@{ NSLocalizedDescriptionKey : @"已取消支付。" }];
        if(self.resultBlock) self.resultBlock(nil,error);
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];//结束支付事务
        
    }
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

/**
 上传支付凭证到后台
 苹果AppStore线上的购买凭证地址是： https://buy.itunes.apple.com/verifyReceipt
 测试地址是：https://sandbox.itunes.apple.com/verifyReceipt
 @param transaction 支付事务
 */
//附加：官方文档：向苹果校验支付结果 https://developer.apple.com/library/content/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html

-(void)uploadReceipt:(SKPaymentTransaction *)transaction {
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
    if (!receipt) { /* No local receipt -- handle the error. */
        [SVProgressHUD showSuccessWithStatus:@"本地数据不存在"];
        return;
    }
    NSString *base64_receipt = [receipt base64EncodedStringWithOptions:0];
    
    [ArchiveFile savePurchaseProof:base64_receipt];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:base64_receipt forKey:@"receipt-data"];
    NSError *error;
    // 转换为 JSON 格式
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:params
                                                          options:0
                                                            error:&error];
    
    
    
    
    
//    if (!requestData) { /* ... Handle error ... */ }
//
//    // Create a POST request with the receipt data.
//    NSURL *storeURL = [NSURL URLWithString:@"https://buy.itunes.apple.com/verifyReceipt"];
//    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
//    [storeRequest setHTTPMethod:@"POST"];
//    [storeRequest setHTTPBody:requestData];
//
//    // Make a connection to the iTunes Store on a background queue.
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                               if (connectionError) {
//                                   /* ... Handle error ... */
//                               } else {
//                                   NSError *error;
//                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//                                   if (!jsonResponse) { /* ... Handle error ...*/ }
//                                   /* ... Send a response back to the device ... */
//                               }
//                           }];

//    return;
    
    
    
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
    [parameter setObject:base64_receipt forKey:@"receipt-data"];
    [parameter setObject:transaction.transactionIdentifier forKey:@"transaction_id"];
    [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_verifyPayment]  ArrayFile:nil Start:^(id requestOrignal) {

    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] integerValue]==200) {
            NSDictionary *dic = responseOrignal;
            NSString *statusCode = [dic[@"data"] stringValue];
            if ([statusCode isEqualToString:@"21007"]) {
                [self uploadSanBoxReceipt:requestData receipt:base64_receipt];
            } else if ([statusCode isEqualToString:@"0"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ArchiveFile removerPurchaseProof:base64_receipt];
                    if (self.resultBlock) {
                        self.resultBlock(statusCode,nil);
                    }
                });
            } else {
                [SVProgressHUD showSuccessWithStatus:@"购买失败"];
            }

        }else {
             self.resultBlock(nil,nil);
            [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"%@",[responseOrignal objectForKey:@"msg"]]];
            [SVProgressHUD dismissWithDelay:2.0f];
        }

    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        if (self.resultBlock) {
            self.resultBlock(false,error);
        }
        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"%@",[responseOrignal objectForKey:@"msg"]]];
        [SVProgressHUD dismissWithDelay:2.0f];
    }];
}

-(void)uploadSanBoxReceipt:(NSData *)requestData receipt:(NSString *)receipt {
    NSString *verifyUrlString = @"https://sandbox.itunes.apple.com/verifyReceipt";
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:verifyUrlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                  [SVProgressHUD showErrorWithStatus:@"链接失败"];
                               } else {
                                   NSError *error;
                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if (!jsonResponse) {
                                       [SVProgressHUD showErrorWithStatus:@"验证失败"];
                                   }
                                   NSString *code = [jsonResponse[@"status"] stringValue];
                                   if ([code isEqualToString:@"0"]) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [ArchiveFile removerPurchaseProof:receipt];
                                           if (self.resultBlock) {
                                               self.resultBlock(code,nil);
                                           }
                                           
                                           if (self.verifyingResultBlock) {
                                               self.verifyingResultBlock(code,nil);
                                           }
                                       });
                                   }
                               }
                           }];
}

- (void)VerifyingLocalCredentialsWithBlock:(MsgBlock)resultBlock {
    self.verifyingResultBlock = resultBlock;
   NSMutableArray *arry = [ArchiveFile getDataWithPath:In_App_Purchase_Path];
    [arry addObject:@"121313"];
    if (arry.count > 0) {
        for (NSInteger i = 0; i < arry.count; i++) {
            NSString *base64_receipt = arry[i];
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:base64_receipt forKey:@"receipt-data"];
            NSError *error;
            // 转换为 JSON 格式
            NSData *requestData = [NSJSONSerialization dataWithJSONObject:params
                                                                  options:0
                                                                    error:&error];
            
            
            NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [HttpString getCommenParemeter]];
            [parameter setObject:base64_receipt forKey:@"receipt-data"];
            [[DCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_purchase]  ArrayFile:nil Start:^(id requestOrignal) {
                
            } End:^(id responseOrignal) {
                
            } Success:^(id responseResult, id responseOrignal) {
                if ([[responseOrignal objectForKey:@"code"] integerValue]==200) {
                    NSDictionary *dic = responseOrignal[@"data"];
                    NSString *statusCode = [dic[@"status"] stringValue];
                    if ([statusCode isEqualToString:@"21007"]) {
                        [self uploadSanBoxReceipt:requestData receipt:base64_receipt];
                    } else if ([statusCode isEqualToString:@"0"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [ArchiveFile removerPurchaseProof:base64_receipt];
                            if (self.verifyingResultBlock) {
                                self.verifyingResultBlock(statusCode,nil);
                            }
                            
                        });
                    } else {
                        
                    }
                    
                }else {
                    self.resultBlock(nil,nil);
                }
                
            } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
                if (self.verifyingResultBlock) {
                    self.verifyingResultBlock(false,error);
                }
                
            }];
        }
    }
    
}


- (void)dealloc
{
    NSLog(@"%s销毁",__FUNCTION__);
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}


- (void)getProductInfo:(NSString *)productIdentifier {
    
}

-(void)removeTheIAPOberver {
    
}

-(void)addTheIAPObserver {
    
}

+ (void)checkTheIAPStatusFunction {
    
}

@end
