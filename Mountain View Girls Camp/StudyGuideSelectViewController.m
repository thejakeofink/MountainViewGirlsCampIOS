//
//  StudyGuideSelectViewController.m
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 8/27/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import "StudyGuideSelectViewController.h"
#import "StudyGuideViewController.h"

@interface StudyGuideSelectViewController ()

@end

@implementation StudyGuideSelectViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PersonalRevelation"]) {
        StudyGuideViewController *ViewController = segue.destinationViewController;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PersonalRevelationTempleStudyGuide" ofType:@"htm" inDirectory:@"www"];
        
        ViewController.studyGuideLocation = path;
    }
    else if ([segue.identifier isEqualToString:@"Temptation"]) {
        StudyGuideViewController *ViewController = segue.destinationViewController;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TemptationStudyGuide" ofType:@"htm" inDirectory:@"www"];
        
        ViewController.studyGuideLocation = path;
    }
    else if ([segue.identifier isEqualToString:@"FaithFriendships"]) {
        StudyGuideViewController *ViewController = segue.destinationViewController;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"FaithFriendshipsStudyGuide" ofType:@"htm" inDirectory:@"www"];
        
        ViewController.studyGuideLocation = path;
    }
    else if ([segue.identifier isEqualToString:@"YWTheme"]) {
        StudyGuideViewController *ViewController = segue.destinationViewController;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"YoungWomenThemeStudyGuide" ofType:@"htm" inDirectory:@"www"];
        
        ViewController.studyGuideLocation = path;
    }
}

@end
