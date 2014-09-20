//
//  CalendarDayColumnHeader.h
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 9/19/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarDayColumnHeader : UICollectionReusableView

@property (nonatomic, strong) NSDate *day;
@property (nonatomic, assign) BOOL currentDay;

@end
