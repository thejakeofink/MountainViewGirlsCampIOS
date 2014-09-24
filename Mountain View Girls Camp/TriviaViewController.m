//
//  TriviaViewController.m
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 9/22/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import "TriviaViewController.h"

@interface TriviaViewController ()

@property NSArray *quiz;

@end

@implementation TriviaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadQuiz];
}

- (void)loadQuiz
{
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *textFilePath = [bundle pathForResource:@"trivia" ofType:@"txt"];
    
    NSString *fileContents = [NSString stringWithContentsOfFile:textFilePath];
    
    NSArray *quizArray = [[NSArray alloc] initWithArray:[fileContents componentsSeparatedByString:@"*"]];
    
    NSMutableArray *questionsForQuiz = [@[] mutableCopy];
    
    for (NSString *question in quizArray) {
        NSArray *questionAnswers = [[NSArray alloc] initWithArray:[question componentsSeparatedByString:@"\n"]];
        
        [questionsForQuiz addObject:questionAnswers];
    }
    
    NSUInteger count = [questionsForQuiz count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform(remainingCount);
        [questionsForQuiz exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    
    for (NSUInteger i = [questionsForQuiz count] - 1; i > 19; i--) {
        [questionsForQuiz removeObjectAtIndex:i];
    }
    
    self.quiz = questionsForQuiz;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
