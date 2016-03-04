//
//  VTEditLightEffectVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTEditLightEffectVC.h"

@interface VTEditLightEffectVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;

@end

@implementation VTEditLightEffectVC

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UI Actions

- (IBAction)doCancel:(id)sender {
    [self.deleage presenteeVC: self
          didCompleteWithInfo: @{@"result": @"cancel"}];
}

- (IBAction)doSave:(id)sender {
    [self.deleage presenteeVC: self
          didCompleteWithInfo:@{@"result": @"done",
                                @"effect": @{@"name": self.nameTextField.text,
                                             @"hue": self.effect[@"hue"],
                                             @"brightness": @(self.brightnessSlider.value),
                                             @"saturation": @(self.saturationSlider.value)
                                             }
                                }];
}

- (IBAction)onBrightnessValueChanged:(id)sender {
    NSString* fmt = NSLocalizedString(@"Brightness (%zd)%%", @"Brightness label");
    self.brightnessLabel.text = FORMAT(fmt, (NSInteger)(self.brightnessSlider.value * 100));
}

- (IBAction)onSaturationValueChanged:(id)sender {
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.brightnessSlider.value = [self.effect[@"brightness"] floatValue];
    self.saturationSlider.value = [self.effect[@"saturation"] floatValue];
    self.nameTextField.text = self.effect[@"name"];
    [self onBrightnessValueChanged: nil];
}

@end
