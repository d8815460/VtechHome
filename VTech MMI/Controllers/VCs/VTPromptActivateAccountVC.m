//
//  VTPromptActivateAccountVC.m
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTPromptActivateAccountVC.h"
#import "Kalay.h"
#import <BlocksKit+UIKit.h>

@interface VTPromptActivateAccountVC ()

@property (weak, nonatomic) IBOutlet UILabel* promptTitleLabel;

@end

@implementation VTPromptActivateAccountVC

#pragma mark - UI Actions

-(IBAction)doResendEmail
{
    [self showProgress: NSLocalizedString(@"Resending Activation Email...", @"Resend activation email hud title")];
    [KALAY resendActivationEmailTo: self.email onCompletion:^(NSError *error, NSDictionary *result) {
        [self hideProgress];

        UIAlertView* av = [UIAlertView
                           bk_alertViewWithTitle: NSLocalizedString(@"Success", @"Dialog Title")
                           message: NSLocalizedString(@"We will send you another email soon!", @"Dialog message")];
        [av bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler: ^{}];
        [av show];
    }];
}

-(IBAction)doJumpToSplash
{
    [self.navigationController popToRootViewControllerAnimated: YES];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.promptTitle) {
        self.promptTitleLabel.text = self.promptTitle;
    }
}


@end
