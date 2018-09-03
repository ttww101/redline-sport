//
//  ZBTFFileUploadManager.h
//  UploadFileTest
//
//  Created by Marjoice on 20/10/17.
//  Copyright © 2016年 zhuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBTFFileUploadManager : NSObject<NSURLConnectionDataDelegate>

+(instancetype)shareInstance;

-(void)uploadFileWithURL:(NSString*)urlString params:(NSDictionary*)params fileKey:(NSString*)fileKey filePath:(NSString*)filePath completeHander:(void(^)(NSURLResponse *response, NSData *data, NSError *connectionError))completeHander;

@end
