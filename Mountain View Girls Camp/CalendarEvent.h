//
//  CalendarEvent.h
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 9/18/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarEvent : NSObject

@property(nonatomic) NSDate *date;
@property(nonatomic) long time;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *description;

@end
