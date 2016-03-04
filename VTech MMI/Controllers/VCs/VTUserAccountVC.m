//
//  VTUserAccountVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTUserAccountVC.h"

@interface VTUserAccountVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation VTUserAccountVC

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    UITableViewCell* c =
    [tableView dequeueReusableCellWithIdentifier: @[@"rightDetailCell",
                                                    @"rightCaretCell",
                                                    @"logoutCell"][section]];
    [c prepareForReuse];
    
    if (section == 0) {
        c.textLabel.text = NSLocalizedString(@"User", @"Cell Title");
        c.detailTextLabel.text = self.user[@"email"];
    } else if (section == 1) {
        c.textLabel.text = NSLocalizedString(@"Change Password", @"Cell Title");
    }
    
    return c;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"Account Information", @"Table Section Title");
    }
    return nil;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if (section == 1) {
        [self performSegueWithIdentifier: @"showChangePasswordSegue" sender: nil];
    } else if (section == 2) {
        UIStoryboard* sb = [UIStoryboard storyboardWithName: @"Login" bundle: nil];
        UIViewController* vc = [sb instantiateInitialViewController];
        [UIView transitionWithView: self.view.window duration: 0.5 options: UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.view.window.rootViewController = vc;
        } completion:nil];

    }
}

#pragma mark - UI Actions

-(IBAction)doClose
{
    [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"done"}];
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showChangePasswordSegue"]) {
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}


@end
