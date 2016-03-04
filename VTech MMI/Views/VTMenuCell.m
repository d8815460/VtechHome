//
//  VTMenuCell.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTMenuCell.h"

@implementation VTMenuCell

-(void)prepareForReuse
{
    [super prepareForReuse];
    self.menuTitleLabel.text = nil;
    self.menuIconImageView.image = nil;
}

@end
