//
//  VTWebBrowserVC.h
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTBaseVC.h"

@interface VTWebBrowserVC : VTBaseVC

@property (weak, nonatomic) id<DLPresenterVCDelegate> delegate;
@property (strong, nonatomic) NSURL* url;

@end
