//
//  KalaySmartHome.h
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KalayResponseCallback.h"

@interface KalaySmartHome : NSObject

+(instancetype)sharedInstance;

-(void)listGatewaysOnCompletion:(KalayResponseCallback)cb;

@end
