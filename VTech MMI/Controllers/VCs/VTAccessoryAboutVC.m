//
//  VTAccessoryAboutVC.m
//  VTech MMI
//
//  Created by David Lin on 12/9/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTAccessoryAboutVC.h"

@interface VTAccessoryAboutVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end

@implementation VTAccessoryAboutVC

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    UITableViewCell* c = nil;
    
    if (row == 0 || row == 1) c = [tableView dequeueReusableCellWithIdentifier: @"cell1"];
    else c = [tableView dequeueReusableCellWithIdentifier: @"cell2"];
    
    c.textLabel.text = @[NSLocalizedString(@"UDID", @"Accessory About VC Row Title"),
                         NSLocalizedString(@"Type", @"Accessory About VC Row Title"),
                         NSLocalizedString(@"Firmware Version", @"Accessory About VC Row Title")][row];
    c.detailTextLabel.text = @[self.accessory[@"udid"],
                               self.accessory[@"type"],
                               self.accessory[@"firmware"]][row];
    
    return c;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return NSLocalizedString(@"Tap to check new firmware update", @"Accessroy About VC section 1 footer");
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
