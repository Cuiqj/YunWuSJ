//
//  NSString+Base64.h
//  GDRMMobile
//
//  Created by maijunjin on 14-11-20.
//
//

#import <Foundation/Foundation.h>

//MD5加密
#import <CommonCrypto/CommonDigest.h>


@interface NSString (Base64)
+ (NSString*)base64forData:(NSData*)theData;

+ (NSString *)md5:(NSString *)input;
@end
