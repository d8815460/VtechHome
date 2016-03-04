//
//  VTDashboardVC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTDashboardVC.h"
#import "VTLocationChooserVC.h"
#import "VTDashboardCell.h"
#import "VTDashboardSectionHeaderView.h"
#import "VTAccessoryDetailVC.h"
#import "VTGroupDetailVC.h"
#import "VTViewChooserPopover.h"
#import <ECSlidingViewController/UIViewController+ECSlidingViewController.h>

@interface VTDashboardVC () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DLPresenterVCDelegate, UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) NSArray* accessories;
@property (weak, nonatomic) IBOutlet UICollectionView* collectionView;

@property (strong, nonatomic) NSArray* accessoryLocations;

@property (nonatomic) NSInteger selectedViewMode;
@property (strong, nonatomic) NSString* filteringAccessoryType;

@property (readonly) NSArray* filteredAccessories;

@end

@implementation VTDashboardVC

-(NSArray *)filteredAccessories
{
    if (self.selectedViewMode == 1) {
        NSPredicate* pred = [NSPredicate predicateWithFormat: @"type = %@", self.filteringAccessoryType];
        return [self.accessories filteredArrayUsingPredicate: pred];
    }
    return self.accessories;
}

-(NSArray *)accessoryLocations
{
    if (!_accessoryLocations) {
        NSArray* types = [self.filteredAccessories bk_map:^id(NSDictionary* a) { return a[@"location"]; }];
        NSSet* uniqueTypes = [NSSet setWithArray: types];
        NSSortDescriptor* sort = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
        _accessoryLocations =[uniqueTypes.allObjects sortedArrayUsingDescriptors:@[sort]];
    }
    return _accessoryLocations;
}

-(NSArray*)accessoriesInLocation:(id)loc
{
    NSPredicate* pred = [NSPredicate predicateWithFormat: @"location = %@", loc];
    return [self.filteredAccessories filteredArrayUsingPredicate: pred];
}

#pragma mark - UIPopoverPresentationControllerDelegate

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

#pragma mark - DLPresenterVCDelegate

