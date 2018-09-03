//
//  DCHttpRequest.m
//  GunQiuLive
//
//  Created by WQ_h on 15/12/11.
//  Copyright (c) 2015年 WQ_h. All rights reserved.
//

#import "DCHttpRequest.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <CoreFoundation/CFURL.h>
static AFHTTPRequestOperationManager *_afnetManager;
@interface DCHttpRequest ()
@property (nonatomic, strong) UIView *animateBasicView;

@end
@implementation DCHttpRequest
{
}


+ (DCHttpRequest *)shareInstance
{
    static DCHttpRequest *dcHttpRequset = nil;
    static dispatch_once_t onceInitDCHttpRequest;
    dispatch_once(&onceInitDCHttpRequest, ^{

        dcHttpRequset = [[DCHttpRequest alloc] init];
    });
    
    if ([Methods login]) {
        //[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]
        [_afnetManager.requestSerializer setValue:[Methods getTokenModel].token forHTTPHeaderField:@"token"];

    }else{
        [_afnetManager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];

    }

    [_afnetManager.requestSerializer setValue:@"GQLive" forHTTPHeaderField:@"User-Agent"];
    

    
    return dcHttpRequset;
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        _afnetManager = [[AFHTTPRequestOperationManager  manager] init];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
//        [AFJSONRequestSerializer serializer];
//        [AFJSONResponseSerializer serializer];
        _afnetManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _afnetManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_afnetManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];

        _afnetManager.requestSerializer.timeoutInterval = 8.0;
        //header里面添加参数
    }
    return self;
}

- (void)sendRequestByMethod:(NSString *)post
             WithParamaters:(NSDictionary *)parameters
                   PathUrlL:(NSString *)pathUrl
                  ArrayFile:(NSArray *)arrayFile
                      Start:(requestStart)start
                        End:(requestEnd)end
                    Success:(requestSuccess)success
                    Failure:(requestFailure)failure
{
    
    
    
    
    
    
    
    
    if(start)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        [SVProgressHUD setCornerRadius:6];
        start(parameters);
        NSLog(@"pathUrl---\n%@",pathUrl);
        NSLog(@"parameters---\n%@",parameters);
        
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@?",pathUrl];
        [parameters.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [str appendString:[NSString stringWithFormat:@"&%@=%@",obj,[parameters objectForKey:obj]]];
            
            
            
        }];
        
        NSLog(@"%@",str);

        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        

        start(parameters);
        
        
        
