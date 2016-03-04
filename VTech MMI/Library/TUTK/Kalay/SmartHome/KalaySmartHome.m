//
//  KalaySmartHome.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "KalaySmartHome.h"

#define INSTALL_NO_OP_CB(X) if (!X) X = ^(NSError* e, NSDictionary* result) {};

@implementation KalaySmartHome

+(instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static KalaySmartHome* _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

-(void)noOpNetworkCall:(KalayResponseCallback)cb
{
    INSTALL_NO_OP_CB(cb)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cb(nil, nil);
    });
}

-(void)listGatewaysOnCompletion:(KalayResponseCallback)cb
{
    INSTALL_NO_OP_CB(cb)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cb(nil, @{@"gateways":@[
                          @{@"name": @"Hub 1"},
                          @{@"name": @"Hub 2"},
                          @{@"name": @"Hub 3"},
                          @{@"name": @"Hub 4"},
                          @{@"name": @"Hub 5"},
                          @{@"name": @"Hub 6"},
                          ]});
    });
}

@end
