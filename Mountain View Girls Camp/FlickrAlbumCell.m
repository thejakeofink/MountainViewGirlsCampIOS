//
//  FlickrAlbumCell.m
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 8/24/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import "FlickrAlbumCell.h"

@implementation FlickrAlbumCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *bgView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
        bgView.backgroundColor = [UIColor lightGrayColor];
        bgView.layer.borderColor = [[UIColor whiteColor] CGColor];
        bgView.layer.borderWidth = 4;
        self.selectedBackgroundView = bgView;
    }
    return self;
}

-(void) setName:(NSString *)name {
    
    if (![_albumName.text isEqualToString: name]) {
        _albumName.text = name;
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
