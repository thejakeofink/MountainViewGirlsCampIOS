//
//  FlickrPhotoCell.h
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 8/4/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class FlickrPhoto;
@interface FlickrPhotoCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) FlickrPhoto *photo;
@end
