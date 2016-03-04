//
//  VTSettingCell.h
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTSettingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* settingTitleLabel;
@property (weak, nonatomic) IBOutlet UISwitch* settingSwitch;

@end
