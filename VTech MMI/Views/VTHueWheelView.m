//
//  VTHueWheelView.m
//  VTech MMI
//
//  Created by David Lin on 12/10/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTHueWheelView.h"

@interface VTHueWheelView ()

@property (strong, nonatomic) UIPanGestureRecognizer* panGesture;
@property (weak, nonatomic) IBOutlet UIImageView* hueWheelImageView;
@property (weak, nonatomic) IBOutlet UIImageView* whiteCircleImageView;
@property (strong, nonatomic) id target;
@property (nonatomic) SEL action;

@end

@implementation VTHueWheelView

-(void)setHue:(double)hue
{
    _hue = hue;
    CGFloat theta = (hue - 180) / 180 * M_PI;
    CGFloat radius = self.hueWheelImageView.bounds.size.width/2 - 18;
    self.whiteCircleImageView.center =
    CGPointMake(self.hueWheelImageView.center.x + radius * cosf(theta),
                self.hueWheelImageView.center.y + radius * sinf(theta));
}

-(void)panned:(UIPanGestureRecognizer*)g
{
    if (g.state == UIGestureRecognizerStateChanged) {
        CGPoint pt = [g locationInView: g.view];
        CGFloat theta = atan2(pt.y - g.view.center.y, pt.x - g.view.center.x);
        // convert to degree, -PI => 0, PI => 360
        self.hue = (theta * 180 / M_PI) + 180;
        
        if (self.target) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector: self.action withObject: self];
#pragma clang diagnostic pop
        }
    }
}

-(void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}

-(void)startTrackingPanGesture
{
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(panned:)];
    [self.hueWheelImageView addGestureRecognizer: self.panGesture];
    [self bringSubviewToFront: self.whiteCircleImageView];
}

-(void)stopTrackingPanGesture
{
    [self.hueWheelImageView removeGestureRecognizer: self.panGesture];
}

@end
