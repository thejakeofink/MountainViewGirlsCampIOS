//
//  TriviaViewController.m
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 9/22/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import "TriviaViewController.h"
#import "TriviaQuestion.h"

@interface TriviaViewController ()

@property NSArray *quiz;
@property TriviaQuestion *currentQuestion;
@property int score;
@property(nonatomic, weak) IBOutlet UILabel *questionView;
@property(nonatomic, weak) IBOutlet UIButton *answer1;
@property(nonatomic, weak) IBOutlet UIButton *answer2;
@property(nonatomic, weak) IBOutlet UIButton *answer3;
@property(nonatomic, weak) IBOutlet UIButton *answer4;
@property(nonatomic, weak) IBOutlet UILabel *scoreLabel;


- (IBAction)done:(id) sender;
- (IBAction)answerSelected:(id)sender;

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
    
    NSArray *quizArray = [[NSArray alloc] initWithArray:[fileContents componentsSeparatedByString:@"\n*\n"]];
    
    NSMutableArray *questionsForQuiz = [@[] mutableCopy];
    
    for (NSString *question in quizArray) {
        NSArray *questionAnswers = [[NSArray alloc] initWithArray:[question componentsSeparatedByString:@"\n"]];
        
        [questionsForQuiz addObject:questionAnswers];
    }
    
    [self arrayRandomizer:questionsForQuiz];
    for (NSUInteger i = [questionsForQuiz count] - 1; i > 19; i--) {
        [questionsForQuiz removeObjectAtIndex:i];
    }
    
    NSMutableArray *finalList = [@[] mutableCopy];
    
    for (NSArray *array in questionsForQuiz) {
        TriviaQuestion *questionLoader = [[TriviaQuestion alloc] init];
        questionLoader.question = array[0];
        questionLoader.correctAnswer = array[1];
        questionLoader.answers = [NSMutableArray arrayWithObjects:array[1], array[2], array[3], array[4], nil];
        [self arrayRandomizer:questionLoader.answers];
        [finalList addObject:questionLoader];
    }
    
    self.quiz = finalList;
    
    [self loadFirstQuestion];
}

- (void) arrayRandomizer:(NSMutableArray *) array
{
    NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform(remainingCount);
        [array exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

- (void) loadFirstQuestion
{
    self.currentQuestion = self.quiz[0];
    [self populateQuestion];
}

- (void) populateQuestion
{
    [self.questionView setText:self.currentQuestion.question];
    [self.answer1 setTitle:self.currentQuestion.answers[0] forState:UIControlStateNormal];
    [self.answer2 setTitle:self.currentQuestion.answers[1] forState:UIControlStateNormal];
    [self.answer3 setTitle:self.currentQuestion.answers[2] forState:UIControlStateNormal];
    [self.answer4 setTitle:self.currentQuestion.answers[3] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) answerSelected:(id)sender
{
    if ([self.currentQuestion.correctAnswer isEqualToString:[sender currentTitle]])
    {
        [self increaseScore];
        [self loadNextQuestion];
    }
    else if ([@"Share" isEqualToString:[sender currentTitle]])
    {
        NSString *textToShare = [NSString stringWithFormat:@"I just played the Mountain View Girls Camp Temple Trivia game and my score was %d!!!", self.score];
        [self shareScore:textToShare];
    }
    else
    {
        [self loadNextQuestion];
    }
}

- (void) shareScore: (NSString *) textToShare
{
    NSArray *shareStuff = [[NSArray alloc] init];
    shareStuff = [shareStuff arrayByAddingObject:textToShare];
    UIActivityViewController *activityController = [[UIActivityViewController alloc]  initWithActivityItems:shareStuff applicationActivities:nil];
    activityController.completionHandler = ^(NSString *activityType, BOOL completed) {
        if (completed) {
            NSLog(@"Activity complete: %@", activityType);
            if ([activityType isEqualToString:UIActivityTypeSaveToCameraRoll]) {
                //                hasSavedPhoto = YES;
                NSLog(@"Your score has been saved.");
            }
            else if ([activityType isEqualToString:UIActivityTypeMail]) {
                NSLog(@"Your score has been sent.");
            }
            else if ([activityType isEqualToString:UIActivityTypePostToTwitter]) {
                NSLog(@"Your score has been tweeted.");
            }
            else if ([activityType isEqualToString:UIActivityTypePostToFacebook]) {
                NSLog(@"Your score has been posted.");
            }
            else if ([activityType isEqualToString:UIActivityTypeCopyToPasteboard]) {
                NSLog(@"Your score has been copied to the pasteboard.");
            }
            else if ([activityType isEqualToString:UIActivityTypeAssignToContact]) {
                NSLog(@"Contact Updated");
            }
            else if ([activityType isEqualToString:UIActivityTypePrint]) {
                NSLog(@"Your score has been sent to the printer.");
            }
            else
                NSLog(@"Done");
        }
    };
    if (activityController)
        [self presentViewController:activityController animated:YES completion:nil];
}

- (void) loadNextQuestion
{
    if ([self.quiz lastObject] != self.currentQuestion) {
        self.currentQuestion = [self.quiz objectAtIndex:[self.quiz indexOfObject:self.currentQuestion] + 1];
        [self populateQuestion];
    }
    else {
        [self loadShareScore];
    }
}

- (void) loadShareScore
{
    [self.questionView setText:@"Share your score!!!"];
    [self.answer1 setTitle:@"Share" forState:UIControlStateNormal];
    [self.answer2 setTitle:@"Share" forState:UIControlStateNormal];
    [self.answer3 setTitle:@"Share" forState:UIControlStateNormal];
    [self.answer4 setTitle:@"Share" forState:UIControlStateNormal];
}

- (void) increaseScore
{
    self.score += 5;
    [self.scoreLabel setText:[NSString stringWithFormat:@"%d",self.score]];
}

-(void)done:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
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
