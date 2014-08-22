//
//  Flickr.m
//  Flickr Search
//
//  Created by Brandon Trebitowski on 6/28/12.
//  Copyright (c) 2012 Brandon Trebitowski. All rights reserved.
//

#import "Flickr.h"
#import "FlickrPhoto.h"

#define kFlickrAPIKey @"f3b34fa4324967a8e889ae3c815c84a9"
#define user_id @"125836065@N02"

@implementation Flickr

+ (NSString *)flickrURLForPhotoSet:(NSString *) photosetID
{
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=%@&photoset_id=%@&per_page=20&format=json&nojsoncallback=1",kFlickrAPIKey, photosetID];
}

+ (NSString *)flickrPhotoURLForFlickrPhoto:(FlickrPhoto *) flickrPhoto size:(NSString *) size
{
    if(!size)
    {
        size = @"m";
    }
    return [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%d/%lld_%@_%@.jpg",flickrPhoto.farm,flickrPhoto.server,flickrPhoto.photoID,flickrPhoto.secret,size];
}

+ (NSString *)flickrListURLForAccount
{
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photosets.getList&api_key=%@&user_id=%@&format=json&nojsoncallback=1", kFlickrAPIKey, user_id];
}

- (void)searchFlickrForSets: (FlickrListCompletionBlock) completionBlock
{
    NSString *listURL = [Flickr flickrListURLForAccount];
    dispatch_queue_t firstQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(firstQueue, ^{
        NSError *listError = nil;
        NSString *listResultString = [NSString stringWithContentsOfURL:[NSURL URLWithString:listURL] encoding:NSUTF8StringEncoding error:(&listError)];
        
        if (listError != nil) {
        }
        else
        {
//            NSLog([NSString stringWithFormat:@"%@",listResultString]);
            // Parse JSON Response
            NSData *listJson = [listResultString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *listResultsDict = [NSJSONSerialization JSONObjectWithData:listJson options:kNilOptions error:&listError];
            
            if (listError != nil)
            {
                completionBlock(nil, nil,listError);
            }
            else
            {
                NSString * status = listResultsDict[@"stat"];
                if ([status isEqualToString:@"fail"]) {
                    NSError * error = [[NSError alloc] initWithDomain:@"FlickrList" code:0 userInfo:@{NSLocalizedFailureReasonErrorKey: listResultsDict[@"message"]}];
                    completionBlock(nil, nil, error);
                } else {
                    NSDictionary *photosets = [listResultsDict valueForKey:@"photosets"];
                    
                    NSArray *placeholder = [photosets valueForKey:@"photoset"];
                    
                    for (NSDictionary *photoset in placeholder) {
                        NSString *psID = [photoset valueForKey:@"id"];
                        [self retrievePhotosForSet:psID completionBlock:completionBlock];
                    }
                }
            }
        }
    });
    
}

- (void)retrievePhotosForSet:(NSString *) photosetID completionBlock:(FlickrListCompletionBlock)completionBlock
{
    NSString *searchURL = [Flickr flickrURLForPhotoSet:photosetID];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        NSError *error = nil;
        NSString *searchResultString = [NSString stringWithContentsOfURL:[NSURL URLWithString:searchURL] encoding:NSUTF8StringEncoding error:&error];
        if (error != nil)
        {
        }
        else
        {
            // Parse the JSON Response
            
            NSData *jsonData = [searchResultString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *searchResultsDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            if(error != nil)
            {
            }
            else
            {
                NSString * status = searchResultsDict[@"stat"];
                
                if ([status isEqualToString:@"fail"])
                {
                    NSError * error = [[NSError alloc] initWithDomain:@"FlickrSearch" code:0 userInfo:@{NSLocalizedFailureReasonErrorKey: searchResultsDict[@"message"]}];
                }
                else
                {
                    NSArray *objPhotos = searchResultsDict[@"photos"][@"photo"];
                    NSMutableArray *flickrPhotos = [@[] mutableCopy];
                    
                    for(NSMutableDictionary *objPhoto in objPhotos)
                    {
                        FlickrPhoto *photo = [[FlickrPhoto alloc] init];
                        photo.farm = [objPhoto[@"farm"] intValue];
                        photo.server = [objPhoto[@"server"] intValue];
                        photo.secret = objPhoto[@"secret"];
                        photo.photoID = [objPhoto[@"id"] longLongValue];
                        
                        
                        
                        NSString *searchURL = [Flickr flickrPhotoURLForFlickrPhoto:photo size:@"m"];
                        
                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL] options:0 error:&error];
                        
                        UIImage *image = [UIImage imageWithData:imageData];
                        
                        photo.thumbnail = image;
                        
                        [flickrPhotos addObject:photo];
                    }
                    completionBlock(photosetID, flickrPhotos, nil);
                }
            }
        }
    });

}



+ (void)loadImageForPhoto:(FlickrPhoto *)flickrPhoto thumbnail:(BOOL)thumbnail completionBlock:(FlickrPhotoCompletionBlock) completionBlock
{
    
    NSString *size = thumbnail ? @"m" : @"b";
    
    NSString *searchURL = [Flickr flickrPhotoURLForFlickrPhoto:flickrPhoto size:size];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSError *error = nil;
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:searchURL]
                                                  options:0
                                                    error:&error];
        if(error)
        {
            completionBlock(nil,error);
        }
        else
        {
            UIImage *image = [UIImage imageWithData:imageData];
            if([size isEqualToString:@"m"])
            {
                flickrPhoto.thumbnail = image;
            }
            else
            {
                flickrPhoto.largeImage = image;
            }
            completionBlock(image,nil);
        }
        
    });
}



@end
