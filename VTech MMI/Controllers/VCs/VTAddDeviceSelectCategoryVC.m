//
//  VTAddDeviceSelectCategoryVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTAddDeviceSelectCategoryVC.h"
#import "VTAddDeviceHelpPageForSensorVC.h"

@interface VTAddDeviceSelectCategoryVC ()

@end

@implementation VTAddDeviceSelectCategoryVC

#pragma mark - UI Actions

-(IBAction)doSelectIPHud
{
    UIStoryboard* sb = [UIStoryboard storyboardWithName: @"AddGateway" bundle: nil];
    UIViewController* vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController: vc animated: YES];
}

-(IBAction)doSelectSensorType:(UIButton*)btn
{
    if (btn.tag == 6) {
        [self performSegueWithIdentifier: @"showAddLightSegue" sender: @(btn.tag - 1)];        
    } else {
        [self performSegueWithIdentifier: @"showAddSensorSegue" sender: @(btn.tag - 1)];
    }
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showAddSensorSegue"]) {
        VTAddDeviceHelpPageForSensorVC* vc = segue.destinationViewController;
        vc.gateway = @{@"name": @"Hub 1"};
        vc.sensorType = [sender integerValue];
    }
}

-(void)viewDidLoad {
    [super viewDidLoad];
}

@end
