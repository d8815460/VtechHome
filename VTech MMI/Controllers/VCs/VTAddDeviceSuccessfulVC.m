//
//  VTAddDeviceSuccessfulVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTAddDeviceSuccessfulVC.h"
#import "VTLocationChooserVC.h"

@interface VTAddDeviceSuccessfulVC () <UITextFieldDelegate, DLPresenterVCDelegate>

@property (strong, nonatomic) NSDictionary* sensor;

@property (weak, nonatomic) IBOutlet UIImageView* sensorImageView;
@property (weak, nonatomic) IBOutlet UIButton* sensorLocationButton;
@property (weak, nonatomic) IBOutlet UITextField* sensorNameTextField;
@property (weak, nonatomic) IBOutlet UIButton* addMoreDeviceTypeButton;

@end

@implementation VTAddDeviceSuccessfulVC

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTLocationChooserVC class]]) {
        NSString* location = info[@"updateLocation"];
        NSMutableDictionary* tmp = [self.sensor mutableCopy];
        tmp[@"location"] = location;
        self.sensor = tmp;
        [self.sensorLocationButton setTitle: self.sensor[@"location"] forState: UIControlStateNormal];
    }
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UI Actions

-(IBAction)doChangeSensorImage
{
    
}

-(IBAction)doChangeSensorLocation
{
    UIStoryboard* sb = [UIStoryboard storyboardWithName: @"LocationChooser" bundle: nil];
    VTLocationChooserVC* vc = [sb instantiateViewControllerWithIdentifier: @"locationChooserVC"];
    vc.delegate = self;
    vc.selectedLocationName = self.sensor[@"location"];
    [self.navigationController pushViewController: vc animated: YES];
}

-(IBAction)doFinished
{
    [self.navigationController popToRootViewControllerAnimated: YES];
}

-(IBAction)doAddDifferentTypeDevice
{
    NSInteger lastIndex = self.navigationController.childViewControllers.count - 1;
    UIViewController* vc = self.navigationController.childViewControllers[lastIndex-2];
    [self.navigationController popToViewController: vc animated: YES];
}

-(IBAction)doAddMoreDevice
{
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sensor = @{@"location": @"Bedroom", @"name": @""};
    
    NSString* deviceType = @[NSLocalizedString(@"Garage Sensor", @"Sensor Type"),
                             NSLocalizedString(@"Motion Sensor", @"Sensor Type"),
                             NSLocalizedString(@"Contact Sensor", @"Sensor Type"),
                             NSLocalizedString(@"Wall Switch", @"Sensor Type"),
                             NSLocalizedString(@"LED Lights", @"Sensor Type")][self.sensorType];

    self.title = FORMAT(NSLocalizedString(@"Add to %@", @"Add to hub vc title"), self.gateway[@"name"]);
    [self.addMoreDeviceTypeButton setTitle: FORMAT(NSLocalizedString(@"Add more %@", @"Add more same type device button"), deviceType) forState:UIControlStateNormal];
    
    [self.sensorLocationButton setTitle: self.sensor[@"location"] forState: UIControlStateNormal];
}

@end
