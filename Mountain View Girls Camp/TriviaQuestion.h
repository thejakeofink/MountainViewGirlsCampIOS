//
//  TriviaQuestion.h
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 9/22/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TriviaQuestion : NSObject

@property(nonatomic, strong) NSString *question;
@property(nonatomic) NSInteger *questionID;
@property(nonatomic, strong) NSArray *answers;

@end
