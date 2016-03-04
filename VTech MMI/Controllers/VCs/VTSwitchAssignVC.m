//
//  VTSwitchAssignVC.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTSwitchAssignVC.h"
#import "VTSwitchAssignLightSelectVC.h"

@interface VTSwitchAssignVC () <UITableViewDataSource, UITableViewDelegate, DLPresenterVCDelegate>

@property (weak, nonatomic) IBOutlet UILabel *selectedSwitchHeaderLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *switchButton1;
@property (weak, nonatomic) IBOutlet UIButton *switchButton2;
@property (weak, nonatomic) IBOutlet UIButton *switchButton3;
@property (weak, nonatomic) IBOutlet UIButton *switchButton4;
@property (strong, nonatomic) NSArray* switchButtons;

@property (nonatomic) NSInteger selectedSwitchIndex;
@property (readonly) NSArray* lightsForSelectedSwitch;

@end

@implementation VTSwitchAssignVC

-(NSArray *)lightsForSelectedSwitch
{
    NSMutableArray* tmp = [NSMutableArray new];
    for (NSInteger i=0; i<self.selectedSwitchIndex+1; i++) {
        [tmp addObject: @{@"type": @"light",
                          @"udid": @"xxx",
                          @"firmware": @"1.2",
                          @"name": FORMAT(@"Light %zd-%zd", self.selectedSwitchIndex+1, i),
                          @"aid": @1,
                          @"location": @"Bedroom"}];
    }
    return tmp;
}

-(void)setSelectedSwitchIndex:(NSInteger)selectedSwitchIndex
{
    _selectedSwitchIndex = selectedSwitchIndex;
    self.selectedSwitchHeaderLabel.text = FORMAT(NSLocalizedString(@"Switch %zd", @"Switch Number"), selectedSwitchIndex + 1);
    [self.tableView reloadData];
}

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTSwitchAssignLightSelectVC class]]) {
        VTSwitchAssignLightSelectVC* casted = (id)vc;
        [self.navigationController popViewControllerAnimated: YES];
        if ([info[@"result"] isEqualToString: @"done"]) {
            
        }
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lightsForSelectedSwitch.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSDictionary* light = self.lightsForSelectedSwitch[row];
    
    UITableViewCell* c = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    c.imageView.image = [UIImage imageNamed: @"ic_light"];
    c.textLabel.text = light[@"name"];
    return c;
}

#pragma mark - UITableViewDelegate

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tableView reloadData];
    }
}

#pragma mark - UI Actions

- (IBAction)doChangeSwitchDetail:(UIButton *)sender
{
    self.selectedSwitchIndex = sender.tag-1;
}

- (IBAction)doTurnSwitchOn:(id)sender
{
    UIButton* btn = self.switchButtons[self.selectedSwitchIndex];
    btn.backgroundColor = [UIColor blueColor];
}

- (IBAction)doTurnSwitchOff:(id)sender
{
    UIButton* btn = self.switchButtons[self.selectedSwitchIndex];
    btn.backgroundColor = [UIColor darkGrayColor];
}

- (IBAction)doEditSwitchDetail:(id)sender {
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showEditSwitchSegue"]) {
        VTSwitchAssignLightSelectVC* vc = segue.destinationViewController;
        vc.selectedLights = self.lightsForSelectedSwitch;
        vc.delegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.accessory[@"name"];
    self.switchButtons = @[self.switchButton1, self.switchButton2, self.switchButton3, self.switchButton4];
    for (UIButton* btn in self.switchButtons) {
        btn.backgroundColor = [UIColor darkGrayColor];
    }
    self.selectedSwitchIndex = 0;
}

@end
