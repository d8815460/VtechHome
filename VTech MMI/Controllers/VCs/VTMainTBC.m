//
//  VTMainTBC.m
//  VTech MMI
//
//  Created by David Lin on 12/2/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTMainTBC.h"
#import <BlocksKit/BlocksKit.h>

@interface VTMainTBC ()

@end

@implementation VTMainTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.viewControllers = [@[@"Dashboard", @"Activity", @"Task", @"Setting"] bk_map:^UIViewController*(NSString* name) {
        UIStoryboard* sb = [UIStoryboard storyboardWithName: name bundle: nil];
        UIViewController* vc = [sb instantiateInitialViewController];
        NSString*title = @{@"Dashboard": NSLocalizedString(@"Dashboard", @"Tab Bar Item"),
                           @"Activity": NSLocalizedString(@"Activity", @"Tab Bar Item"),
                           @"Task": NSLocalizedString(@"Task", @"Tab Bar Item"),
                           @"Setting": NSLocalizedString(@"Setting", @"Tab Bar Item"),
                           }[name];
        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle: title image: nil tag: 0];
        return vc;
    }];
}

@end
