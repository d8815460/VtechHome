//
//  VTLightEffectChooserVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTLightEffectChooserVC.h"
#import "VTEditLightEffectVC.h"

@interface VTLightEffectChooserVC () <UITableViewDataSource, UITableViewDelegate, DLPresenterVCDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (readonly) NSArray* defaultEffects;
@property (strong, nonatomic) NSArray* favoriteEffects;

@end

@implementation VTLightEffectChooserVC

-(NSArray *)defaultEffects
{
    return @[
             @{@"name": @"Default Effect 1"},
             @{@"name": @"Default Effect 2"},
             @{@"name": @"Default Effect 3"},
             @{@"name": @"Default Effect 4"}
             ];
}

-(NSArray*)favoriteEffects
{
    if (!_favoriteEffects) {
        _favoriteEffects = @[
                             @{@"name": @"Favorite Effect 1", @"hue": @[@0, @0, @255], @"brightness": @0.5, @"saturation": @0.3},
                             @{@"name": @"Favorite Effect 2", @"hue": @[@0, @0, @255], @"brightness": @0.6, @"saturation": @0.2},
                             @{@"name": @"Favorite Effect 3", @"hue": @[@0, @0, @255], @"brightness": @0.7, @"saturation": @0.1},
                             @{@"name": @"Favorite Effect 4", @"hue": @[@0, @0, @255], @"brightness": @0.8, @"saturation": @0.0}
                             ];
    }
    return _favoriteEffects;
}

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTEditLightEffectVC class]]) {
        VTEditLightEffectVC* casted = (id)vc;
        [self.navigationController popViewControllerAnimated: YES];
        if ([info[@"result"] isEqualToString: @"done"]) {
            NSDictionary* effect = info[@"effect"];
        }
    }
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return self.defaultEffects.count;
    if (section == 1) return self.favoriteEffects.count + 1;
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger sec = indexPath.section;
    
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    c.accessoryType = UITableViewCellAccessoryNone;
    c.showsReorderControl = tableView.isEditing;
    
    NSDictionary* effect = nil;
    if (sec == 1 && row == self.favoriteEffects.count) {
        c.textLabel.text = NSLocalizedString(@"Add...", @"Add Effect Row Title");
    } else {
        effect = @[self.defaultEffects, self.favoriteEffects][sec][row];
        c.textLabel.text = effect[@"name"];
    }
    
    if ([self.selectedEffect[@"name"] isEqualToString: effect[@"name"]]) {
        c.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return c;
}

#pragma mark - UITableViewDelegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @[NSLocalizedString(@"Effects", @"Section Header"),
             NSLocalizedString(@"Favorite Effects", @"Section Header")][section];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 1 && indexPath.row < self.favoriteEffects.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger sec = indexPath.section;
    if (tableView.isEditing) {
        if (sec == 1 && row < self.favoriteEffects.count) {
            [self performSegueWithIdentifier: @"showEditEffectSegue" sender: self];
        }
    } else {
        if (sec == 1 && row == self.favoriteEffects.count) {
            [self performSegueWithIdentifier: @"showAddEffectSegue" sender: self];
            return;
        } else {
            NSDictionary* effect = @[self.defaultEffects, self.favoriteEffects][sec][row];
            self.selectedEffect = effect;
            [self.tableView reloadData];
            [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"picked", @"effect": self.selectedEffect}];
        }
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row < self.favoriteEffects.count)
        return UITableViewCellEditingStyleDelete;
    return UITableViewCellEditingStyleNone;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if (!tableView.isEditing) return;
    
    NSMutableArray* tmp = [self.favoriteEffects mutableCopy];
    id obj = tmp[sourceIndexPath.row];
    [tmp removeObjectAtIndex: sourceIndexPath.row];
    [tmp insertObject: obj atIndex: destinationIndexPath.row];
    self.favoriteEffects = tmp;
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView reloadData];
    }
}

#pragma mark - UI Actions

-(IBAction)doToggleEditing:(UIBarButtonItem*)barButtonItem;
{
    [self.tableView setEditing: !self.tableView.isEditing animated: YES];
    if (self.tableView.isEditing) {
        barButtonItem.title = NSLocalizedString(@"Done", @"Button");
    } else {
        barButtonItem.title = NSLocalizedString(@"Edit", @"Button");
    }
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showAddEffectSegue"]) {
        VTEditLightEffectVC* vc = segue.destinationViewController;
        vc.deleage = self;
    } else if ([segue.identifier isEqualToString: @"showEditEffectSegue"]){
        VTEditLightEffectVC* vc = segue.destinationViewController;
        vc.deleage = self;
        vc.effect = self.favoriteEffects[self.tableView.indexPathForSelectedRow.row];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.accessory[@"name"];
}


@end
