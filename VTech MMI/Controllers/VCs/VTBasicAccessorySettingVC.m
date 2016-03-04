//
//  VTAccessoryTaskVC.m
//  VTech MMI
//
//  Created by David Lin on 12/9/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBasicAccessorySettingVC.h"
#import "VTAccessorySignalStrengthTestHintVC.h"

@interface VTBasicAccessorySettingVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end

@implementation VTBasicAccessorySettingVC

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    c.textLabel.text = @[NSLocalizedString(@"Test signal strength", @"Accessory Detail Tasks Table Row Title")][row];
    
    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
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

- (IBAction)doRemoveAccessory:(id)sender {
    __block BOOL cancelled = NO;
    NSString* fmt = NSLocalizedString(@"Remove '%@'", @"Dialog Title");
    NSString* title = FORMAT(fmt, self.accessory[@"name"]);
    fmt = NSLocalizedString(@"Remove '%@' permanently?", @"Dialog Message");
    NSString* message = FORMAT(fmt, self.accessory[@"name"]);
    UIAlertView* av = [UIAlertView bk_alertViewWithTitle: title message: message];
    [av bk_addButtonWithTitle: NSLocalizedString(@"No", @"Button") handler: nil];
    [av bk_addButtonWithTitle: NSLocalizedString(@"Yes", @"Button") handler:^{
        NSString* fmt = NSLocalizedString(@"Removing '%@' from '%@'", @"Dialog Title");
        NSString* title = FORMAT(fmt, self.accessory[@"name"], @"HUB NAME");
        NSString* message = NSLocalizedString(@"Please wait...", @"Dialog Message");
        UIAlertView* av2 = [UIAlertView bk_alertViewWithTitle: title message: message];
        [av2 bk_addButtonWithTitle: NSLocalizedString(@"Cancel", @"Button") handler: ^{ cancelled = YES; }];
        [av2 show];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (cancelled) return;
            [av2 dismissWithClickedButtonIndex: 0 animated: YES];
            NSString* fmt = NSLocalizedString(@"'%@' removed", @"Dialog message");
            NSString* message = FORMAT(fmt, self.accessory[@"name"]);
            UIAlertView* av3 = [UIAlertView bk_alertViewWithTitle: nil message: message];
            [av3 bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler: ^{
                [self.navigationController popToRootViewControllerAnimated: YES];
            }];
            [av3 show];
        });
    }];
    [av show];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