//        [_afnetManager.reachabilityManager startMonitoring];
//        [_afnetManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            switch (status) {
//                case AFNetworkReachabilityStatusUnknown:
//                {
//                      NSLog(@"无法获取网络状态");
//                    if (end) {
//                        end(@"无法获取网络状态");
//                    }
//                    failure([NSError new],@"无法获取网络状态",@"无法获取网络状态");
//                    return;
//
//                    
//                }
//                    break;
//                case AFNetworkReachabilityStatusNotReachable:
//                {
//                     NSLog(@"无网络连接");
//                    if (end) {
//                        end(@"无法获取网络状态");
//                    }
//                    failure([NSError new],@"无法获取网络状态",@"无法获取网络状态");
//                    return;
//
//                }
//                    break;
//                case AFNetworkReachabilityStatusReachableViaWWAN:
//                {
//                    
//                }
//                    break;
//                case AFNetworkReachabilityStatusReachableViaWiFi:
//                {
//                }
//                    break;
//                default:
//                    break;
//            }
//        } ];
//        
//        
        
        
        
        
        
    }
    if (!arrayFile) {
        [_afnetManager POST:pathUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"%@\n返回数据%@",operation.request,operation.responseString);
            
            NSLog(@"%@",operation.request.allHTTPHeaderFields);
            
            
            if (end) {
                end(operation.responseObject);
            }
            
            NSString *str_response = [NSString stringWithString:operation.responseString];

            NSData *data_response = [NSData dataWithData:[[self clearWrongtextwithString:str_response] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [self parseResponse:data_response Success:success Failure:failure];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (end) {
                end(operation.responseObject);
            }
            NSLog(@"error ----%@,opration ---%@",error,operation.responseString);
            //            if (operation.responseObject) {
            //                [self parseResponse:operation.responseObject Success:success Failure:failure];
            //            }else{
            
            failure(error,error.localizedFailureReason,operation.responseObject);
            //            }
            
        }];
    }else{
        
        //这个是需要上传文件的时候用
        [_afnetManager POST:pathUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            for (int i = 0; i<arrayFile.count; i++) {
                UIImage *imagePic = [arrayFile objectAtIndex:i];
                
                NSData *imageData;
                //            if (imagePic.size.height >800 || imagePic.size.width>800) {
                //                CGFloat ratio = 800/(imagePic.size.height>imagePic.size.width? imagePic.size.height : imagePic.size.width);
                //                UIImage *imageNew = [self scaleImage:imagePic scaleFactor:ratio];
                ////                if (imagePic.size.height >800) {
                ////
                ////                    UIImage *imageNew = [self OriginImage:imagePic scaleToSize:]
                ////                }
                ////
                //                imageData = UIImageJPEGRepresentation(imageNew, ratio);
                //            }else{
                
                
                imageData = UIImageJPEGRepresentation(imagePic, 1);
                //            }
                
                if (imageData.length>10000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.3);

                }else if (imageData.length>5000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.5);

                }else if (imageData.length>2000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.7);

                }

                
                [formData appendPartWithFileData:imageData name:@"imagefile" fileName:@"pic.jpg" mimeType:@"image/jpg/png/jpeg"];
                
            }
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (end) {
                end(operation.responseObject);
            }
            NSString *str_response = [NSString stringWithString:operation.responseString];
            NSData *data_response = [NSData dataWithData:[[self clearWrongtextwithString:str_response] dataUsingEncoding:NSUTF8StringEncoding]];

            [self parseResponse:data_response Success:success Failure:failure];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (end) {
                end(operation.responseObject);
            }
            NSLog(@"error ----%@,opration ---%@",error,operation.responseString);
            //        if (operation.responseObject) {
            //            [self parseResponse:operation.responseObject Success:success Failure:failure];
            //        }else{
            
            failure(error,error.localizedDescription,operation.responseObject);
            //        }
            
            
        }];
    }
}
- (void)sendGetRequestByMethod:(NSString *)post
                WithParamaters:(NSDictionary *)parameters
                      PathUrlL:(NSString *)pathUrl
                         Start:(requestStart)start
                           End:(requestEnd)end
                       Success:(requestSuccess)success
                       Failure:(requestFailure)failure
{
    if(start)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        [SVProgressHUD setCornerRadius:6];
        start(parameters);
        NSLog(@"pathUrl---\n%@",pathUrl);
        NSLog(@"parameters---\n%@",parameters);
        
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@?",pathUrl];
        [parameters.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [str appendString:[NSString stringWithFormat:@"&%@=%@",obj,[parameters objectForKey:obj]]];
            
            
            
        }];
        
//        NSLog(@"%@",str);

