//
//  VTLightDetailVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTLightDetailVC.h"
#import "VTLightEffectChooserVC.h"

@interface VTLightDetailVC () <UITableViewDataSource, UITableViewDelegate, DLPresenterVCDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *lightTypeSegmentControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colorControlPanelHeightContraint; // normal 362
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *whiteControlPanelHeightContraint; // normal 153
@property (weak, nonatomic) IBOutlet UILabel *colorBrightnessLabel;
@property (weak, nonatomic) IBOutlet UISlider *colorBrightnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *colorSaturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *whiteSaturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *whiteTemperatureSlider;
@property (nonatomic) NSInteger selectedControlPanelIndex;

@end

@implementation VTLightDetailVC

-(void)setSelectedControlPanelIndex:(NSInteger)selectedControlPanelIndex
{
    _selectedControlPanelIndex = selectedControlPanelIndex;
    if (_selectedControlPanelIndex == 0) {
        self.colorControlPanelHeightContraint.constant = 362;
        self.whiteControlPanelHeightContraint.constant = 0;
        self.headerView.frame = CGRectMake(0, 0, 320, 362);
    } else if (selectedControlPanelIndex == 1) {
        self.colorControlPanelHeightContraint.constant = 0;
        self.whiteControlPanelHeightContraint.constant = 153;
        self.headerView.frame = CGRectMake(0, 0, 320, 153);
    }
    self.tableView.tableHeaderView = nil;
    self.tableView.tableHeaderView = self.headerView;
//    [self.headerView layoutSubviews];
}
#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTLightEffectChooserVC class]]) {
        [self.navigationController popViewControllerAnimated: YES];
        if ([info[@"result"] isEqualToString: @"done"]) {
            
        }
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    [c prepareForReuse];
    c.selectionStyle = UITableViewCellSelectionStyleNone;
    c.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    c.textLabel.text = @[NSLocalizedString(@"Effects", @"Accessory Detail Row"),
                         NSLocalizedString(@"Tasks", @"Accessory Detail Row"),
                         NSLocalizedString(@"Settings", @"Accessory Detail Row"),
                         NSLocalizedString(@"About", @"Accessory Detail Row")][indexPath.row];
    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        UIStoryboard* sb = [UIStoryboard storyboardWithName: @"EffectChooser" bundle: nil];
        VTLightEffectChooserVC* vc = [sb instantiateInitialViewController];
        vc.accessory = self.accessory;
        vc.delegate = self;
        vc.selectedEffect = @{@"name": @"Default Effect 1"};
        [self.navigationController pushViewController: vc animated: YES];
    } else if (row == 1) {
    } else if (row == 2) {
        [self performSegueWithIdentifier: @"showBasicAccessorySettingsSegue" sender: self];
    } else if (row == 3) {
        [self performSegueWithIdentifier: @"showAboutSegue" sender: self];
    }
}

- (IBAction)doChangeSelectedControlPanel:(id)sender {
    self.selectedControlPanelIndex = self.lightTypeSegmentControl.selectedSegmentIndex;
}

- (IBAction)doChangeColorBrightness:(id)sender {
    NSString* fmt = NSLocalizedString(@"Brightness (%zd)%%", @"Brightness label");
    self.colorBrightnessLabel.text = FORMAT(fmt, (NSInteger)(self.colorBrightnessSlider.value * 100));}

- (IBAction)doChangeColorSaturation:(id)sender {
}

- (IBAction)doChangeWhiteSaturation:(id)sender {
}

- (IBAction)doChangeWhiteTemperature:(id)sender {
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lightTypeSegmentControl.selectedSegmentIndex = 0;
    self.selectedControlPanelIndex = 0;
    [self doChangeColorBrightness: self.colorBrightnessSlider];
}


@end
