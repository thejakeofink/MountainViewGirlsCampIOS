//
//  ViewController.h
//  Mountain View Girls Camp
//
//  Created by Jake Stokes on 8/1/14.
//  Copyright (c) 2014 Jake Stokes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) NSString *photosetID;

-(void)loadPhotos;
@end
