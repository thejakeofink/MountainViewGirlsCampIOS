//
//  CalendarViewController.m
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 9/16/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import "CalendarViewController.h"
#import "MSCollectionViewCalendarLayout.h"

@interface CalendarViewController () <MSCollectionViewDelegateCalendarLayout>

@property (nonatomic, strong) MSCollectionViewCalendarLayout *collectionViewCalendarLayout;

@end

@implementation CalendarViewController

- (id)init
{
    self.collectionViewCalendarLayout = [[MSCollectionViewCalendarLayout alloc] init];
    self.collectionViewCalendarLayout.delegate = self;
    self = [super initWithCollectionViewLayout:self.collectionViewCalendarLayout];
    return self;
}

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

#pragma mark - MSCollectionViewDelagateCalendarLayout

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout dayForSection:(NSInteger)section
{
    return nil;
}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout startTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSDate *)collectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout endTimeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSDate *)currentTimeComponentsForCollectionView:(UICollectionView *)collectionView layout:(MSCollectionViewCalendarLayout *)collectionViewCalendarLayout
{
    return [NSDate date];
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
