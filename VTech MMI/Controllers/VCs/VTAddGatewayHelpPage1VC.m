//
//  VTAddGatewayHelpPage1VC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTAddGatewayHelpPage1VC.h"

@interface VTAddGatewayHelpPage1VC ()

@end

@implementation VTAddGatewayHelpPage1VC

#pragma mark - UI Action

-(IBAction)doShowHintForIPHubLEDNotBlinking
{
    UIAlertView* av = [UIAlertView
                       bk_alertViewWithTitle: NSLocalizedString(@"The LED still does not blink?", @"Dialog Title")
                       message: NSLocalizedString(@"Reconnect your IP Hub. Make sure your network can connect to the Internet", @"Dialog Message")];
    [av bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler:^{}];
    [av show];
    
}


#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
