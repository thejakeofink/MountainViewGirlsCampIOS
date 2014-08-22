//
//  Flickr.h
//  Flickr Search
//
//  Created by Brandon Trebitowski on 6/28/12.
//  Copyright (c) 2012 Brandon Trebitowski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlickrPhoto;

typedef void (^FlickrListCompletionBlock)(NSString *setID, NSArray *results, NSError *error);
typedef void (^FlickrPhotoCompletionBlock)(UIImage *photoImage, NSError *error);

@interface Flickr : NSObject

@property(strong) NSString *apiKey;

- (void)searchFlickrForSets: (FlickrListCompletionBlock) completionBlock;
+ (void)loadImageForPhoto:(FlickrPhoto *)flickrPhoto thumbnail:(BOOL)thumbnail completionBlock:(FlickrPhotoCompletionBlock) completionBlock;
+ (NSString *)flickrURLForPhotoSet:(NSString *) photosetID;
- (void)retrievePhotosForSet:(NSString *) photosetID completionBlock: (FlickrListCompletionBlock) completionBlock;
+ (NSString *)flickrListURLForAccount;
+ (NSString *)flickrPhotoURLForFlickrPhoto:(FlickrPhoto *) flickrPhoto size:(NSString *) size;

@end
