//
//  VTLightScheduleEditVC.h
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBaseVC.h"

@interface VTLightScheduleEditVC : VTBaseVC

@property (weak, nonatomic) id<DLPresenterVCDelegate> delegate;
@property (strong, nonatomic) NSDictionary* schedule;

@end
