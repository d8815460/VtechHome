//
//  VTGatewayInfoVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTGatewayInfoVC.h"

@interface VTGatewayInfoVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;


@end

@implementation VTGatewayInfoVC

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    [c prepareForReuse];
    
    c.textLabel.text = @[NSLocalizedString(@"Status", @"Gateway Info Cell Title"),
                         NSLocalizedString(@"MAC Address", @"Gateway Info Cell Title"),
                         NSLocalizedString(@"UDID", @"Gateway Info Cell Title"),
                         NSLocalizedString(@"Firmware Version", @"Gateway Info Cell Title"),
                         NSLocalizedString(@"Hardware Version", @"Gateway Info Cell Title"),
                         NSLocalizedString(@"IP Address", @"Gateway Info Cell Title"),
                         NSLocalizedString(@"Subnet Mask", @"Gateway Info Cell Title"),
                         NSLocalizedString(@"Gateway", @"Gateway Info Cell Title")][row];
    
    c.detailTextLabel.text = @[self.gateway[@"status"],
                               self.gateway[@"mac"],
                               self.gateway[@"udid"],
                               self.gateway[@"firmwareVersion"],
                               self.gateway[@"hardwareVersion"],
                               self.gateway[@"ipAddress"],
                               self.gateway[@"subnetMask"],
                               self.gateway[@"gateway"]][row];
    
    if (row == 3) c.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 3) {
        [self showProgress: NSLocalizedString(@"Checking...", @"Hud Message")];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideProgress];
            BOOL found = true;
            if (found) {
                UIAlertView* av = [UIAlertView
                                   bk_alertViewWithTitle: NSLocalizedString(@"Info", @"Dialog Title")
                                   message: NSLocalizedString(@"New firmware update is available. Do you want to update now?", @"Dialog Message")];
                [av bk_addButtonWithTitle: NSLocalizedString(@"Do it later", @"Button") handler: ^{}];
                [av bk_addButtonWithTitle: NSLocalizedString(@"Update now", @"Button") handler: ^{
                    [self showProgress: NSLocalizedString(@"Updating firmware...", @"Hud Message")];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self hideProgress];
                        [self showInfoDialog: NSLocalizedString(@"Firmware is up to date", @"Dialog Message")];
                        
                    });
                }];
                [av show];
            } else {
                [self showInfoDialog: NSLocalizedString(@"Firmware is up to date", @"Dialog Message")];
            }
        });
    }
}

#pragma mark - UI Actions

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}

@end
