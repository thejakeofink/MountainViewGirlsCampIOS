//
//  TriviaAnswer.h
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 9/22/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TriviaAnswer : NSObject

@property(nonatomic, strong) NSString *answerText;
@property(nonatomic) NSInteger *questionID;
@property(nonatomic) BOOL isCorrectAnswer;

@end
