//
//  AlbumSelectViewController.m
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 8/23/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import "AlbumSelectViewController.h"
#import "Flickr.h"
#import "FlickrAlbumCell.h"
#import "ViewController.h"
#import "MBProgressHUD.h"

@interface AlbumSelectViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) NSMutableArray *albums;
@property(nonatomic, strong) Flickr *flickr;

@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation AlbumSelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.flickr = [[Flickr alloc] init];
    
    [self loadAlbums];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadAlbums {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // 1
    [self.flickr searchFlickrForSets: (FlickrListCompletionBlock)^(NSString *photosetID, NSArray *results, NSError *error) {
        if(results && [results count] > 0) {
            // 2
            if(!self.albums) {
                NSLog(@"Found %d albums", [results count]);
                self.albums = [NSMutableArray arrayWithArray: results];
            }
            // 3
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        } else { // 1
            NSLog(@"What is our error? %@", error.userInfo);
            NSLog(@"Error searching Flickr: %@", error.localizedDescription);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.albums count];
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrAlbumCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickrAlbumNameCell" forIndexPath:indexPath];
    
    NSDictionary *album = self.albums[indexPath.row];
    NSDictionary *title = album[@"title"];
    
    [cell setName:title[@"_content"]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *album = self.albums[indexPath.row];
    NSString *albumID = album[@"id"];
    [self performSegueWithIdentifier:@"ShowFlickrAlbum" sender:albumID];
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark – UICollectionViewDelegateFlowLayout
// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 2
    CGSize retval = CGSizeMake(250, 100);
    retval.height += 35; retval.width += 35;
    return retval;
}

// 3
- (UIEdgeInsets)collectionView: (UICollectionView *) collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowFlickrAlbum"]) {
        ViewController *ViewController = segue.destinationViewController;
        ViewController.photosetID = sender;
    }
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
