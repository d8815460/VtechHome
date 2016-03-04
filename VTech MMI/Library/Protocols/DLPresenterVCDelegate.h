//
//  DLPresenterVCDelegate.h
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DLPresenterVCDelegate <NSObject>

// tell parent that we are done with modal, with optional return info
-(void)presenteeVC:(UIViewController*) vc didCompleteWithInfo:(NSDictionary*)info;

@end

