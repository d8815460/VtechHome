//
//  VTIconChooserVC.h
//  VTech MMI
//
//  Created by David Lin on 12/9/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBaseVC.h"

@interface VTIconChooserVC : VTBaseVC

@property (weak, nonatomic) id<DLPresenterVCDelegate> delegate;
@property (strong, nonatomic) NSArray* iconNames;
@property (strong, nonatomic) NSString* selectedIconName;

@end
