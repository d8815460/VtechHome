//
//  VTWebBrowserVC.m
//  VTech MMI
//
//  Created by David Lin on 12/1/15.
//  Copyright © 2015 TUTK. All rights reserved.
//

#import "VTWebBrowserVC.h"

@interface VTWebBrowserVC ()

@property (weak, nonatomic) IBOutlet UIWebView* webView;

@end

@implementation VTWebBrowserVC

#pragma mark - UI Actions

-(IBAction)doGoBack
{
    [self.webView goBack];
}

-(IBAction)doGoForward
{
    [self.webView goForward];
}

-(IBAction)doClose
{
    [self.delegate presenteeVC: self didCompleteWithInfo: @{@"result": @"done"}];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest* request = [NSURLRequest requestWithURL: self.url];
    [self.webView loadRequest: request];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Close", @"Close View Controller") style:UIBarButtonItemStylePlain target: self action: @selector(doClose)];
}

@end
