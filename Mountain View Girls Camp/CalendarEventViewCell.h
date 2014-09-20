//
//  CalendarEventViewCell.h
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 9/19/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarEvent;

@interface CalendarEventViewCell : UICollectionViewCell


@property (nonatomic, weak) CalendarEvent *event;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *location;


@end
