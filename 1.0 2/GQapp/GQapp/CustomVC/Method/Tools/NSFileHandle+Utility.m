//
//  NSFileHandle+Utility.m
//  CommonFramework
//
//  Created by Marjoice on 7/19/17.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import "NSFileHandle+Utility.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSFileHandle (Utility)


- (long long)fileSize {
    int fd = self.fileDescriptor;
    return lseek(fd,0,SEEK_END);
}

/**
 文件的MD5值
 
 @param encryptKey: 加密的Key在数据最后用加密key进行MD5一次,如果为nil就不进行加密
 
 @param offset:     跳过多少个字节偏移量计算md5
 
 @return 返回文件的md5值，如果异常返回为nil
 */
- (NSString *)md5WithEncryptKey:(NSString *)encryptKey skipOffset:(NSUInteger)offset {
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    int fd = self.fileDescriptor;
    lseek(fd, offset, SEEK_SET);
    size_t bufferSize = 2048;
    size_t len = 0;
    char*    buffer = malloc(sizeof(char) * bufferSize);
    memset(buffer, '\0', bufferSize);
    while ((len = read(fd, buffer, bufferSize)) > 0) {
        CC_MD5_Update(&hashObject,buffer,(CC_LONG)len);
    }
    free(buffer);
    
    //加密md5
    if(encryptKey != nil) {
        NSData* encryptData = [encryptKey dataUsingEncoding:NSUTF8StringEncoding];
        CC_MD5_Update(&hashObject,encryptData.bytes,(CC_LONG)encryptData.length);
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    int hashLen = 2 * sizeof(digest);
    char hash[hashLen + 1];
    hash[hashLen] = '\0';
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    return [[NSString alloc] initWithCString:hash encoding:NSUTF8StringEncoding];
}

/**
 文件的MD5值
 
 @return 返回文件的md5值，如果异常返回为nil
 */
- (NSString *)md5 {
    return [self md5WithEncryptKey:nil skipOffset:0];
}

@end
