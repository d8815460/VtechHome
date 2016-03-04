//
//  Kalay.m
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "Kalay.h"
#import <BlocksKit/BlocksKit+UIKit.h>

#define INSTALL_NO_OP_CB(X) if (!X) X = ^(NSError* e, NSDictionary* result) {};

@interface Kalay ()

@property (strong, nonatomic) KalaySmartHome* SmartHome;
@property (strong, nonatomic) NSString* IOTCAPIVersion;
@property (strong, nonatomic) NSString* AVAPIVersion;

@end

@implementation Kalay

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.SmartHome = [KalaySmartHome sharedInstance];
        self.IOTCAPIVersion = @"1.0.0.0";
        self.AVAPIVersion = @"2.0.0.0";
    }
    return self;
}

+(instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static Kalay* _sharedObject = nil;
    
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

-(void)loginWithEmail:(NSString*)email andPassword:(NSString*)password onCompletion:(KalayResponseCallback)cb
{
    [self noOpNetworkCall: cb];
}

-(void)resendActivationEmailTo:(NSString*)email onCompletion:(KalayResponseCallback)cb
{
    [self noOpNetworkCall: cb];
}

-(void)resetPasswordForEmail:(NSString *)email onCompletion:(KalayResponseCallback)cb
{
    [self noOpNetworkCall: cb];
}

-(void)createAccountWithEmail:(NSString*)email andPassword:(NSString*)password onCompletion:(KalayResponseCallback)cb
{
    [self noOpNetworkCall: cb];
}

@end
