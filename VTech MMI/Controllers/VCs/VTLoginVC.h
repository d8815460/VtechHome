//
//  VTLoginVC.h
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBaseVC.h"
#import "DLPresenterVCDelegate.h"

@interface VTLoginVC : VTBaseVC

@property (weak, nonatomic) id<DLPresenterVCDelegate> delegate;

@end
