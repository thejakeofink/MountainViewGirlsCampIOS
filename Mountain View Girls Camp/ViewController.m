//
//  ViewController.m
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 8/1/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import "ViewController.h"
#import "Flickr.h"
#import "FlickrPhoto.h"
#import "FlickrPhotoCell.h"
#import "FlickrPhotoHeaderView.h"
#import "FlickrPhotoViewController.h"
#import "MBProgressHUD.h"
#import "FDTakeController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate, FDTakeDelegate>
@property(nonatomic, weak) IBOutlet UIToolbar *toolbar;
@property(nonatomic, weak) IBOutlet UIBarButtonItem *shareButton;
@property(nonatomic, weak) IBOutlet UIBarButtonItem *addButton;

@property(nonatomic, strong) NSMutableDictionary *searchResults;
@property(nonatomic, strong) NSMutableArray *searches;
@property(nonatomic, strong) Flickr *flickr;

@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic) BOOL sharing;
@property(nonatomic, strong) NSMutableArray *selectedPhotos;

- (IBAction)shareButtonTapped:(id)sender;
- (IBAction)addButtonTapped:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork.png"]];
    
    self.searches = [@[] mutableCopy];
    self.searchResults = [@{} mutableCopy];
    self.flickr = [[Flickr alloc] init];
    
    self.takeController = [[FDTakeController alloc] init];
    self.takeController.delegate = self;
    
    self.selectedPhotos = [@[] mutableCopy];
    
    [self loadPhotosForPhotoSet: _photosetID];
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FlickrCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)shareButtonTapped:(id)sender {
    UIBarButtonItem *shareButton = (UIBarButtonItem *)sender;
    // 1
    if (!self.sharing) {
        self.sharing = YES;
        [shareButton setStyle:UIBarButtonItemStyleDone];
        [shareButton setTitle:@"Done"];
        [self.collectionView setAllowsMultipleSelection:YES];
    } else {
        // 2
        self.sharing = NO;
        [shareButton setStyle:UIBarButtonItemStyleBordered];
        [shareButton setTitle:@"Share"];
        [self.collectionView setAllowsMultipleSelection:NO];
        // 3
        if ([self.selectedPhotos count] > 0) {
            [self showShareStuff];
        }
        // 4
        for(NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
        [self.selectedPhotos removeAllObjects];
    }
}

-(IBAction)addButtonTapped:(id)sender
{
    [self.takeController takePhotoOrChooseFromLibrary];
}

-(void)loadPhotosForPhotoSet: (NSString *)albumID {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // 1
    [self.flickr retrievePhotosForSet: albumID completionBlock: (FlickrListCompletionBlock)^(NSString *photosetID, NSArray *results, NSError *error) {
        if(results && [results count] > 0) {
            // 2
            if(![self.searches containsObject:photosetID]) {
                NSLog(@"Found %d photos matching %@", [results count],photosetID);
                [self.searches insertObject:photosetID atIndex:0];
                self.searchResults[photosetID] = results; }
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
        
        NSMutableArray *toolbarButtons = [self.toolbar.items mutableCopy];
        
        if (![self.searches[0] isEqualToString:@"Uploads"])
        {
//            [toolbarButtons addObject:self.addButton];
//            [self.toolbar setItems:toolbarButtons animated:YES];
            [self.addButton setTitle:@""];
            NSMutableArray *toolbarButtons = [self.toolbar.items mutableCopy];
            [toolbarButtons removeObject:self.addButton];
            [self.toolbar setItems:toolbarButtons animated:YES];
            [self.toolbar layoutIfNeeded];
        }
    }];
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    NSString *searchTerm = self.searches[section];
    return [self.searchResults[searchTerm] count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return [self.searches count];
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
    NSString *searchTerm = self.searches[indexPath.section];
    cell.photo = self.searchResults[searchTerm] [indexPath.row];
    return cell;
}
// 4
- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                         UICollectionElementKindSectionHeader withReuseIdentifier:@"FlickrPhotoHeaderView" forIndexPath:indexPath];
    NSString *searchTerm = self.searches[indexPath.section];
    [headerView setSearchText:searchTerm];
    return headerView;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.sharing) {
        NSString *searchTerm = self.searches[indexPath.section];
        FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
        [self performSegueWithIdentifier:@"ShowFlickrPhoto" sender:photo];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    } else {
        NSString *searchTerm = self.searches[indexPath.section];
        FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
        [self.selectedPhotos addObject:photo];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sharing) {
        NSString *searchTerm = self.searches[indexPath.section];
        FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
        [self.selectedPhotos removeObject:photo];
    }
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *searchTerm = self.searches[indexPath.section];
    FlickrPhoto *photo = self.searchResults[searchTerm][indexPath.row];
    // 2
    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size : CGSizeMake(100, 100);
    retval.height += 35; retval.width += 35;
    return retval;
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowFlickrPhoto"]) {
        FlickrPhotoViewController *flickrPhotoViewController = segue.destinationViewController;
        flickrPhotoViewController.flickrPhoto = sender;
    }
}

