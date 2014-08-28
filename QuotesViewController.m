//
//  QuotesViewController.m
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 8/28/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import "QuotesViewController.h"

@interface QuotesViewController ()
@property (weak) IBOutlet UIWebView *webView;

@end

@implementation QuotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Temple Spotlight" ofType:@"htm" inDirectory:@"www"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
