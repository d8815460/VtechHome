//
//  VTCreateAccountVC.m
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTCreateAccountVC.h"
#import "Kalay.h"
#import "VTWebBrowserVC.h"
#import "VTPromptActivateAccountVC.h"

@interface VTCreateAccountVC () <DLPresenterVCDelegate>

@property (weak, nonatomic) IBOutlet UITextField* emailTextField;
@property (weak, nonatomic) IBOutlet UITextField* passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField* passwordConfirmTextField;

@end

@implementation VTCreateAccountVC

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTWebBrowserVC class]]) {
        [self.navigationController dismissViewControllerAnimated: YES completion: nil];
    }
}

#pragma mark - UI Actions

-(IBAction)doShowTermOfUse
{
    VTWebBrowserVC* vc = [[VTWebBrowserVC alloc] init];
    vc.delegate = self;
    vc.url = [NSURL URLWithString: @"https://www.google.com"];
    vc.title = NSLocalizedString(@"Term of Use", @"View Controller Title");
    UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController: vc];
    [self.navigationController presentViewController: nvc animated: YES completion: nil];
}

-(IBAction)doCreate
{
    [self showProgress: NSLocalizedString(@"Creating Account...", @"Creating account hud title")];
    [KALAY createAccountWithEmail: self.emailTextField.text andPassword: self.passwordTextField.text onCompletion:^(NSError *error, NSDictionary *result) {
        [self hideProgress];
        [self performSegueWithIdentifier: @"showPromptActivateAccountSegue" sender: nil];
    }];
}

-(IBAction)doLogin
{
    [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"showLoginSegue"}];
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showPromptActivateAccountSegue"]) {
        VTPromptActivateAccountVC* vc = segue.destinationViewController;
        vc.promptTitle = NSLocalizedString(@"Account Created", @"Section Title");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
