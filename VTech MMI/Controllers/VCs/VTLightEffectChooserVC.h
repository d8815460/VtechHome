//
//  VTLightEffectChooserVC.h
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBaseVC.h"
#import "DLPresenterVCDelegate.h"

@interface VTLightEffectChooserVC : VTBaseVC

@property (strong, nonatomic) NSDictionary* accessory;
@property (strong, nonatomic) NSDictionary* selectedEffect;
@property (weak, nonatomic) id<DLPresenterVCDelegate> delegate;

@end
