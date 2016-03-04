//
//  VTSwitchDetailVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTSwitchDetailVC.h"
#import "VTSwitchAssignVC.h"

@interface VTSwitchDetailVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation VTSwitchDetailVC


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    [c prepareForReuse];
    c.selectionStyle = UITableViewCellSelectionStyleNone;
    c.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    c.textLabel.text = @[NSLocalizedString(@"Assign Switches", @"Accessory Detail Row"),
                         NSLocalizedString(@"Settings", @"Accessory Detail Row"),
                         NSLocalizedString(@"About", @"Accessory Detail Row")][indexPath.row];
    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        [self performSegueWithIdentifier: @"showAssignSwitchSegue" sender: self];
    } else if (row == 1) {
        [self performSegueWithIdentifier: @"showBasicAccessorySettingsSegue" sender: self];
    } else if (row == 2) {
        [self performSegueWithIdentifier: @"showAboutSegue" sender: self];
    }
}


#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showAssignSwitchSegue"]) {
        VTSwitchAssignVC* vc = segue.destinationViewController;
        vc.accessory = self.accessory;
    } else {
        [super prepareForSegue: segue sender: sender];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
