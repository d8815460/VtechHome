//
//  VTUserAccountVC.h
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBaseVC.h"

@interface VTUserAccountVC : VTBaseVC

@property (strong, nonatomic) NSDictionary* user;
@property (weak, nonatomic) id<DLPresenterVCDelegate> delegate;

@end
