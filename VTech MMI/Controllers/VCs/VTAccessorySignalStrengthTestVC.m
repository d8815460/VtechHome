//
//  VTAccessorySignalStrengthTestVC.m
//  VTech MMI
//
//  Created by David Lin on 12/9/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTAccessorySignalStrengthTestVC.h"

@interface VTAccessorySignalStrengthTestVC ()

@property (weak, nonatomic) IBOutlet UILabel* promptLabel;
@property (weak, nonatomic) IBOutlet UIProgressView* progressView;

@property (strong, nonatomic) NSTimer* progressTimer;

@end

@implementation VTAccessorySignalStrengthTestVC

#pragma mark - Private Helpers

-(void)doSignalStrengthTest
{
    self.progressView.progress = 0;
    self.progressTimer = [NSTimer bk_scheduledTimerWithTimeInterval: 0.05 block:^(NSTimer *timer) {
        self.progressView.progress += 0.02;
        if (self.progressView.progress < 1) return;
        [timer invalidate];
        
        NSInteger result = arc4random() % 3;
        UIAlertView* av = nil;
        if (result == 0) {
            av = [UIAlertView bk_alertViewWithTitle: NSLocalizedString(@"Result", @"Dialog Title") message: NSLocalizedString(@"No signal. Please try agin", @"Dialog message")];
            [av bk_addButtonWithTitle: NSLocalizedString(@"Cancel", @"Button") handler: nil];
            [av bk_addButtonWithTitle: NSLocalizedString(@"OK", @"Button") handler: ^{
                [self doSignalStrengthTest];
            }];
        } else if (result == 1) {
            NSString* fmt = NSLocalizedString(@"Good signal. Good location for '%@'", @"Dialog Message");
            av = [UIAlertView bk_alertViewWithTitle: NSLocalizedString(@"Result", @"Dialog Title") message: FORMAT(fmt, self.accessory[@"name"])];
            [av bk_addButtonWithTitle: @"OK" handler: nil];
        } else if (result == 2) {
            NSString* fmt = NSLocalizedString(@"Weak signal. Please move '%@' closer to your hub.", @"Dialog Message");
            av = [UIAlertView bk_alertViewWithTitle: NSLocalizedString(@"Result", @"Dialog Title") message: FORMAT(fmt, self.accessory[@"name"])];
            [av bk_addButtonWithTitle: NSLocalizedString(@"Cancel", @"Button") handler: nil];
            [av bk_addButtonWithTitle: NSLocalizedString(@"Next", @"Button") handler:^{
                [self doSignalStrengthTest];
            }];
        }
        [av show];
    } repeats: YES];

}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doSignalStrengthTest];
}

@end
