//
//  VTAccessoryDetailVC.m
//  VTech MMI
//
//  Created by David Lin on 12/9/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTAccessoryDetailVC.h"
#import "VTAccessoryAboutVC.h"
#import "VTBasicAccessorySettingVC.h"
#import "VTMotionSensorSettingVC.h"
#import "VTLocationChooserVC.h"
#import "VTIconChooserVC.h"

@interface VTAccessoryDetailVC () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, DLPresenterVCDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *warningIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *warningHolderView;

@end

@implementation VTAccessoryDetailVC

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTLocationChooserVC class]]) {
        NSString* location = info[@"updateLocation"];
        NSMutableDictionary* tmp = [self.accessory mutableCopy];
        tmp[@"location"] = location;
        self.accessory = tmp;
        [self.locationButton setTitle: self.accessory[@"location"] forState: UIControlStateNormal];
    } else if ([vc isKindOfClass: [VTIconChooserVC class]]) {
        VTIconChooserVC* casted = (id)vc;
        self.iconImageView.image = [UIImage imageNamed: casted.selectedIconName];
        self.iconImageView.backgroundColor = [UIColor clearColor];
        [self.navigationController popViewControllerAnimated: YES];
    }
}

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
    c.textLabel.text = @[NSLocalizedString(@"Tasks", @"Accessory Detail Row"),
                         NSLocalizedString(@"Settings", @"Accessory Detail Row"),
                         NSLocalizedString(@"About", @"Accessory Detail Row")][indexPath.row];
    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
    } else if (row == 1) {
        if ([self.accessory[@"type"] isEqualToString: @"motion"]) {
            [self performSegueWithIdentifier: @"showMotionSensorSettingsSeuge" sender: self];
        } else {
            [self performSegueWithIdentifier: @"showBasicAccessorySettingsSegue" sender: self];
        }
        
    } else if (row == 2) {
        [self performSegueWithIdentifier: @"showAboutSegue" sender: self];
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

- (IBAction)doChangeLocation:(id)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName: @"LocationChooser" bundle: nil];
    VTLocationChooserVC* vc = [sb instantiateViewControllerWithIdentifier: @"locationChooserVC"];
    vc.delegate = self;
    vc.selectedLocationName = self.accessory[@"location"];
    [self.navigationController pushViewController: vc animated: YES];
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showAboutSegue"]) {
        VTAccessoryAboutVC* vc = segue.destinationViewController;
        vc.accessory = self.accessory;
    } else if ([segue.identifier isEqualToString: @"showBasicAccessorySettingsSegue"]) {
        VTBasicAccessorySettingVC* vc = segue.destinationViewController;
        vc.accessory = self.accessory;
    } else if ([segue.identifier isEqualToString: @"showMotionSensorSettingsSeuge"]) {
        VTMotionSensorSettingVC* vc = segue.destinationViewController;
        vc.accessory = self.accessory;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"cell"];
    
    self.title = self.accessory[@"name"];
    [self.locationButton setTitle: self.accessory[@"location"] forState: UIControlStateNormal];
    self.nameTextField.text = self.accessory[@"name"];
    
    self.iconImageView.backgroundColor = [UIColor blackColor];
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width/2;
    self.iconImageView.clipsToBounds = YES;
}

@end
