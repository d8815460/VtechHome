//
//  VTAccessorySettingsVC.m
//  VTech MMI
//
//  Created by David Lin on 12/9/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTMotionSensorSettingVC.h"
#import "VTAccessorySignalStrengthTestHintVC.h"

@interface VTMotionSensorSettingVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) UISwitch* tamperNotificationSwitch;

@end

@implementation VTMotionSensorSettingVC


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    UITableViewCell* c = nil;
    if (row == 0 || row == 1) {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell1"];
        c.textLabel.text = @[NSLocalizedString(@"Motion detection settings", @"Accessory Detail Setting Table Row Title"),
                             NSLocalizedString(@"Test signal strength", @"Accessory Detail Setting Table Row Title")][row];
    } else {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell2"];
        UILabel* textLabel = [c viewWithTag: 1];
        self.tamperNotificationSwitch = [c viewWithTag: 2];
        textLabel.text = NSLocalizedString(@"Tamper Notificaiton", @"Accessory Detail Setting Table Row Title");
    }
    
    return c;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString* fmt = NSLocalizedString(@"Notify me when '%@' is tampered with", @"Motion sensor settings footer");
    return FORMAT(fmt, self.accessory[@"name"]);
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        [self performSegueWithIdentifier: @"doShowMotionDetectionSettingsSegue" sender: self];
    } if (row == 1) {
        NSString* fmt = NSLocalizedString(@"'%@' and your hub?", @"Dialog Message");
        UIAlertView* av = [UIAlertView bk_alertViewWithTitle: NSLocalizedString(@"Test signal strength", @"Dialog title") message: FORMAT(fmt, self.accessory[@"name"])];
        [av bk_addButtonWithTitle: NSLocalizedString(@"No", @"Button") handler: nil];
        [av bk_addButtonWithTitle: NSLocalizedString(@"Yes", @"Button") handler:^{
            UIStoryboard* sb = [UIStoryboard storyboardWithName: @"AccessorySignalStrengthCheck" bundle: nil];
            VTAccessorySignalStrengthTestHintVC* vc = [sb instantiateInitialViewController];
            vc.accessory = self.accessory;
            [self.navigationController pushViewController: vc animated: YES];
        }];
        [av show];
    } else if (row == 2) {
        self.tamperNotificationSwitch.on = !self.tamperNotificationSwitch.isOn;
    }
}

#pragma mark - UI Actions

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"doShowMotionDetectionSettingsSegue"]) {
        
    } else {
        [super prepareForSegue: segue sender: sender];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
