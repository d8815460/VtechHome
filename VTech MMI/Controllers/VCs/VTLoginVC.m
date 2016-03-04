//
//  VTLoginVC.m
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTLoginVC.h"
#import "Kalay.h"
#import "VTPromptActivateAccountVC.h"

@interface VTLoginVC()

@property (weak, nonatomic) IBOutlet UITextField* emailTextField;
@property (weak, nonatomic) IBOutlet UITextField* passwordTextField;

@end

@implementation VTLoginVC

#pragma mark - UI Actions

-(IBAction)doLogin
{
    [self showProgress: NSLocalizedString(@"Logging In...", @"Login in progress hud title")];
    [KALAY loginWithEmail: self.emailTextField.text andPassword: self.passwordTextField.text onCompletion:^(NSError *error, NSDictionary *result) {
        [self hideProgress];
        if (self.emailTextField.text.length) {
            UIStoryboard* sb = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
            UIViewController* vc = [sb instantiateInitialViewController];
            [UIView transitionWithView: self.view.window duration: 0.5 options: UIViewAnimationOptionTransitionFlipFromRight animations:^{
                self.view.window.rootViewController = vc;
            } completion:nil];
        } else {
            [self performSegueWithIdentifier: @"showPromptActivateAccountSegue" sender: nil];
        }
    }];
}

-(IBAction)doCreateAccount
{
    [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"showCreateAccountSegue"}];
}


#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showPromptActivateAccountSegue"]) {
        VTPromptActivateAccountVC* vc = segue.destinationViewController;
        vc.email = self.emailTextField.text;
        vc.promptTitle = NSLocalizedString(@"Activate Your Account", @"Prompt title for a page");
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
