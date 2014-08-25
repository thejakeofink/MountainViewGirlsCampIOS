//
//  FlickrAlbumCell.m
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 8/24/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import "FlickrAlbumCell.h"

@implementation FlickrAlbumCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setName:(NSString *)name {
    
    if (![[_albumName currentTitle] isEqualToString: name]) {
        [_albumName setTitle:name forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
