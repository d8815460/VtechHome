//
//  VTLightSettingVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTLightSettingVC.h"
#import "VTAccessorySignalStrengthTestHintVC.h"
#import "VTLightScheduleEditVC.h"

@interface VTLightSettingVC () <UITableViewDataSource, UITableViewDelegate, DLPresenterVCDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) UISwitch* fadingSwitch;
@property (strong, nonatomic) NSMutableArray* scheduleSwitches;
@property (strong, nonatomic) NSArray* schedules;

@end

@implementation VTLightSettingVC

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTLightScheduleEditVC class]]) {
        [self.navigationController popViewControllerAnimated: YES];
        if ([info[@"result"] isEqualToString: @"deleted"]) {
            NSMutableArray* tmp = [self.schedules mutableCopy];
            [tmp removeObjectAtIndex: self.tableView.indexPathForSelectedRow.row-1];
            self.schedules = tmp;
        } else if ([info[@"result"] isEqualToString: @"done"]) {
            NSMutableArray* tmp = [self.schedules mutableCopy];
            NSDictionary* schedule = info[@"schedule"];
            if ([info[@"isNew"] boolValue]) {
                [tmp addObject: schedule];
                self.schedules = tmp;
            } else {
                [tmp removeObjectAtIndex: self.tableView.indexPathForSelectedRow.row-1];
                [tmp insertObject: schedule atIndex: self.tableView.indexPathForSelectedRow.row-1];
            }
        }
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    if (section == 1) return 1 + self.schedules.count;
    if (section == 2) return 1;
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    
    UITableViewCell* c = nil;
    if (sec == 0) {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell2"];
        UILabel* textLabel = (id)[c viewWithTag: 1];
        textLabel.text = NSLocalizedString((@"Fading"), @"Light Setting Row Title");
        self.fadingSwitch = (id)[c viewWithTag: 2];
    } else if (sec == 1) {
        if (row == 0) {
            c = [tableView dequeueReusableCellWithIdentifier: @"cell1"];
            c.textLabel.text = NSLocalizedString(@"Add Schedule...", @"Light Setting Row Title");
            c.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            row --;
            c = [tableView dequeueReusableCellWithIdentifier: @"cell2"];
            NSDictionary* schedule = self.schedules[row];
            UILabel* textLabel = (id)[c viewWithTag: 1];
            textLabel.text = schedule[@"powerOnTime"];
            self.scheduleSwitches[row] = [c viewWithTag: 2];
        }
    } else if (sec == 2) {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell1"];
        c.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        c.textLabel.text = @[NSLocalizedString(@"Test signal strength", @"Light Setting Row Title")][row];
    }
    return c;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"Light bulb will be switched on and off gradually", @"Light Setting Section Footer");
    }
    return nil;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    if (sec == 0) {
        self.fadingSwitch.on = !self.fadingSwitch.isOn;
    } if (sec == 1) {
        if (row == 0) {
            [self performSegueWithIdentifier: @"showAddScheduleSegue" sender: self];
        } else {
            [self performSegueWithIdentifier: @"showEditScheduleSegue" sender: self];
        }
    } else if (sec == 2) {
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
    }
}

#pragma mark - UI Actions

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showAddScheduleSegue"]) {
        VTLightScheduleEditVC* vc = segue.destinationViewController;
        vc.delegate = self;
    } else if ([segue.identifier isEqualToString: @"showEditScheduleSegue"]) {
        VTLightScheduleEditVC* vc = segue.destinationViewController;
        vc.delegate = self;
        vc.schedule = self.schedules[self.tableView.indexPathForSelectedRow.row-1];
    } else {
        [super prepareForSegue: segue sender: sender];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.schedules = @[@{@"powerOnTime": @"8:00",
                         @"powerOn": @YES,
                         @"powerOnDuration": @300,
                         @"powerOff": @YES,
                         @"powerOffTime": @"10:00",
                         @"powerOffDuation": @300,
                         @"repeat": @127},
                       @{@"powerOnTime": @"9:00",
                         @"powerOn": @YES,
                         @"powerOnDuration": @300,
                         @"powerOff": @YES,
                         @"powerOffTime": @"10:00",
                         @"powerOffDuation": @300,
                         @"repeat": @127}];
    self.scheduleSwitches = [[NSMutableArray alloc] initWithCapacity: self.schedules.count];
}


@end