//        [_afnetManager.reachabilityManager startMonitoring];
//        [_afnetManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            switch (status) {
//                case AFNetworkReachabilityStatusUnknown:
//                {
//                    NSLog(@"无法获取网络状态");
//                    if (end) {
//                        end(@"无法获取网络状态");
//                    }
//                    failure([NSError new],@"无法获取网络状态",@"无法获取网络状态");
//                    return;
//
//                    
//                }
//                    break;
//                case AFNetworkReachabilityStatusNotReachable:
//                {
//                    NSLog(@"无网络连接");
//                    if (end) {
//                        end(@"无法获取网络状态");
//                    }
//                    failure([NSError new],@"无法获取网络状态",@"无法获取网络状态");
//                    return;
//
//                }
//                    break;
//                case AFNetworkReachabilityStatusReachableViaWWAN:
//                {
//                    
//                }
//                    break;
//                case AFNetworkReachabilityStatusReachableViaWiFi:
//                {
//                }
//                    break;
//                default:
//                    break;
//            }
//        } ];
//        
        
        
        
        

    }
    [_afnetManager GET:pathUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@\n返回数据%@",operation.request,operation.responseString);
 
        if (end) {
            end(operation.responseObject);
        }
        NSString *str_response = [NSString stringWithString:operation.responseString];
        
        NSData *data_response = [NSData dataWithData:[[self clearWrongtextwithString:str_response] dataUsingEncoding:NSUTF8StringEncoding]];

        [self parseResponse:data_response Success:success Failure:failure];
        //                    NSLog(@"%@",operation.responseString);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        if (end) {
            end(operation.responseObject);
        }
        
        NSLog(@"error ----%@,opration ---%@",error,operation.response);
        //请求失败也要解析数据,要不然无法使用里面的数据
        //        if (operation.responseObject) {
        //            [self parseResponse:operation.responseObject Success:success Failure:failure];
        //        }else{
        
        failure(error,error.localizedDescription,operation.responseObject);
        //        }
        
    }];
    
}
- (id)parseResponse:(id)responseObject
            Success:(requestSuccess)success
            Failure:(requestFailure)failure
{
    
    

    
    id dict = nil;
    @try {//将预见可能引发异常的代码包含在try语句块中
        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    }
    @catch (NSException *exception) {//如果发生了异常，则转入catch的执行
        failure(nil,@"数据出错catch",nil);
        return nil;
    }
    @finally {
        //finally可以没有，也可以只有一个。无论有没有发生异常，它总会在这个异常处理结构的最后运行。即使你在try块内用return返回了，在返回前，finally总是要执行，这以便让你有机会能够在异常处理最后做一些清理工作。如关闭数据库连接等等。
    }
    //返回的数据格式未按照约定的格式来
    //返回过来是数组格式
    if (dict == nil) {
        failure(nil,@"数据出错catch",nil);

        return nil;
    }
    if ([dict isKindOfClass:[NSArray class]]) {
        if (success) {
            
            success(@"请求成功",dict);
        }
        return dict;
    }else{
        //返回过来是字典格式
        if (![dict isKindOfClass:[NSDictionary class]]) {
            failure(nil, @"数据错误",nil);
            NSLog(@"dict----%@",dict);
            return nil;
        }
        if ([dict isKindOfClass:[NSDictionary class]]) {
            if (success) {
                id code = [dict objectForKey:@"code"];
                if ([code isKindOfClass:[NSString class]]) {
                    
                } else if ([code isKindOfClass:[NSNumber class]]) {
                    code = [code stringValue];
                }

                if ([code isEqualToString:@"2008"]) {
                    
                    
                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"login"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"close",@"timer", nil]];

                    
                    [Methods toLogin];
                }
                
                success(@"请求成功",dict);
            }
            return dict;
        }else{
            if (failure) {
                failure(nil,@"请求失败",dict);
            }
            return [[NSMutableDictionary alloc] init];
        }
    }
    return nil;
}




//- (UIView *)animateBasicView
//{
//    if (!_animateBasicView) {
//        
//        _animateBasicView.alpha = 0;
//        _animateBasicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
//
//        [[Methods getMainWindow] addSubview:_animateBasicView];
//    }
//    return _animateBasicView;
//}

//-(UIImage *) scaleImage: (UIImage *)image scaleFactor:(float)scaleFloat
//{
//    CGSize size = CGSizeMake(image.size.width * scaleFloat, image.size.height * scaleFloat);
//    
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    
//    transform = CGAffineTransformScale(transform, scaleFloat, scaleFloat);
//    CGContextConcatCTM(context, transform);
//    
//    // Draw the image into the transformed context and return the image
//    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
//    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return newimg;
//}
//-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
//{
//    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
//    
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    
//    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    return scaledImage;   //返回的就是已经改变的图片
//}







