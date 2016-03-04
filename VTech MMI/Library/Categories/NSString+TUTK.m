//
//  NSString+TUTK.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "NSString+TUTK.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (TUTK)

+(NSString *)sizeString:(long long)size
{
    NSLog(@"Size %lld", size);
    if (size == 0)              return @"0 byte";
    if (size < 1024)            return FORMAT(@"%lld bytes", size);
    if (size < pow(1024, 2))    return FORMAT(@"%lld KB", size / 1024);
    if (size < pow(1024, 3))    return FORMAT(@"%.2f MB", size / pow(1024, 2));
    return FORMAT(@"%.3f GB", size / pow(1024, 3));
}

- (NSString *)md5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

@end
