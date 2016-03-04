//
//  VTEditLightEffectVC.h
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBaseVC.h"

@interface VTEditLightEffectVC : VTBaseVC

@property (weak, nonatomic) id<DLPresenterVCDelegate> deleage;
@property (strong, nonatomic) NSDictionary* effect;

@end
