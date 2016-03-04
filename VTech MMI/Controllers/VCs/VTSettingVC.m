//
//  VTSettingVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTSettingVC.h"
#import "VTSettingCell.h"
#import "VTGatewayInfoVC.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>
#import "Kalay.h"

@interface VTSettingVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) NSDictionary* currentGateway;

@end

@implementation VTSettingVC

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [@[@2, @1, @1, @2][section] integerValue];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    VTSettingCell* c = nil;
    
    if (section == 0 && row == 1) {
        c = [tableView dequeueReusableCellWithIdentifier: @"switchCell"];
    } else {
        c = [tableView dequeueReusableCellWithIdentifier: @"drillDownCell"];
    }
    [c prepareForReuse];
    
    NSString* title = @[@[self.currentGateway[@"name"],
                          NSLocalizedString(@"LED Light Status", @"Setting Cell")],
                        @[NSLocalizedString(@"Backup", @"Setting Cell")],
                        @[NSLocalizedString(@"Restore", @"Setting Cell")],
                        @[NSLocalizedString(@"About this IP Hub", @"Setting Cell"),
                          NSLocalizedString(@"Reset", @"Setting Cell")]
                        ][section][row];
    c.settingTitleLabel.text = title;
    return c;
}

#pragma mark - UITableViewDelegate

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @[NSLocalizedString(@"Show IP Hub LED light status", @"Setting Section Footer"),
             NSLocalizedString(@"Backup your IP Hub configuration. Last Backup:", @"Setting Section Footer"),
             NSLocalizedString(@"Restore IP Hub configuration from backup and apply to an IP Hub", @"Setting Section Footer"),
             NSLocalizedString(@"Reset this IP Hub's settings. Clear Smart Task and Profile", @"Setting Section Footer")][section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger sec = indexPath.section;
    
    if (sec == 0) {
        if (row == 0) {
            UIAlertView* av = [UIAlertView
                               bk_alertViewWithTitle: NSLocalizedString(@"IP Hub Name", @"Dialog Title")
                               message: NSLocalizedString(@"Please enter a new name for the IP Hub", @"Dialog Title")];
            av.alertViewStyle = UIAlertViewStylePlainTextInput;
            [av bk_addButtonWithTitle: NSLocalizedString(@"Cancel", @"Button") handler:^{}];
            [av bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler:^{
                [self showProgress: NSLocalizedString(@"Updating Name...", @"Hud message")];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self hideProgress];
                    NSString* name = [av textFieldAtIndex: 0].text;
                    if (!name.length) name = @"Gateway Name";
                    NSMutableDictionary* tmp = [self.currentGateway mutableCopy];
                    tmp[@"name"] = name;
                    self.currentGateway = tmp;
                    [self.tableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
                });
            }];
            [av show];
        }
    } else if (sec == 1) {
        [self showProgress: NSLocalizedString(@"Backing Up...", @"Hud Message")];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideProgress];
            [self showInfoDialog: NSLocalizedString(@"Backup saved", @"Dialog Message")];
        });
        
    } else if (sec == 2) {
        [self showProgress: NSLocalizedString(@"Looking for backup...", @"Hud Message")];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideProgress];
            BOOL found = true;
            if (found) {
                UIAlertView* av = [UIAlertView
                                   bk_alertViewWithTitle: NSLocalizedString(@"Info", @"Dialog Title")
                                   message: NSLocalizedString(@"Backup found. Do you want to restore?", @"Dialog Message")];
                [av bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler: ^{
                    [self showProgress: NSLocalizedString(@"Restoring...", @"Hud Message")];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self hideProgress];
                        [self showInfoDialog: NSLocalizedString(@"IP Hub restored successfully", @"Dialog Message")];
                        
                    });
                }];
                [av show];
            }
        });
        
    } else if (sec == 3) {
        if (row == 0) {
            [self performSegueWithIdentifier: @"showGatewayInfoSegue" sender: nil];
        } else if (row == 1) {
            UIAlertView* av = [UIAlertView
                               bk_alertViewWithTitle: NSLocalizedString(@"Warning", @"Dialog Title")
                               message: NSLocalizedString(@"IP Hub'ssettings, tasks, and profiles will be reset. ULE devices will remain. Are you sure to rest?", @"Dialog Message")];
            [av bk_addButtonWithTitle: NSLocalizedString(@"NO", @"Button") handler:^{}];
            [av bk_addButtonWithTitle: NSLocalizedString(@"YES", @"Button") handler:^{
                [self showProgress: NSLocalizedString(@"Restoring...", @"Hud message")];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self hideProgress];
                    [self showInfoDialog: NSLocalizedString(@"IP Hub is reset", @"Dialog Message")];
                });
            }];
            [av show];
        }
    }
    
}

#pragma mark - UI Actions

-(IBAction)doShowMenu
{
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight)
        [self.slidingViewController resetTopViewAnimated: YES];
    else {
        [self.slidingViewController anchorTopViewToRightAnimated: YES];
    }
}

-(IBAction)doSaveSetting
{
    
}

-(IBAction)doRemoveGateway
{
    UIAlertView* av = [UIAlertView
                       bk_alertViewWithTitle: NSLocalizedString(@"Warning", @"Dialog Title")
                       message: [NSString stringWithFormat: NSLocalizedString(@"Are you sure to remove '%@'?", @"Dialog Message"), self.currentGateway[@"name"]]];
    [av bk_addButtonWithTitle: NSLocalizedString(@"NO", @"Button") handler:^{}];
    [av bk_addButtonWithTitle: NSLocalizedString(@"YES", @"Button") handler:^{
        [self showProgress:[NSString stringWithFormat: NSLocalizedString(@"Removing '%@'...", @"Hud message"), self.currentGateway[@"name"]]];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideProgress];
            [self showInfoDialog: NSLocalizedString(@"IP Hud is removed", @"Dialog Message")];
        });
    }];
    [av show];
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showGatewayInfoSegue"]) {
        VTGatewayInfoVC* vc = segue.destinationViewController;
        vc.gateway = self.currentGateway;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    self.currentGateway = @{@"name": @"HOME",
                            @"status": @"Connected",
                            @"mac": @"xxxxx",
                            @"udid": @"yyyyy",
                            @"firmwareVersion": @"1.2",
                            @"hardwareVersion": @"1.4",
                            @"ipAddress": @"127.0.0.1",
                            @"subnetMask": @"255.255.255.0",
                            @"gateway": @"127.0.0.1"};
}

@end
