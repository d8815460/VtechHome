//
//  VTAddDeviceHelpPageForSensorVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTAddDeviceHelpPageForSensorVC.h"
#import "VTAddDeviceSuccessfulVC.h"

@interface VTAddDeviceHelpPageForSensorVC ()

@property (weak, nonatomic) IBOutlet UIImageView* powerUpDeviceTypeHintImageView;
@property (weak, nonatomic) IBOutlet UILabel* powerUpDeviceTypeHintLabel;

@property (weak, nonatomic) IBOutlet UIImageView* pressPairKeyHintForDeviceTypeHintImageView;
@property (weak, nonatomic) IBOutlet UILabel* pressPairKeyHintForDeviceTypeHintLabel;

@end

@implementation VTAddDeviceHelpPageForSensorVC

#pragma mark - UI Actions

-(IBAction)doShowHintForIPHubLEDNotBlinking
{
    UIAlertView* av = [UIAlertView
                       bk_alertViewWithTitle: NSLocalizedString(@"The LED still does not blink?", @"Dialog Title")
                       message: NSLocalizedString(@"Reconnect your IP Hub. Make sure your network can connect to the Internet", @"Dialog Message")];
    [av bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler:^{}];
    [av show];

}

-(IBAction)doNextStep
{
    [self showProgress: NSLocalizedString(@"Registering...", @"Message Hud")];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideProgress];
        [self performSegueWithIdentifier: @"showRegistrationSuccessfulSegue" sender: nil];
    });
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showRegistrationSuccessfulSegue"]) {
        VTAddDeviceSuccessfulVC* vc = segue.destinationViewController;
        vc.gateway = self.gateway;
        vc.sensorType = self.sensorType;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* deviceType = @[NSLocalizedString(@"Garage Sensor", @"Sensor Type"),
                             NSLocalizedString(@"Motion Sensor", @"Sensor Type"),
                             NSLocalizedString(@"Contact Sensor", @"Sensor Type"),
                             NSLocalizedString(@"Wall Switch", @"Sensor Type"),
                             NSLocalizedString(@"LED Lights", @"Sensor Type")][self.sensorType];

    self.title = FORMAT(NSLocalizedString(@"Add to %@", @"Add to hub vc title"), self.gateway[@"name"]);
    self.powerUpDeviceTypeHintLabel.text =
        FORMAT(NSLocalizedString(@"Power up your %@", @"Add Device Hint"), deviceType);
    self.pressPairKeyHintForDeviceTypeHintLabel.text =
        FORMAT(NSLocalizedString(@"Press and hold the pair key until the %@ LED flashes", @"Add Device Hint"), deviceType);
}

@end
