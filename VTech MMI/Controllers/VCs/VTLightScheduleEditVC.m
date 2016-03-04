//
//  VTLightScheduleEditVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTLightScheduleEditVC.h"

@interface VTLightScheduleEditVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) UISwitch* powerOnSwitch;
@property (strong, nonatomic) UISwitch* powerOffSwitch;
@property (nonatomic) BOOL isCreatedNewSchedule;

@end

@implementation VTLightScheduleEditVC


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    UITableViewCell* c = nil;
    UILabel* textLabel;
    UILabel* detailTextLabel;
    if (row == 0 || row == 4) {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell2"];
        textLabel = [c viewWithTag: 1];
        UISwitch* sw = [c viewWithTag: 2];
        if (row == 0) {
            self.powerOnSwitch = sw;
        } else {
            self.powerOnSwitch = sw;
        }
    } else if (row == 1 || row == 2 || row == 5 || row == 6) {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell3"];
        textLabel = c.textLabel;
        detailTextLabel = c.detailTextLabel;
    } else {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell1"];
        textLabel = c.textLabel;
    }
    
    textLabel.text = @[NSLocalizedString(@"Power On", @"Schedule Row Title"),
                       [self.schedule[@"powerOnTime"] description],
                       [self.schedule[@"powerOnDuration"] description],
                       NSLocalizedString(@"Effect", @"Schedule Row Title"),
                       NSLocalizedString(@"Power Off", @"Schedule Row Title"),
                       [self.schedule[@"powerOffTime"] description],
                       [self.schedule[@"powerOffDuration"] description],
                       NSLocalizedString(@"Repeat", @"Schedule Row Title")][row];
    
    detailTextLabel.text = @[@"",
                             NSLocalizedString(@"Set the time you want to wake up", @"Schedule Row Title"),
                             NSLocalizedString(@"Set how long it talkes the light bulb to be fully switched on", @"Schedule Row Title"),
                             @"",
                             @"",
                             NSLocalizedString(@"Set the time you want to go to bed", @"Schedule Row Title"),
                             NSLocalizedString(@"Set how long it talkes the light bulb to be fully switchedoffon", @"Schedule Row Title"),
                             NSLocalizedString(@"Power Off", @"Schedule Row Title"),
                             self.schedule[@"repeat"]][row];
    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
}

#pragma mark - UI Actions

-(IBAction)doDeleteSchedule
{
    if (self.isCreatedNewSchedule) return;
    
    UIAlertView* av = [UIAlertView bk_alertViewWithTitle: NSLocalizedString(@"Warning", @"Dialog Title") message: NSLocalizedString(@"Delete schedule?", @"Dialog message")];
    [av bk_addButtonWithTitle: NSLocalizedString(@"Cancel", @"Button") handler: nil];
    [av bk_addButtonWithTitle: NSLocalizedString(@"Delete", @"Button") handler:^{
        [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"deleted"}];
    }];
    [av show];
}

-(IBAction)doSave
{
    [self.delegate presenteeVC: self
           didCompleteWithInfo: @{@"result": @"done",
                                  @"schedule": self.schedule,
                                  @"isNew": @(self.isCreatedNewSchedule)}];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isCreatedNewSchedule = self.schedule == nil;
    if (self.isCreatedNewSchedule) {
        self.schedule = @{@"powerOnTime": @"8:00",
                          @"powerOn": @YES,
                          @"powerOnDuration": @300,
                          @"powerOff": @YES,
                          @"powerOffTime": @"10:00",
                          @"powerOffDuration": @300,
                          @"repeat": @127};
    }
}


@end
