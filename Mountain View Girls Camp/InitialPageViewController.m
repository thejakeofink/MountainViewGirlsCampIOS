//
//  InitialPageViewController.m
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 8/23/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import "InitialPageViewController.h"

@interface InitialPageViewController ()

@property(nonatomic, strong) IBOutlet UIButton *quoteButton;

@end

@implementation InitialPageViewController

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
    _quoteButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // you probably want to center it
    _quoteButton.titleLabel.textAlignment = NSTextAlignmentCenter; // if you want to
    [_quoteButton setTitle: @"Temple Quotes\nFrom the Blind Walk" forState: UIControlStateNormal];
    
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
