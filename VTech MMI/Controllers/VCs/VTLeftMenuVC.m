//
//  VTLeftMenuVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTLeftMenuVC.h"
#import "VTMenuCell.h"
#import "VTWebBrowserVC.h"
#import "Kalay.h"
#import "VTAppInfoVC.h"
#import "VTUserAccountVC.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

@interface VTLeftMenuVC () <UITableViewDataSource, UITableViewDelegate, DLPresenterVCDelegate>

@property (strong, nonatomic) NSArray* gateways;
@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end

@implementation VTLeftMenuVC

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTWebBrowserVC class]]) {
        [self dismissViewControllerAnimated: YES completion: nil];
    } else if ([vc isKindOfClass: [VTAppInfoVC class]]) {
        [self dismissViewControllerAnimated: YES completion: nil];
    } else if ([vc isKindOfClass: [VTUserAccountVC class]]) {
        [self dismissViewControllerAnimated: YES completion: nil];
    }
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gateways.count + 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VTMenuCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    [c prepareForReuse];

    NSInteger row = indexPath.row;
    
    if (row < self.gateways.count) {
        NSDictionary* gateway = self.gateways[row];
        c.menuTitleLabel.text = gateway[@"name"];
        c.menuIconImageView.image = nil;
        return c; // premature return
    }
    row -= self.gateways.count;
    c.menuTitleLabel.text = @[NSLocalizedString(@"IP Cameras", @"Menu Entry"),
                              NSLocalizedString(@"Account", @"Menu Entry"),
                              NSLocalizedString(@"Help", @"Menu Entry"),
                              NSLocalizedString(@"About", @"Menu Entry")][row];
    //        c.menuIconImageView.image = [UIImage imageNamed: @[][row]];
    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row < self.gateways.count) {
        return; // premature return
    }
    
    row -= self.gateways.count;
    
    // GOTCHA (YC): the following dispatch_async is to fix IOS bug, IOS
    // seem to call didSelectRowAtIndexPath in background thread, so have
    // to dispatch to main queue to perform UI stuff.
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (row == 0) {
            
        } else if (row == 1) {
            UIStoryboard* sb = [UIStoryboard storyboardWithName: @"Account" bundle:nil];
            UINavigationController* nvc = [sb instantiateInitialViewController];
            VTUserAccountVC* vc = nvc.childViewControllers[0];
            vc.delegate = self;
            vc.user = @{@"email": @"davidlin1980@gmail.com"};
            [self presentViewController: nvc animated: YES completion: nil];
        } else if (row == 2) {
            VTWebBrowserVC* vc = [[VTWebBrowserVC alloc] init];
            vc.delegate = self;
            vc.url = [NSURL URLWithString: @"https://www.google.com"];
            vc.title = NSLocalizedString(@"Help", @"View Controller Title");
            UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController: vc];
            [self presentViewController: nvc animated: YES completion: nil];
        } else if (row == 3) {
            [self performSegueWithIdentifier: @"showAppInfoSegue" sender: nil];
        }
    });
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showAppInfoSegue"]) {
        UINavigationController* nvc = segue.destinationViewController;
        VTAppInfoVC* vc = nvc.childViewControllers[0];
        vc.delegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 55;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [KALAY.SmartHome listGatewaysOnCompletion:^(NSError *error, NSDictionary *result) {
        self.gateways = result[@"gateways"];
        [self.tableView reloadData];
    }];
}


@end
