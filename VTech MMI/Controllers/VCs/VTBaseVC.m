//
//  VTBaseVC.m
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBaseVC.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface VTBaseVC()

@end

@implementation VTBaseVC

-(void)showProgress:(NSString *)title
{
    [SVProgressHUD showWithStatus: title maskType: SVProgressHUDMaskTypeGradient];
}

-(void)hideProgress
{
    [SVProgressHUD dismiss];
}

-(void)showInfoDialog:(NSString *)message
{
    UIAlertView* av = [UIAlertView bk_alertViewWithTitle: NSLocalizedString(@"Info", @"Dialog Title") message: message];
    [av bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler:^{}];
    [av show];
}

@end
