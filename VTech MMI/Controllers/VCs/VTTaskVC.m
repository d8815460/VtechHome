//
//  VTTaskVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTTaskVC.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

@interface VTTaskVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end

@implementation VTTaskVC

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UITableViewDelegate

#pragma mark - UI Actions

-(IBAction)doShowMenu
{
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight)
        [self.slidingViewController resetTopViewAnimated: YES];
    else {
        [self.slidingViewController anchorTopViewToRightAnimated: YES];
    }
}

-(IBAction)doAddTask
{
    
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}

@end
