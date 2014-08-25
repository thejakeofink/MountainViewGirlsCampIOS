//
//  FlickrAlbumCell.h
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 8/24/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrAlbumCell : UICollectionViewCell
@property (nonatomic, strong) IBOutlet UILabel *albumName;

-(void) setName:(NSString *)name;
@end
