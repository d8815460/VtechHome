//
//  Kalay.h
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KalayResponseCallback.h"
#import "KalaySmartHome.h"

#define KALAY [Kalay sharedInstance]

@interface Kalay : NSObject

+(instancetype)sharedInstance;

-(void)loginWithEmail:(NSString*)email
          andPassword:(NSString*)password
         onCompletion:(KalayResponseCallback)cb;

-(void)resendActivationEmailTo:(NSString*)email
                  onCompletion:(KalayResponseCallback)cb;

-(void)resetPasswordForEmail:(NSString*)email
                onCompletion:(KalayResponseCallback)cb;

-(void)createAccountWithEmail:(NSString*)email
                  andPassword:(NSString*)password
                 onCompletion:(KalayResponseCallback)cb;

@property (readonly, nonatomic) NSString* IOTCAPIVersion;
@property (readonly, nonatomic) NSString* AVAPIVersion;


@property (readonly, nonatomic) KalaySmartHome* SmartHome;

@end
