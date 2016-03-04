//
//  VTAddDeviceFailedVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTAddDeviceFailedVC.h"

@interface VTAddDeviceFailedVC ()

@end

@implementation VTAddDeviceFailedVC

#pragma mark - UI Actions

-(IBAction)doGoBack
{
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
