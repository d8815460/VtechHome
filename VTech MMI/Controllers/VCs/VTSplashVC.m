//
//  VTSplashVC.m
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTSplashVC.h"
#import "DLPresenterVCDelegate.h"
#import "VTLoginVC.h"
#import "VTCreateAccountVC.h"
#import "VTHueWheelView.h"
#import <Masonry/Masonry.h>

@interface VTSplashVC () <DLPresenterVCDelegate>

@property (strong, nonatomic) IBOutlet VTHueWheelView* hueWheelView;

@end

@implementation VTSplashVC

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTLoginVC class]]) {
        if ([info[@"result"] isEqualToString: @"showCreateAccountSegue"]) {
            [self.navigationController popToRootViewControllerAnimated: NO];
            [self performSegueWithIdentifier: @"showCreateAccountSegue" sender: nil];
        }
    } else if ([vc isKindOfClass: [VTCreateAccountVC class]]) {
        if ([info[@"result"] isEqualToString: @"showLoginSegue"]) {
            [self.navigationController popToRootViewControllerAnimated: NO];
            [self performSegueWithIdentifier: @"showLoginSegue" sender: nil];
        }
    }
}

#pragma mark - UI Action

-(void)onHueChanged:(VTHueWheelView*)sender
{
    NSLog(@"Hue is %f", sender.hue);

}

#pragma mark - Life Cycle

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showLoginSegue"]) {
        VTLoginVC* vc = segue.destinationViewController;
        vc.delegate = self;
    } else if ([segue.identifier isEqualToString: @"showCreateAccountSegue"]) {
        VTCreateAccountVC* vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib* nib = [UINib nibWithNibName: @"VTHueWheelView" bundle: nil];
    self.hueWheelView =  [nib instantiateWithOwner: nil options: nil][0];
    [self.view addSubview: self.hueWheelView];
    
    [self.hueWheelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@250);
        make.height.equalTo(@250);
        make.centerX.equalTo(self.view);
    }];
    [self.hueWheelView startTrackingPanGesture];
    [self.hueWheelView addTarget: self action: @selector(onHueChanged:)];
}


@end
