//
//  VTBaseVC.h
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPresenterVCDelegate.h"
#import "NSString+TUTK.h"
#import <BlocksKit/BlocksKit+UIKit.h>

@interface VTBaseVC : UIViewController

-(void)showProgress:(NSString*)title;
-(void)hideProgress;
-(void)showInfoDialog:(NSString*)message;

@end
