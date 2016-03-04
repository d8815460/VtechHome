//
//  VTLocationChooserVC.h
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBaseVC.h"

@interface VTLocationChooserVC : VTBaseVC

@property (nonatomic) NSInteger sensorType;
@property (strong, nonatomic) NSString* selectedLocationName;

@property (weak, nonatomic) id<DLPresenterVCDelegate> delegate;

@end
