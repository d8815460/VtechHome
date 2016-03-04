//
//  VTSwitchAssignLIghtSelectVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTSwitchAssignLightSelectVC.h"

@interface VTSwitchAssignLightSelectVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* tableView;
@property (readonly) NSArray* lightAccessories;

@end

@implementation VTSwitchAssignLightSelectVC

-(NSArray *)lightAccessories
{
    NSMutableArray* tmp = [NSMutableArray new];
    for (NSInteger j=0; j<4; j++) {
        for (NSInteger i=0; i<j+1; i++) {
            [tmp addObject: @{@"type": @"light",
                              @"udid": @"xxx",
                              @"firmware": @"1.2",
                              @"name": FORMAT(@"Light %zd-%zd", j+1, i),
                              @"aid": @1,
                              @"location": @"Bedroom"}];
        }
    }
    return tmp;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lightAccessories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSDictionary* light = self.lightAccessories[row];
    
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    c.imageView.image = [UIImage imageNamed: @"ic_light"];
    c.textLabel.text = light[@"name"];
    
    NSArray* selectedLightsNames = [self.selectedLights bk_map: ^id(NSDictionary* selectedLight) {
        return selectedLight[@"name"];
    }];
    
    if ([selectedLightsNames containsObject: light[@"name"]]) {
        c.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        c.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return c;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSDictionary* light = self.lightAccessories[row];
    NSArray* selectedLightsNames = [self.selectedLights bk_map: ^id(NSDictionary* selectedLight) {
        return selectedLight[@"name"];
    }];
    
    NSMutableArray* tmp = [self.selectedLights mutableCopy];
    if ([selectedLightsNames containsObject: light[@"name"]]) {
        NSInteger index = [selectedLightsNames indexOfObject: light[@"name"]];
        [tmp removeObjectAtIndex: index];
    } else {
        [tmp addObject: light];
    }
    
    self.selectedLights = tmp;
    [self.tableView reloadData];
}

#pragma mark - UI Actions

- (IBAction)doSave:(id)sender {
    [self showProgress: NSLocalizedString(@"Saving...", @"Hud Progress")];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideProgress];
        [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"done", @"selectedLights": self.selectedLights}];
    });
}

- (IBAction)doCancel:(id)sender {
    [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"cancel"}];
}

- (IBAction)doDeselectAll:(id)sender {
    self.selectedLights = @[];
    [self.tableView reloadData];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
