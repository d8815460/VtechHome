//
//  VTLocationChooserVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTLocationChooserVC.h"

@interface VTLocationChooserVC () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray* locations;
@property (weak, nonatomic) IBOutlet UILabel* headerLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* deleteAllBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* deleteBarButtonItem;
@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (weak, nonatomic) IBOutlet UIView* normalModeCommandPanel;

@property (readonly) NSArray* defaultLocations;

@end

@implementation VTLocationChooserVC

-(NSArray *)defaultLocations
{
    return @[NSLocalizedString(@"Bedroom", @"Default Location Name"),
             NSLocalizedString(@"Bathroom", @"Default Location Name"),
             NSLocalizedString(@"Dining Room", @"Default Location Name"),
             NSLocalizedString(@"Living Room", @"Default Location Name"),
             NSLocalizedString(@"Garage", @"Default Location Name"),
             NSLocalizedString(@"Kitchen", @"Default Location Name")];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    [c prepareForReuse];
    if (tableView.isEditing) {
        c.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        c.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    c.accessoryType = UITableViewCellAccessoryNone;
    
    c.textLabel.text = self.locations[row];
    if ([self.locations[row] isEqualToString: self.selectedLocationName])
        c.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return c;
}

#pragma mark - UITableViewDelegate

-(BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath
{
    return false;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.locations exchangeObjectAtIndex: sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (self.tableView.isEditing) {
        
    } else {
        self.selectedLocationName = self.locations[row];
        [self.tableView reloadData];
        [self.delegate presenteeVC: self didCompleteWithInfo: @{@"updateLocation": self.selectedLocationName}];
    }
}

#pragma mark - UI Actions

-(IBAction)doToggleEdit:(UIBarButtonItem*)bbi
{
    self.tableView.editing = !self.tableView.isEditing;
    if (self.tableView.isEditing) {
        [bbi setTitle: NSLocalizedString(@"Done", @"Bar Button Item")];
    } else {
        [bbi setTitle: NSLocalizedString(@"Edit", @"Bar Button Item")];
    }
    self.normalModeCommandPanel.hidden = self.tableView.isEditing;
    [self.tableView reloadData];
}

-(IBAction)doDeleteAllCustomLocations
{
    UIAlertView* av = [UIAlertView bk_alertViewWithTitle: NSLocalizedString(@"Warning", @"Dialog Title") message: NSLocalizedString(@"Do you want to delete all locations?", @"Dialog Message")];
    [av bk_addButtonWithTitle: NSLocalizedString(@"No", @"Button") handler: nil];
    [av bk_addButtonWithTitle: NSLocalizedString(@"Yes", @"Button") handler:^{

        self.locations = [self.locations bk_reduce: [NSMutableArray new] withBlock: ^id(NSMutableArray* arr, NSString* name) {
            if ([self.defaultLocations containsObject: name]) {
                [arr addObject: name];
            }
            return arr;
        }];
        [self.tableView reloadData];
    }];
    [av show];
}

-(IBAction)doDeleteSelectedCutomLocations
{
    NSMutableArray* tmp = [NSMutableArray new];
    for (NSInteger i=0; i<self.locations.count; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow: i inSection: 0];
        if (![self.tableView.indexPathsForSelectedRows containsObject: indexPath]) {
            [tmp addObject: self.locations[i]];
        }
    }
    self.locations = tmp;
    [self.tableView deleteRowsAtIndexPaths: self.tableView.indexPathsForSelectedRows withRowAnimation: UITableViewRowAnimationAutomatic];
}

-(IBAction)doAddCustomLocation
{
    UIAlertView* av = [UIAlertView
                       bk_alertViewWithTitle: NSLocalizedString(@"Location Name", @"Dialog Title")
                       message: NSLocalizedString(@"Please enter new location name", @"Dialog Mesage")];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    [av bk_addButtonWithTitle: NSLocalizedString(@"Cancel", @"Button") handler: nil];
    [av bk_addButtonWithTitle: NSLocalizedString(@"Save", @"Button") handler: ^{
        NSString* name = [av textFieldAtIndex: 0].text;
        if (!name.length) return;
        [self.locations addObject: name];
        
        NSIndexPath* indexPath = [NSIndexPath
                                  indexPathForRow: self.locations.count-1
                                  inSection:0];
        [self.tableView
         insertRowsAtIndexPaths: @[indexPath]
         withRowAnimation: UITableViewRowAnimationAutomatic];
    }];
    [av show];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    NSString* deviceType = @[NSLocalizedString(@"Garage Sensor", @"Sensor Type"),
                             NSLocalizedString(@"Motion Sensor", @"Sensor Type"),
                             NSLocalizedString(@"Contact Sensor", @"Sensor Type"),
                             NSLocalizedString(@"Wall Switch", @"Sensor Type"),
                             NSLocalizedString(@"LED Lights", @"Sensor Type")][self.sensorType];
    
    self.headerLabel.text = FORMAT(NSLocalizedString(@"Assign '%@' to a location", @"Section Header"), deviceType);
    self.locations = [self.defaultLocations mutableCopy];
}

@end
