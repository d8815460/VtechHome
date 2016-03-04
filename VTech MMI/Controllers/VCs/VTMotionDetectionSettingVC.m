//
//  VTMotionDetectionSettingVC.m
//  VTech MMI
//
//  Created by David Lin on 12/9/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTMotionDetectionSettingVC.h"
#import <Masonry/Masonry.h>

@interface VTMotionDetectionSettingVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) IBOutlet UISwitch* petImmunitySwitch;
@property (strong, nonatomic) IBOutlet UISwitch* LEDLighStatusSwitch;

@end

@implementation VTMotionDetectionSettingVC


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 2;
    if (section == 1) return 1;
    if (section == 2) return 1;
    if (section == 3) return 1;
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger sec = indexPath.section;
    
    UITableViewCell* c = nil;
    
    if (sec == 0) {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell1"];
        c.textLabel.text = @[NSLocalizedString(@"Sensitivity", @"Motion Detection Setting Table Row Title"),
                             NSLocalizedString(@"Trigger Mode", @"Motion Detection Setting Table Row Title")][row];
    } else if (sec == 1) {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell2"];
        UILabel* textLabel = [c viewWithTag: 1];
        self.petImmunitySwitch = [c viewWithTag: 2];
        textLabel.text = @[NSLocalizedString(@"Pet Immunity On/Off", @"Motion Detection Setting Table Row Title")][row];
    } else if (sec == 2) {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell1"];
        c.textLabel.text = @[NSLocalizedString(@"Hold Off Time", @"Motion Detection Setting Table Row Title")][row];
    } else if (sec == 3) {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell2"];
        UILabel* textLabel = [c viewWithTag: 1];
        self.LEDLighStatusSwitch = [c viewWithTag: 2];
        textLabel.text = @[NSLocalizedString(@"LED Light Status", @"Motion Detection Setting Table Row Title")][row];
    }
    
    return c;
}


-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @[NSLocalizedString(@"Insert explanation of different trigger modes", @"Motion Detection Table section footer"),
             NSLocalizedString(@"Insert explanation of pet immunity", @"Motion Detection Table section footer"),
             NSLocalizedString(@"Time in which the sensor is insensitive to motion. Using a shorter hold off time (less than 60 seconds) may decrease battery life of sensor", @"Motion Detection Table section footer"),
             NSLocalizedString(@"LED indication to show when sensor has detected motion", @"Motion Detection Table section footer")
             ][section];
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 2) {
        [self showProgress: NSLocalizedString(@"Processing...", @"Progress Hud")];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideProgress];
            [self showInfoDialog: NSLocalizedString(@"There is no firmware update", @"Check firmware result dialog")];
        });
    }
}



#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
