//
//  VTViewChooserPopover.h
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPresenterVCDelegate.h"

@interface VTViewChooserPopover : UIViewController

@property (weak, nonatomic) id<DLPresenterVCDelegate> delegate;
@property (nonatomic) NSInteger selectedMode;
@property (strong, nonatomic) NSString* selectedAccessoryType;

@end