-(void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    NSLog(@"We got a photo!");
}

-(void)showShareStuff {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableArray *pictures = [@[] mutableCopy];
    NSMutableArray *photosToShare = [@[] mutableCopy];
    NSArray *photos = self.searchResults[self.searches[0]];
    for (FlickrPhoto *flickrPhoto in photos) {
        for (FlickrPhoto *selectedPhoto in self.selectedPhotos) {
            if (flickrPhoto.photoID == selectedPhoto.photoID) {
                [pictures addObject:selectedPhoto];
            }
        }
    }
    
    [Flickr loadImagesForPhotos:pictures completionBlock:^(NSMutableArray *downloadedImages, NSError *error) {
        if (!error)
        {
            for (FlickrPhoto *photo in downloadedImages) {
                [pictures addObject:photo.largeImage];
            }
        } else {
            NSLog(@"This is an error");
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSArray *activityItems = pictures;
        UIActivityViewController *activityController = [[UIActivityViewController alloc]  initWithActivityItems:activityItems applicationActivities:nil];
        activityController.completionHandler = ^(NSString *activityType, BOOL completed) {
            if (completed) {
                NSLog(@"Activity complete: %@", activityType);
                if ([activityType isEqualToString:UIActivityTypeSaveToCameraRoll]) {
                    //                hasSavedPhoto = YES;
                    NSLog(@"Your photo has been saved.");
                }
                else if ([activityType isEqualToString:UIActivityTypeMail]) {
                    NSLog(@"Your email has been sent.");
                }
                else if ([activityType isEqualToString:UIActivityTypePostToTwitter]) {
                    NSLog(@"Your tweet has been sent.");
                }
                else if ([activityType isEqualToString:UIActivityTypePostToFacebook]) {
                    NSLog(@"Your photo has been posted.");
                }
                else if ([activityType isEqualToString:UIActivityTypeCopyToPasteboard]) {
                    NSLog(@"Your photo has been copied to the pasteboard.");
                }
                else if ([activityType isEqualToString:UIActivityTypeAssignToContact]) {
                    NSLog(@"Contact Updated");
                }
                else if ([activityType isEqualToString:UIActivityTypePrint]) {
                    NSLog(@"Your photo has been sent to the printer.");
                }
                else
                    NSLog(@"Done");
            }
        };
        if (activityController)
            [self presentViewController:activityController animated:YES completion:nil];
        
    }];
    
    
}


-(void)showMailComposerAndSend {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:@"Check out these Flickr Photos"];
        NSMutableString *emailBody = [NSMutableString string];
        for(FlickrPhoto *flickrPhoto in self.selectedPhotos)
        {
            NSString *url = [Flickr flickrPhotoURLForFlickrPhoto: flickrPhoto size:@"m"];
            [emailBody appendFormat:@"<div><img src='%@'></div><br>",url];
        }
        [mailer setMessageBody:emailBody isHTML:YES];
        [self presentViewController:mailer animated:YES completion:^{}];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail Failure" message:@"Your device doesn't support in-app email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)mailComposeController: (MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:^{}];
}

@end
