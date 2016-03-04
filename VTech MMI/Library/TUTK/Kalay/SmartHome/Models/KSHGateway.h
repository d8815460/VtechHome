//
//  KSHGateway.h
//  VTech MMI
//
//  Created by David Lin on 12/7/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KalayResponseCallback.h"

@interface KSHGateway : NSObject

@property (readonly, nonatomic) BOOL isConnected;

-(void)reconnect;
-(void)disconnect;

-(void)listAccessoriesOnCompletion:(KalayResponseCallback)cb;
-(void)getConfigurationOnCompletion:(KalayResponseCallback)cb;
-(void)setConfiguration:(NSDictionary*)config onCompletion:(KalayResponseCallback)cb;
-(void)getDeviceInfoOnCompletion:(KalayResponseCallback)cb;
-(void)resetDeviceOnCompletion:(KalayResponseCallback)cb;


@end
