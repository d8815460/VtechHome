//
//  VTDashboardCell.h
//  VTech MMI
//
//  Created by David Lin on 12/9/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTDashboardCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView* cellImageView;
@property (weak, nonatomic) IBOutlet UILabel* cellTitleLabel;

@end