- (void)sendHtmlGetRequestByMethod:(NSString *)post
                    WithParamaters:(NSDictionary *)parameters
                          PathUrlL:(NSString *)pathUrl
                             Start:(requestStart)start
                               End:(requestEnd)end
                           Success:(requestSuccess)success
                           Failure:(requestFailure)failure{
    if(start)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        [SVProgressHUD setCornerRadius:6];
        start(parameters);
        NSLog(@"pathUrl---\n%@",pathUrl);
        NSLog(@"parameters---\n%@",parameters);
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@?",pathUrl];
       [parameters.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           [str appendString:[NSString stringWithFormat:@"&%@=%@",obj,[parameters objectForKey:obj]]];
           
           
           
       }];
        
        NSLog(@"%@",str);
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//        [_afnetManager.reachabilityManager startMonitoring];
//        [_afnetManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            switch (status) {
//                case AFNetworkReachabilityStatusUnknown:
//                {
//                    NSLog(@"无法获取网络状态");
//                    if (end) {
//                        end(@"无法获取网络状态");
//                    }
//                    failure([NSError new],@"无法获取网络状态",@"无法获取网络状态");
//                    return;
//                    
//                    
//                }
//                    break;
//                case AFNetworkReachabilityStatusNotReachable:
//                {
//                    NSLog(@"无网络连接");
//                    if (end) {
//                        end(@"无法获取网络状态");
//                    }
//                    failure([NSError new],@"无法获取网络状态",@"无法获取网络状态");
//                    return;
//                    
//                }
//                    break;
//                case AFNetworkReachabilityStatusReachableViaWWAN:
//                {
//                    
//                }
//                    break;
//                case AFNetworkReachabilityStatusReachableViaWiFi:
//                {
//                }
//                    break;
//                default:
//                    break;
//            }
//        } ];
        


    }
    [_afnetManager GET:pathUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (end) {
            end(operation.responseObject);
        }
        
        success(operation.responseString,operation.responseString);
        
//        [self parseResponse:responseObject Success:success Failure:failure];
        //                    NSLog(@"%@",operation.responseString);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        if (end) {
            end(operation.responseObject);
        }
        
        NSLog(@"error ----%@,opration ---%@",error,operation.response);
        //请求失败也要解析数据,要不然无法使用里面的数据
        //        if (operation.responseObject) {
        //            [self parseResponse:operation.responseObject Success:success Failure:failure];
        //        }else{
        
        failure(error,error.localizedDescription,operation.responseObject);
        //        }
        
    }];
    
}



//上传图片
- (void)sendRequestByMethod:(NSString *)post
             WithParamaters:(NSDictionary *)parameters
                   PathUrlL:(NSString *)pathUrl
                  ArrayFile:(NSArray *)arrayFile
                   FileName:(NSString *)filename
                      Start:(requestStart)start
                        End:(requestEnd)end
                    Success:(requestSuccess)success
                    Failure:(requestFailure)failure
{
    
    
    
    
    
    
    
    
    if(start)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        [SVProgressHUD setCornerRadius:6];
        start(parameters);
        NSLog(@"pathUrl---\n%@",pathUrl);
        NSLog(@"parameters---\n%@",parameters);
        
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@?",pathUrl];
        [parameters.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [str appendString:[NSString stringWithFormat:@"&%@=%@",obj,[parameters objectForKey:obj]]];
            
            
            
        }];
        
        NSLog(@"%@",str);
        
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        
        start(parameters);
        
    }
    
        //这个是需要上传文件的时候用
        [_afnetManager POST:pathUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            for (int i = 0; i<arrayFile.count; i++) {
                UIImage *imagePic = [arrayFile objectAtIndex:i];
                
                NSData *imageData;

                
                imageData = UIImageJPEGRepresentation(imagePic, 1);
                //            }
                
                if (imageData.length>10000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.3);
                    
                }else if (imageData.length>5000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.5);
                    
                }else if (imageData.length>2000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.7);
                    
                }
                
                
                [formData appendPartWithFileData:imageData name:filename fileName:@"pic.jpg" mimeType:@"image/jpg/png/jpeg"];
                
            }
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (end) {
                end(operation.responseObject);
            }
            NSString *str_response = [NSString stringWithString:operation.responseString];
            NSData *data_response = [NSData dataWithData:[[self clearWrongtextwithString:str_response] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [self parseResponse:data_response Success:success Failure:failure];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (end) {
                end(operation.responseObject);
            }
            NSLog(@"error ----%@,opration ---%@",error,operation.responseString);
            //        if (operation.responseObject) {
            //            [self parseResponse:operation.responseObject Success:success Failure:failure];
            //        }else{
            
            failure(error,error.localizedDescription,operation.responseObject);
            //        }
            
            
        }];
    
}



- (NSMutableString *)clearWrongtextwithString:(NSString *)str
{
    
    NSMutableString *responseString = [NSMutableString stringWithString:str];
    
//    NSString *character = nil;
//    
//    for (int i = 0; i < responseString.length; i ++) {
//        
//        character = [responseString substringWithRange:NSMakeRange(i, 1)];
//        
//        if ([character isEqualToString:@"\\"] ||[character isEqualToString:@"\r"] ||[character isEqualToString:@"\n"] ||[character isEqualToString:@"\t"] )
//        
//        [responseString deleteCharactersInRange:NSMakeRange(i, 2)];
//        
//    }
    return responseString;
    return nil;
}



@end
