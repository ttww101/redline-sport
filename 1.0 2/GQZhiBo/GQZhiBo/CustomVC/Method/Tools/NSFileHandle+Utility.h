//
//  NSFileHandle+Utility.h
//  CommonFramework
//
//  Created by Marjoice on 7/19/17.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileHandle (Utility)


- (long long)fileSize;

/**
 文件的MD5值
 
 @param encryptKey: 加密的Key在数据最后用加密key进行MD5一次,如果为nil就不进行加密
 
 @param offset:     跳过多少个字节偏移量计算md5
 
 @return 返回文件的md5值，如果异常返回为nil
 */
- (NSString *)md5WithEncryptKey:(NSString *)encryptKey skipOffset:(NSUInteger)offset;

/**
 文件的MD5值
 
 @return 返回文件的md5值，如果异常返回为nil
 */
- (NSString *)md5;

@end
