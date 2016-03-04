//
//  VTGroupDetailVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTGroupDetailVC.h"
#import "VTIconChooserVC.h"
#import "VTGroupChooserVC.h"

@interface VTGroupDetailVC ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, DLPresenterVCDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISlider* brightnessSlider;
@property (weak, nonatomic) IBOutlet UIView* normalModeControlPanel;
@property (weak, nonatomic) IBOutlet UIView* editModeControlPanel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* editBarButtonItem;

@property (readonly) NSArray* lights;

@end

@implementation VTGroupDetailVC

-(NSArray *)lights
{
    return self.group[@"lights"];
}

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTIconChooserVC class]]) {
        VTIconChooserVC* casted = (id)vc;
        self.iconImageView.image = [UIImage imageNamed: casted.selectedIconName];
        self.iconImageView.backgroundColor = [UIColor clearColor];
        [self.navigationController popViewControllerAnimated: YES];
    } else if ([vc isKindOfClass: [VTGroupChooserVC class]]) {
        [self.navigationController popViewControllerAnimated: YES];
        if ([info[@"result"] isEqualToString: @"done"]) {
            NSDictionary* group = info[@"group"];
            if (![group[@"name"] isEqualToString: self.group[@"name"]]) {
                // should remove lights here
                [self.tableView reloadData];
            }
            
        }
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lights.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    if (row == self.lights.count) {
        c.textLabel.text = NSLocalizedString(@"Light Setting", @"Group Table Row Title");
    } else {
        NSDictionary* light = self.lights[row];
        c.textLabel.text = light[@"name"];
    }
    
    return c;
}

#pragma mark - UITableViewDelegate

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (self.tableView.isEditing) {
        self.editModeControlPanel.hidden = NO;
    } else {
        if (row == self.lights.count) {
            [self performSegueWithIdentifier: @"showChangeLightSettingSegue" sender: self];
        }
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.isEditing) {
        self.editModeControlPanel.hidden = (self.tableView.indexPathsForSelectedRows.count == 0);
    }
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.nameTextField) {
        return self.isEditing;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UI Actions

-(IBAction)doToggleEditMode:(UIBarButtonItem*)barButtonItem
{
    self.editing = !self.isEditing;
    [self.tableView setEditing: self.editing animated: YES];
    self.editModeControlPanel.hidden = (self.tableView.indexPathsForSelectedRows.count == 0);
    self.normalModeControlPanel.hidden = self.editing;
    if (self.isEditing) {
        barButtonItem.title = NSLocalizedString(@"Done", @"Button");
    } else {
        barButtonItem.title = NSLocalizedString(@"Edit", @"Button");
    }
}

- (IBAction)doChangeIcon:(id)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName: @"IconChooser" bundle: nil];
    VTIconChooserVC* vc = [sb instantiateViewControllerWithIdentifier: @"iconChooserVC"];
    vc.delegate = self;
    vc.selectedIconName = @"ic_light";
    vc.iconNames = @[@"ic_light", @"ic_garage", @"ic_motion", @"ic_switch"];
    [self.navigationController pushViewController: vc animated: YES];
}

-(IBAction)doReassignSelectedLights
{
    [self performSegueWithIdentifier: @"showReassignGroupSegue" sender: self];
}

-(IBAction)doDeleteSelectedLights
{
    // should delete lights here
    [self doToggleEditMode: self.editBarButtonItem];
}

-(IBAction)doAddLight
{
    
}

-(IBAction)doDeleteGroup
{
    NSString* hubName = @"HUB_NAME";
    NSString* fmt = NSLocalizedString(@"Remove '%@' from '%@'?", @"Remove group from hub");
    NSString* title = FORMAT(fmt, self.group[@"name"], hubName);
    fmt = NSLocalizedString(@"These devices wil not be removed individually from '%@'", @"Remove group from hub message");
    NSString* message = FORMAT(fmt, hubName);
    UIAlertView* av = [UIAlertView bk_alertViewWithTitle: title message: message];
    [av bk_addButtonWithTitle: NSLocalizedString(@"No", @"Button") handler: nil];
    [av bk_addButtonWithTitle: NSLocalizedString(@"Yes", @"Button") handler: ^{
        [self showProgress: NSLocalizedString(@"Please wait...", @"Progress Hud")];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideProgress];
            NSString* fmt = NSLocalizedString(@"'%@' removed", @"Group removed");
            NSString* message = FORMAT(fmt, self.group[@"name"]);
            UIAlertView* av2 = [UIAlertView bk_alertViewWithTitle: nil message: message];
            [av2 bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler:^{
                [self.navigationController popToRootViewControllerAnimated: YES];
            }];
            [av2 show];
        });
    }];
    [av show];
}

- (IBAction)onBrightnessChanged:(id)sender {
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showChangeLightSettingSegue"]) {

    } else if ([segue.identifier isEqualToString: @"showReassignGroupSegue"]) {
        VTGroupChooserVC* vc = segue.destinationViewController;
        vc.selectedGroup = self.group;
        vc.delegate = self;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"cell"];
    
    self.title = self.group[@"name"];
    [self.locationButton setTitle: self.group[@"location"] forState: UIControlStateNormal];
    self.nameTextField.text = self.group[@"name"];
    
    self.iconImageView.backgroundColor = [UIColor blackColor];
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width/2;
    self.iconImageView.clipsToBounds = YES;
}

@end
