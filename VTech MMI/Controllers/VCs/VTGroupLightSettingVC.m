//
//  VTGroupLightSettingVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTGroupLightSettingVC.h"
#import "VTLightEffectChooserVC.h"
#import "VTLightScheduleEditVC.h"

@interface VTGroupLightSettingVC () <UITableViewDataSource, UITableViewDelegate, DLPresenterVCDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) UISwitch* fadingSwitch;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *temperatureSlider;

@end

@implementation VTGroupLightSettingVC

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTLightEffectChooserVC class]]) {
        [self.navigationController popViewControllerAnimated: YES];
        if ([info[@"result"] isEqualToString: @"done"]) {
            
        }
    } else if ([vc isKindOfClass: [VTLightScheduleEditVC class]]) {
        [self.navigationController popViewControllerAnimated: YES];
        if ([info[@"result"] isEqualToString: @"done"]) {
            
        }
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    UITableViewCell* c = nil;
    UILabel* textLabel;
    if (row == 1) {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell2"];
        textLabel = [c viewWithTag: 1];
        self.fadingSwitch = [c viewWithTag: 2];
    } else {
        c = [tableView dequeueReusableCellWithIdentifier: @"cell1"];
        textLabel = c.textLabel;
    }
    
    textLabel.text = @[NSLocalizedString(@"Effects", @"Row Title"),
                       NSLocalizedString(@"Fading", @"Row Title"),
                       NSLocalizedString(@"Schedule", @"Row Title")][row];
    
    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        UIStoryboard* sb = [UIStoryboard storyboardWithName: @"EffectChooser" bundle: nil];
        VTLightEffectChooserVC* vc = [sb instantiateInitialViewController];
//        vc.accessory = self.accessory;
        vc.delegate = self;
        vc.selectedEffect = @{@"name": @"Default Effect 1"};
        [self.navigationController pushViewController: vc animated: YES];
    } else if (row == 1) {
        self.fadingSwitch.on = !self.fadingSwitch.isOn;
    } else if (row == 2) {
        [self performSegueWithIdentifier: @"showEditScheduleSegue" sender: self];
    }
}

#pragma mark - UI Actions

- (IBAction)onBrightnessChanged:(id)sender {
}

- (IBAction)onSaturationChanged:(id)sender {
}

- (IBAction)onTemperatureChanged:(id)sender {
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showEditScheduleSegue"]) {
        VTLightScheduleEditVC* vc = segue.destinationViewController;
//        vc.schedule = group[@"schedule"];
        vc.delegate = self;
    } else {
        [super prepareForSegue: segue sender: sender];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.group[@"name"];
}


@end
