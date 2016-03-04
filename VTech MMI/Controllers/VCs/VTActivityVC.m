//
//  VTActivityVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTActivityVC.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

@interface VTActivityVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (strong, nonatomic) NSArray* activities;

@end

@implementation VTActivityVC

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.activities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    NSDictionary* activity = self.activities[row];
    c.textLabel.text = activity[@"timestamp"];
    c.detailTextLabel.text = activity[@"message"];
    return c;
}

#pragma mark - UITableViewDelegate

#pragma mark - Private Helpers

-(void)asyncSeachActivitiesWithinTimeInterval:(NSTimeInterval)interval
{
    NSMutableArray* tmp = [NSMutableArray new];
    for (NSInteger i=0; i< interval / (1*60*60); i++) {
        [tmp addObject: @{@"timestamp": @"8:30",
                          @"message": FORMAT(@"Some log %zd", i),
                          @"icon": @"some_icon",
                          @"aid": @1}];
    }
    self.activities = tmp;
    [self.tableView reloadData];
}

#pragma mark - UI Actions

-(IBAction)doShowMenu
{
    if (self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight)
        [self.slidingViewController resetTopViewAnimated: YES];
    else {
        [self.slidingViewController anchorTopViewToRightAnimated: YES];
    }
}

-(IBAction)doShowSearchPicker
{
    UIActionSheet* as = [UIActionSheet bk_actionSheetWithTitle: NSLocalizedString(@"Search", @"Action Sheet Title")];
    
    [as bk_addButtonWithTitle: NSLocalizedString(@"Within an hour", @"Search Option") handler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self asyncSeachActivitiesWithinTimeInterval: 1*60*60];
        });
    }];
    [as bk_addButtonWithTitle: NSLocalizedString(@"Within half a day", @"Search Option") handler:^{
        [self asyncSeachActivitiesWithinTimeInterval: 12*60*60];
    }];
    [as bk_addButtonWithTitle: NSLocalizedString(@"Within a day", @"Search Option") handler:^{
        [self asyncSeachActivitiesWithinTimeInterval: 1*24*60*60];
    }];
    [as bk_addButtonWithTitle: NSLocalizedString(@"Within a week", @"Search Option") handler:^{
        [self asyncSeachActivitiesWithinTimeInterval: 7*24*60*60];
    }];
    [as bk_addButtonWithTitle: NSLocalizedString(@"Custom", @"Search Option") handler:^{
    }];
    [as bk_addButtonWithTitle: NSLocalizedString(@"Cancel", @"Action Sheet Button") handler: nil];

    [as showInView: self.view];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}

@end
