//
//  VTViewChooserPopover.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTViewChooserPopover.h"

@interface VTViewChooserPopover () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@property (readonly) NSArray* accessoryTypes;

@end

@implementation VTViewChooserPopover

-(NSArray *)accessoryTypes
{
    return @[@"light", @"contact", @"motion", @"garage", @"switch"];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.selectedMode == 1) {
        return self.accessoryTypes.count + 3;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    c.accessoryType = UITableViewCellAccessoryNone;
    
    NSMutableArray* tmp = [NSMutableArray new];
    [tmp addObject: NSLocalizedString(@"All", @"View Type")];
    [tmp addObject: NSLocalizedString(@"Device Type", @"View Type")];
    if (self.selectedMode == 1) {
        for (NSString* type in self.accessoryTypes) {
            [tmp addObject: type];
        }
        NSInteger idx = row - 2;
        if (idx >= 0 &&
            idx < self.accessoryTypes.count &&
            [self.selectedAccessoryType isEqualToString: self.accessoryTypes[idx]]) {
            c.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    } else {
        if (self.selectedMode == row) {
            c.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    [tmp addObject:  NSLocalizedString(@"Customized", @"View Type")];
    c.textLabel.text = tmp[row];
    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 1) {
        if (self.selectedMode != 1)
            self.selectedAccessoryType = @"light";
        self.selectedMode = 1;
        [self.tableView reloadData];
    } else {
        if (row == 0) {
            self.selectedMode = 0;
            [self.delegate presenteeVC: self
                   didCompleteWithInfo: @{@"result": @"done",
                                          @"selectedMode": @(self.selectedMode)}];
            [self dismissViewControllerAnimated: YES completion: nil];
            return;
        }
        row -= 2;
        if (self.selectedMode == 1) {
            if (row < self.accessoryTypes.count) {
                self.selectedMode = 1;
                self.selectedAccessoryType = self.accessoryTypes[row];
                [self.delegate presenteeVC: self
                       didCompleteWithInfo: @{@"result": @"done",
                                              @"selectedMode": @(self.selectedMode),
                                              @"selectedAccessoryType": self.selectedAccessoryType}];
                [self dismissViewControllerAnimated: YES completion: nil];
                return;
            }
            row -= self.accessoryTypes.count;
        }
        if (row == 0) {
            self.selectedMode = 2;
            [self.delegate presenteeVC: self
                   didCompleteWithInfo: @{@"result": @"done",
                                          @"selectedMode": @(self.selectedMode)}];
            [self dismissViewControllerAnimated: YES completion: nil];
        }
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"cell"];
}


@end
