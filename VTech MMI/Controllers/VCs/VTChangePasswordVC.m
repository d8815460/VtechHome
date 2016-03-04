//
//  VTChangePasswordVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTChangePasswordVC.h"

@interface VTChangePasswordVC () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) UITextField* oldPasswordTextField;
@property (weak, nonatomic) UITextField* passwordTextField;
@property (weak, nonatomic) UITextField* passwordConfirmTextField;

@end

@implementation VTChangePasswordVC

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if (section == 3) {
        return [tableView dequeueReusableCellWithIdentifier: @"updateCell"];
    }
    
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"passwordCell"];
    [c prepareForReuse];
    
    UITextField* tf = [c viewWithTag: 1];
    tf.delegate = self;
    if (section == 0) self.oldPasswordTextField = tf;
    else if (section == 1) self.passwordTextField = tf;
    else if (section == 2) self.passwordConfirmTextField = tf;
    
    return c;
}

#pragma mark - UITableViewDelegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"Old Password", @"Table Section Header");
    } else if (section == 1) {
        return NSLocalizedString(@"New Password", @"Table Section Header");
    } else if (section == 2) {
        return NSLocalizedString(@"Confirm New Password", @"Table Section Header");
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        [self showProgress: NSLocalizedString(@"Updating...", @"Message Hud")];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideProgress];
            
            UIAlertView* av = [UIAlertView bk_alertViewWithTitle: NSLocalizedString(@"Info", @"Dialog Title") message: NSLocalizedString(@"Your password has been udpated", @"Dialog Message")];
            [av bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler:^{
                [self.navigationController popViewControllerAnimated: YES];
            }];
            [av show];
        });
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}


@end
