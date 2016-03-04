//
//  VTSwitchAssignLIghtSelectVC.h
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBaseVC.h"

@interface VTSwitchAssignLightSelectVC : VTBaseVC

@property (strong, nonatomic) NSArray* selectedLights;
@property (weak, nonatomic) id<DLPresenterVCDelegate> delegate;

@end
