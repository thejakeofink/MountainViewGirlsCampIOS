//
//  CalendarTimeRowHeader.h
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 9/20/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarTimeRowHeader : UICollectionReusableView

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) NSDate *time;

@end
