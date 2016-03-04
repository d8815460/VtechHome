//
//  VTGroupChooserVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTGroupChooserVC.h"

@interface VTGroupChooserVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* groups;

@end

@implementation VTGroupChooserVC

-(NSArray *)groups
{
    if (!_groups) {
        _groups = @[@{@"name": @"Group 1"},
                    @{@"name": @"Group 2"}];
    }
    return _groups;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.groups.count + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    c.accessoryType = UITableViewCellAccessoryNone;
    
    if (row == self.groups.count) {
        c.textLabel.text = NSLocalizedString(@"Add New Group", @"Row Title");
    } else {
        NSDictionary* group = self.groups[row];
        c.textLabel.text = group[@"name"];
        if ([group[@"name"] isEqualToString: self.selectedGroup[@"name"]]) {
            c.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if (row == self.groups.count) {
        UIAlertView* av = [UIAlertView bk_alertViewWithTitle: NSLocalizedString(@"Name New Group", @"Dialog Title")];
        av.alertViewStyle = UIAlertViewStylePlainTextInput;
        [av bk_addButtonWithTitle: NSLocalizedString(@"Cancel", @"Button") handler: nil];
        [av bk_addButtonWithTitle: NSLocalizedString(@"Save", @"Button") handler:^{
            NSString* name = [av textFieldAtIndex: 0].text;
            if (!name.length) return;
            NSDictionary* group = @{@"name": [av textFieldAtIndex: 0].text};
            NSMutableArray* tmp = [self.groups mutableCopy];
            [tmp addObject: group];
            self.groups = tmp;
            self.selectedGroup = group;
            [tableView reloadData];
        }];
        [av show];
    } else {
        self.selectedGroup = self.groups[row];
        [tableView reloadData];
    }
}

#pragma mark - UI Actions

-(IBAction)doDone
{
    if (self.selectedGroup) {
        [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"done", @"group": self.selectedGroup}];
    } else {
        [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"cancel"}];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
