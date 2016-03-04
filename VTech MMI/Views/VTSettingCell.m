//
//  VTSettingCell.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTSettingCell.h"

@implementation VTSettingCell

-(void)prepareForReuse
{
    [super prepareForReuse];
    self.settingSwitch.on = false;
    self.settingTitleLabel.text = nil;
}

@end
