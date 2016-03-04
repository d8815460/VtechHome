//
//  VTResetPasswordVC.m
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTResetPasswordVC.h"
#import "Kalay.h"

@interface VTResetPasswordVC ()

@property (weak, nonatomic) IBOutlet UITextField* emailTextField;

@end

@implementation VTResetPasswordVC

#pragma mark - UI Actions

-(IBAction)doResetPassword
{
    [self showProgress: NSLocalizedString(@"Resetting Password...", @"Reset password hud title")];
    [KALAY resetPasswordForEmail: self.emailTextField.text onCompletion:^(NSError *error, NSDictionary *result) {
        [self hideProgress];
        
        UIAlertView* av = [UIAlertView
                           bk_alertViewWithTitle: NSLocalizedString(@"Success", @"Dialog Title")
                           message: NSLocalizedString(@"An email has been sent to your account ot verify the password reset request", @"Dialog message")];
        [av bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler: ^{
            [self.navigationController popToRootViewControllerAnimated: YES];
        }];
        [av show];

    }];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
