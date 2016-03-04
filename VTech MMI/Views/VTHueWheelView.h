//
//  VTHueWheelView.h
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTHueWheelView : UIView

@property (nonatomic) double hue; // in degree, 0~360.

-(void)startTrackingPanGesture;
-(void)stopTrackingPanGesture;
-(void)addTarget:(id)target action:(SEL)action;

@end
