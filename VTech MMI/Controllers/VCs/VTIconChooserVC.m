//
//  VTIconChooserVC.m
//  VTech MMI
//
//  Created by David Lin on 12/9/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTIconChooserVC.h"
#import "VTIconChooserCell.h"

@interface VTIconChooserVC () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView* collectionView;

@end

@implementation VTIconChooserVC


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.iconNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VTIconChooserCell* c = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath: indexPath];
    [c prepareForReuse];
    
    NSString* iconName= self.iconNames[indexPath.item];
    
    c.iconImageView.image = [UIImage imageNamed: iconName];
    c.checkImageView.hidden = ![self.selectedIconName isEqualToString: iconName];
    
    return c;
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIconName = self.iconNames[indexPath.item];
    [collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat s = self.view.bounds.size.width/3;
    return CGSizeMake(s, s);
}

#pragma mark - UI Actions

-(IBAction)doDone
{
    if (self.selectedIconName) {
        [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"done", @"iconName": self.selectedIconName}];
    } else {
        [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"cancel"}];
    }
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
