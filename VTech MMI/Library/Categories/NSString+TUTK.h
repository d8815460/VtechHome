//
//  NSString+TUTK.h
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FORMAT(format, ...)     [NSString stringWithFormat:(format), ##__VA_ARGS__]
#define CACHE_PATH              NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]
#define DOC_PATH                NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]

@interface NSString (TUTK)

+(NSString*)sizeString:(long long)size;
-(NSString*)md5;

@end