-(void)presenteeVC:(UIViewController *)vc didCompleteWithInfo:(NSDictionary *)info
{
    if ([vc isKindOfClass: [VTViewChooserPopover class]]) {
        self.selectedViewMode = [info[@"selectedMode"] integerValue];
        if (self.selectedViewMode == 1) {
            self.filteringAccessoryType = info[@"selectedAccessoryType"];
        }
        self.accessoryLocations = nil;
        [self.collectionView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.selectedViewMode == 2) return 1;
    return self.accessoryLocations.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.selectedViewMode == 2) return self.filteredAccessories.count;
    
    id loc = self.accessoryLocations[section];
    return [self accessoriesInLocation: loc].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VTDashboardCell* c = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath: indexPath];
    [c prepareForReuse];
    
    NSDictionary* accessory;
    if (self.selectedViewMode == 2) {
        accessory = self.filteredAccessories[indexPath.item];
        c.layer.borderColor = [UIColor lightGrayColor].CGColor;
        c.layer.borderWidth = 1;
    } else {
        id loc = self.accessoryLocations[indexPath.section];
        accessory = [self accessoriesInLocation: loc][indexPath.item];
        c.layer.borderColor = [UIColor clearColor].CGColor;
        c.layer.borderWidth = 0;
    }
    
    CGFloat s = self.view.bounds.size.width/3;
    c.cellImageView.layer.cornerRadius = (s - 10)/2;
    UIColor* color = [UIColor blackColor];
    if ([accessory[@"type"] isEqualToString: @"light"]) {
        color = [UIColor blueColor];
    } else if ([accessory[@"type"] isEqualToString: @"motion"]) {
        color = [UIColor redColor];
    } else if ([accessory[@"type"] isEqualToString: @"contact"]) {
        color = [UIColor greenColor];
    }
    c.cellImageView.backgroundColor = color;
    c.cellTitleLabel.text = accessory[@"name"];
    
    return c;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    VTDashboardSectionHeaderView* v = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier: @"sectionHeader" forIndexPath: indexPath];
    
    id loc = self.accessoryLocations[indexPath.section];
    v.sectionTitleLabel.text = loc;
    
    return v;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.selectedViewMode == 2) return CGSizeZero;
    return CGSizeMake(CGRectGetWidth(collectionView.bounds), 44);
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id loc = self.accessoryLocations[indexPath.section];
    NSDictionary* accessory = [self accessoriesInLocation: loc][indexPath.item];
    
    if ([accessory[@"type"] isEqualToString: @"group"]) {
        UIStoryboard* sb = [UIStoryboard storyboardWithName: @"GroupDetail" bundle: nil];
        VTGroupDetailVC* vc = [sb instantiateInitialViewController];
        vc.group = accessory;
        [self.navigationController pushViewController: vc animated: YES];
    } else {
        UIStoryboard* sb = nil;
        VTAccessoryDetailVC* vc = nil;
        if ([accessory[@"type"] isEqualToString: @"switch"]) {
            sb = [UIStoryboard storyboardWithName: @"SwitchAccessoryDetail" bundle: nil];
            vc = [sb instantiateViewControllerWithIdentifier: @"SwitchDetailVC"];
        } else if ([accessory[@"type"] isEqualToString: @"light"]) {
            sb = [UIStoryboard storyboardWithName: @"LightAccessoryDetail" bundle: nil];
            vc = [sb instantiateInitialViewController];
        } else if ([accessory[@"type"] isEqualToString: @"motion"]) {
            sb = [UIStoryboard storyboardWithName: @"MotionSensorAccessoryDetail" bundle: nil];
            vc = [sb instantiateInitialViewController];
        } else {
            sb = [UIStoryboard storyboardWithName: @"AccessoryDetail" bundle: nil];
            vc = [sb instantiateInitialViewController];
        }
        
        vc.accessory = accessory;
        [self.navigationController pushViewController: vc animated: YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat s = self.view.bounds.size.width/3;
    return CGSizeMake(s, s + 20);
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

-(IBAction)doAddDevice
{
    UIStoryboard* sb = [UIStoryboard storyboardWithName: @"AddDevice" bundle: nil];
    UIViewController* vc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController: vc animated: YES];
}

-(IBAction)doChangeView
{
    [self performSegueWithIdentifier: @"showViewChooserPopoverSegue" sender: self];
}

#pragma mark - Life Cycle

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"showViewChooserPopoverSegue"]) {
        VTViewChooserPopover* vc = segue.destinationViewController;
        vc.modalPresentationStyle = UIModalPresentationPopover;
        vc.popoverPresentationController.delegate = self;
        vc.delegate = self;
        vc.popoverPresentationController.sourceView = self.view;
        vc.popoverPresentationController.sourceRect = CGRectMake(self.view.bounds.size.width-220, 50, 200, 300);
        vc.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.collectionView reloadData];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.accessories =
  @[
    @{@"type": @"light",
      @"udid": @"xxx",
      @"firmware": @"1.2",
      @"name": @"Light 1",
      @"aid": @1,
      @"location": @"Bedroom"},
    @{@"type": @"light",
      @"udid": @"xxx",
      @"firmware": @"1.2",
      @"name": @"Light 2",
      @"aid": @2,
      @"location": @"Bedroom"},
    @{@"type": @"motion",
      @"udid": @"xxx",
      @"firmware": @"1.2",
      @"name": @"Motion 1",
      @"aid": @3,
      @"location": @"Kitchen"},
    @{@"type": @"garage",
      @"udid": @"xxx",
      @"firmware": @"1.2",
      @"name": @"Garage 1",
      @"aid": @4,
      @"location": @"Living Room"},
    @{@"type": @"contact",
      @"udid": @"xxx",
      @"firmware": @"1.2",
      @"name": @"Contact 1",
      @"aid": @5,
      @"location": @"Living Room"},
    @{@"type": @"switch",
      @"udid": @"xxx",
      @"firmware": @"1.2",
      @"name": @"Switch 1",
      @"aid": @6,
      @"location": @"Living Room"},
    @{@"type": @"light",
      @"udid": @"xxx",
      @"firmware": @"1.2",
      @"name": @"Light 3",
      @"aid": @7,
      @"location": @"Living Room"},
    @{@"type": @"group",
      @"udid": @"xxx",
      @"firmware": @"1.2",
      @"name": @"Group 1",
      @"aid": @8,
      @"location": @"Bedroom",
      @"lights": @[
              @{@"name": @"Light 1",
                @"type": @"light"},
              @{@"name": @"Light 2",
                @"type": @"light"},
              @{@"name": @"Light 3",
                @"type": @"light"},
              @{@"name": @"Light 4",
                @"type": @"light"}
              ]
      }
    ];
    self.navigationController.navigationBar.translucent = NO;
    self.slidingViewController.defaultTransitionDuration = 0.1;
    
    UIView* v = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 88, 44)];
    UIButton* btn = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 44, 44)];
    [btn setImage: [UIImage imageNamed: @"ic_check"] forState: UIControlStateNormal];
    [btn addTarget: self action: @selector(doChangeView) forControlEvents: UIControlEventTouchUpInside];
    [v addSubview: btn];
    
    btn = [[UIButton alloc] initWithFrame: CGRectMake(44, 0, 44, 44)];
    [btn setTitle: @"+" forState: UIControlStateNormal];
    [btn setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
    [btn addTarget: self action: @selector(doAddDevice) forControlEvents: UIControlEventTouchUpInside];
    [v addSubview: btn];
    
    UIBarButtonItem* it = [[UIBarButtonItem alloc] initWithCustomView: v];
    self.navigationItem.rightBarButtonItem = it;
    self.navigationItem.title = self.device[@"name"];
}

@end
