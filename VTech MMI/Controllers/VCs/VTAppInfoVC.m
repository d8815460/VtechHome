//
//  VTAppInfoVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTAppInfoVC.h"
#import "Kalay.h"

@interface VTAppInfoVC ()

@property (weak, nonatomic) IBOutlet UILabel* appVersionLabel;
@property (weak, nonatomic) IBOutlet UILabel* IOTCAPIVersionLabel;
@property (weak, nonatomic) IBOutlet UILabel* AVAPIVerionLabel;

@end

@implementation VTAppInfoVC

#pragma mark - UI Actions

-(IBAction)doClose
{
    [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"done"}];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString* appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    self.appVersionLabel.text = FORMAT(NSLocalizedString(@"Version %@", @"Version Label"), appVersion);
    self.AVAPIVerionLabel.text = FORMAT(NSLocalizedString(@"IOTCAPIs %@", @"Version Label"), KALAY.AVAPIVersion);
    self.IOTCAPIVersionLabel.text = FORMAT(NSLocalizedString(@"AVAPIs %@", @"Version Label"), KALAY.IOTCAPIVersion);
}

@end
