//
//  VTAccessorySignalStrengthTestHintVC.m
//  VTech MMI
//
//  Created by David Lin on 12/9/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTAccessorySignalStrengthTestHintVC.h"
#import "VTAccessorySignalStrengthTestVC.h"

@interface VTAccessorySignalStrengthTestHintVC ()

@property (weak, nonatomic) IBOutlet UILabel* hintLabel;
@property (weak, nonatomic) IBOutlet UIImageView* hintImageView;

@end

@implementation VTAccessorySignalStrengthTestHintVC

#pragma mark - UI Actions

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showTestSignalStrengthSegue"]) {
        VTAccessorySignalStrengthTestVC* vc = segue.destinationViewController;
        vc.accessory = self.accessory;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString* fmt = NSLocalizedString(@"Please trigger '%@' now. Then tap Next", @"Test signal strength hint label");
    self.hintLabel.text = FORMAT(fmt, self.accessory[@"name"]);
}


@end
